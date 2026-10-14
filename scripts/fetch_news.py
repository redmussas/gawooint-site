#!/usr/bin/env python3
"""오늘의 무역 뉴스 수집기 (GitHub Actions에서 하루 한 번 실행)

공개 뉴스 RSS(Google News 검색 피드)에서 국제정세·국제무역 관련 기사 제목을 모아
키워드 점수로 날짜별 핵심 기사만 골라 data/news.json 에 누적 저장합니다.
기사 본문은 가져오지 않고 제목·언론사·날짜·원문 링크만 저장합니다.
표준 라이브러리만 사용하므로 별도 설치가 필요 없습니다.

사용법
  python scripts/fetch_news.py                 # 최근 하루치 수집 후 기존 파일에 추가 (매일 자동 실행)
  python scripts/fetch_news.py --backfill 10   # 지난 10일치를 날짜별로 수집해 채우기
  python scripts/fetch_news.py --merge x.json  # 다른 곳에서 모은 기사 목록을 합치기
"""
import argparse, json, os, re, sys, time, urllib.parse, urllib.request
from datetime import datetime, timezone, timedelta
from email.utils import parsedate_to_datetime
import xml.etree.ElementTree as ET

PER_DAY = 6        # 언어별·날짜별로 남길 기사 수
KEEP_DAYS = 30     # 이 기간이 지난 기사는 파일에서 지움
PER_SOURCE = 2     # 하루에 같은 언론사 기사 최대 개수
FIRST_BACKFILL = 10  # 처음 실행(파일이 비어 있을 때) 자동으로 채울 지난 일수
# 자동 번역 기사 위주라 품질이 낮은 사이트는 제외
SOURCE_BLOCK = {"Vietnam.vn"}
KST = timezone(timedelta(hours=9))

FEED = {
    "ko": ("ko", "KR", "KR:ko"),
    "en": ("en-US", "US", "US:en"),
    "ru": ("ru", "RU", "RU:ru"),
}
# 분야: policy=무역정책·관세, world=국제정세·제재, cis=CIS·중앙아시아, logistics=물류·운임
QUERIES = {
    "ko": [
        ("policy", "수출 관세"), ("policy", "무역협정 OR 통상"),
        ("world", "제재 무역 OR 공급망"), ("cis", "우즈베키스탄 OR 카자흐스탄 OR 중앙아시아 수출"),
        ("cis", "러시아 무역 OR 러시아 수출"), ("logistics", "해상운임 OR 물류 OR 컨테이너선"),
        ("policy", "환율 수출기업"),
    ],
    "en": [
        ("policy", "tariffs trade"), ("world", "sanctions trade"), ("world", "supply chain global trade"),
        ("cis", "Uzbekistan OR Kazakhstan OR \"Central Asia\" trade"), ("logistics", "container shipping freight rates"),
        ("policy", "WTO OR \"trade deal\""),
    ],
    "ru": [
        ("cis", "Узбекистан экспорт"), ("cis", "Казахстан торговля"), ("cis", "Корея Узбекистан"),
        ("world", "санкции торговля"), ("policy", "пошлины импорт"), ("logistics", "логистика контейнер перевозки"),
    ],
}
KEYWORDS = {
    "ko": {"수출":3,"수입":2,"관세":3,"무역":3,"통상":3,"FTA":3,"제재":3,"공급망":2,"우즈베키스탄":4,"카자흐스탄":4,"중앙아시아":4,"러시아":2,"CIS":4,
           "환율":2,"운임":2,"물류":2,"해운":2,"WTO":2,"협정":2,"수출기업":2,"코트라":2,"KOTRA":2,"무역협회":2},
    "en": {"trade":3,"tariff":3,"tariffs":3,"export":3,"exports":3,"import":2,"sanction":3,"sanctions":3,"supply chain":2,"Uzbekistan":4,
           "Kazakhstan":4,"Central Asia":4,"Russia":2,"WTO":2,"freight":2,"shipping":2,"deal":1,"Korea":2},
    "ru": {"экспорт":3,"импорт":2,"торгов":3,"пошлин":3,"санкц":3,"Узбекистан":4,"Казахстан":4,"Центральн":3,"Корея":3,"логист":2,
           "перевоз":2,"ВЭД":3,"ЕАЭС":3,"тариф":2},
}
NOISE = re.compile(r"(주식|증시 마감|특징주|코인|연예|스포츠|부고|인사\]|게시판|footbal|soccer|celebrity|crypto|футбол|гороскоп|матч|торговл\w* людьми|human trafficking)", re.I)
CATWORDS = {
    "cis": ["우즈베키스탄","카자흐스탄","키르기스","타지키스탄","투르크메니스탄","중앙아시아","러시아","CIS","Uzbekistan","Kazakhstan","Kyrgyz","Tajikistan","Turkmenistan","Central Asia","Russia","Eurasian",
            "Узбекистан","Казахстан","Киргиз","Таджикистан","Туркменистан","Центральн","Росси","ЕАЭС","СНГ"],
    "logistics": ["운임","물류","해운","컨테이너","항만","선박","freight","shipping","container","logistics",r"\bports?\b","логист","перевоз","контейнер","фрахт",r"\bпорт(а|у|ы|ов)?\b"],
    "world": ["제재","전쟁","분쟁","공급망","지정학","sanction","war","conflict","geopolit","supply chain","санкц","конфликт","войн"],
}

def classify(title):
    for cat in ("cis", "logistics", "world"):
        if any(re.search(w, title, re.I) for w in CATWORDS[cat]):
            return cat
    return "policy"

