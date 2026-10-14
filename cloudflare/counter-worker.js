// GAWOO INTERNATIONAL 방문자 카운터 (Cloudflare Worker + D1)
// - 같은 브라우저는 하루 한 번만 셉니다 (홈페이지 쪽에서 n=1을 하루 한 번만 보냄)
// - IP 등 개인정보는 저장하지 않고 날짜별 숫자만 저장합니다
// - D1 데이터베이스를 "DB"라는 이름으로 연결해야 합니다 (schema.sql 참고)

const ALLOWED = [
  "https://www.gawooint.com",
  "https://gawooint.com",
];

function kstDay() {
  // 한국시간 기준 날짜 (YYYY-MM-DD)
  return new Date(Date.now() + 9 * 3600 * 1000).toISOString().slice(0, 10);
}

function cors(origin) {
  const ok = ALLOWED.includes(origin) || /^https?:\/\/(localhost|127\.0\.0\.1)(:\d+)?$/.test(origin || "");
  return {
    "Access-Control-Allow-Origin": ok ? origin : ALLOWED[0],
    "Access-Control-Allow-Methods": "GET, OPTIONS",
    "Vary": "Origin",
    "Cache-Control": "no-store",
    "Content-Type": "application/json; charset=utf-8",
  };
}

export default {
  async fetch(request, env) {
    const url = new URL(request.url);
    const origin = request.headers.get("Origin") || "";
    const headers = cors(origin);
    if (request.method === "OPTIONS") return new Response(null, { headers });
    if (url.pathname !== "/hit") return new Response(JSON.stringify({ ok: true }), { headers });

    const day = kstDay();
    const isNew = url.searchParams.get("n") === "1";
    const allowedOrigin = ALLOWED.includes(origin) || /^https?:\/\/(localhost|127\.0\.0\.1)/.test(origin);

    if (isNew && allowedOrigin) {
      await env.DB.batch([
        env.DB.prepare("INSERT INTO visits (day, n) VALUES (?1, 1) ON CONFLICT(day) DO UPDATE SET n = n + 1").bind(day),
        env.DB.prepare("INSERT INTO visits (day, n) VALUES ('total', 1) ON CONFLICT(day) DO UPDATE SET n = n + 1"),
      ]);
    }
    const rows = await env.DB.prepare("SELECT day, n FROM visits WHERE day IN (?1, 'total')").bind(day).all();
    let today = 0, total = 0;
    for (const r of rows.results || []) { if (r.day === "total") total = r.n; else today = r.n; }
    return new Response(JSON.stringify({ today, total, day }), { headers });
  },
};