def score_title(title, lang):
    return sum(w for k, w in KEYWORDS[lang].items() if k.lower() in title.lower())

def norm(t):
    return re.sub(r"[^0-9a-zA-Z가-힣а-яА-ЯёЁ]+", "", t).lower()[:60]

def fetch(url, tries=3):
    for i in range(tries):
        try:
            req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0 (GAWOO news bot; +https://www.gawooint.com)"})
            with urllib.request.urlopen(req, timeout=20) as r:
                return r.read()
        except Exception as e:
            print("fetch failed", url, e, file=sys.stderr)
            time.sleep(2 * (i + 1))
    return None

def parse_feed(raw, lang):
    """RSS → 점수가 있는 후보 기사 목록"""
    out = []
    try:
        root = ET.fromstring(raw)
    except ET.ParseError:
        return out
    for it in root.iter("item"):
        title = (it.findtext("title") or "").strip()
        link = (it.findtext("link") or "").strip()
        src_el = it.find("source")
        source = (src_el.text or "").strip() if src_el is not None else ""
        if source and title.endswith(" - " + source):
            title = title[: -len(" - " + source)].strip()
        try:
            pub = parsedate_to_datetime(it.findtext("pubDate") or "")
        except Exception:
            continue
        if not title or not link or NOISE.search(title) or source in SOURCE_BLOCK:
            continue
        s = score_title(title, lang)
        if s == 0:
            continue
        out.append({"title": title, "url": link, "source": source,
                    "date": pub.astimezone(timezone.utc).isoformat(),
                    "day": pub.astimezone(KST).strftime("%Y-%m-%d"),
                    "cat": classify(title), "score": s})
    return out

def query_url(lang, q, window):
    hl, gl, ceid = FEED[lang]
    return "https://news.google.com/rss/search?" + urllib.parse.urlencode({"q": f"{q} {window}", "hl": hl, "gl": gl, "ceid": ceid})

def gather(lang, window):
    cands = []
    for _cat, q in QUERIES[lang]:
        raw = fetch(query_url(lang, q, window))
        if raw:
            cands += parse_feed(raw, lang)
        time.sleep(0.6)
    return cands

def select(items):
    """언어별 기사 목록 → 날짜별 상위 PER_DAY개 (중복·언론사 편중 제거)"""
    best = {}
    for it in items:
        k = norm(it["title"])
        if k not in best or it.get("score", 0) > best[k].get("score", 0):
            best[k] = it
    by_day = {}
    for it in best.values():
        by_day.setdefault(it["day"], []).append(it)
    cutoff = (datetime.now(KST) - timedelta(days=KEEP_DAYS)).strftime("%Y-%m-%d")
    result = []
    for day, lst in by_day.items():
        if day < cutoff:
            continue
        picked, per_src = [], {}
        for it in sorted(lst, key=lambda x: (x.get("score", 0), x["date"]), reverse=True):
            if per_src.get(it["source"], 0) >= PER_SOURCE:
                continue
            per_src[it["source"]] = per_src.get(it["source"], 0) + 1
            picked.append(it)
            if len(picked) >= PER_DAY:
                break
        result += picked
    result.sort(key=lambda x: x["date"], reverse=True)
    return result

def load(path):
    try:
        with open(path, encoding="utf-8") as f:
            d = json.load(f)
        items = d.get("items", {})
        # 예전 형식(날짜 필드 없음) 호환
        for lang, lst in items.items():
            for it in lst:
                if "day" not in it:
                    it["day"] = datetime.fromisoformat(it["date"]).astimezone(KST).strftime("%Y-%m-%d")
                it.setdefault("score", 1)
        return items
    except Exception:
        return {}

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("out", nargs="?", default="data/news.json")
    ap.add_argument("--backfill", type=int, default=0, help="지난 N일치를 날짜별로 수집")
    ap.add_argument("--merge", default="", help="합칠 기사 목록 JSON ({lang:[...]})")
    a = ap.parse_args()

    items = load(a.out)
    new = {lang: [] for lang in QUERIES}
    if a.merge:
        with open(a.merge, encoding="utf-8") as f:
            extra = json.load(f)
        for lang in QUERIES:
            new[lang] += extra.get(lang, [])
    elif a.backfill or not any(items.values()):
        if not a.backfill:
            a.backfill = FIRST_BACKFILL
            print("empty news file -> first run, backfilling", a.backfill, "days")
        today = datetime.now(KST).date()
        for back in range(a.backfill, -1, -1):
            d0 = today - timedelta(days=back)
            window = f"after:{d0.isoformat()} before:{(d0 + timedelta(days=1)).isoformat()}"
            for lang in QUERIES:
                new[lang] += gather(lang, window)
            print("backfill", d0, {l: len(v) for l, v in new.items()})
    else:
        for lang in QUERIES:
            new[lang] = gather(lang, "when:1d")

    if not any(new.values()):
        print("no new items; keeping previous file", file=sys.stderr)
        return 0
    data = {"updated": datetime.now(timezone.utc).isoformat(), "keepDays": KEEP_DAYS, "items": {}}
    for lang in QUERIES:
        data["items"][lang] = select(items.get(lang, []) + new[lang])
        print(lang, len(data["items"][lang]), "items,", len({i["day"] for i in data["items"][lang]}), "days")
    os.makedirs(os.path.dirname(a.out) or ".", exist_ok=True)
    with open(a.out, "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=1)
    return 0

if __name__ == "__main__":
    sys.exit(main())
