@echo off
chcp 65001 >nul
REM 큐샵에 올라가 있는 기존 사진(메인 13장 + 품목 상세 172장 + 파비콘)을 images 폴더로 내려받습니다. (큐샵 해지 전에 실행)
cd /d "%~dp0"
if not exist images mkdir images
set B=https://cdn.qshop.ai/46788/gallery
call :get about.jpeg          md_e5611e152000b.jpeg
call :get slide1.png          md_de102da4b2aae.png
call :get slide2.jpeg         md_505af6fe2af25.jpeg
call :get slide3.png          md_370a46333df43.png
call :get partners.png        md_0fc125bdec8e9.png
call :get biz-rice.jpeg       md_706fbb8bbe29e.jpeg
call :get biz-machinery.jpeg  md_9df5804192a14.jpeg
call :get biz-wood.jpeg       md_6ed7426ef5772.jpeg
call :get biz-pellet.jpeg     md_52dc75bff51c7.jpeg
call :get biz-textile.jpeg    md_1789a9bb90850.jpeg
call :get biz-nutrients.png   md_cbec7e1478bf3.png
call :get biz-liquorice.png   md_3c8b6ecba943f.png
call :get biz-greenhouse.jpeg md_645d14022c090.jpeg
if not exist "images\biz" mkdir "images\biz"
if not exist "images\biz\rice" mkdir "images\biz\rice"
call :get "biz\rice\md_706fbb8bbe29e.jpeg" md_706fbb8bbe29e.jpeg
call :get "biz\rice\md_71497ced33dd8.jpeg" md_71497ced33dd8.jpeg
call :get "biz\rice\md_1a2cc1e60297c.jpeg" md_1a2cc1e60297c.jpeg
call :get "biz\rice\md_c0325aa6590a7.jpeg" md_c0325aa6590a7.jpeg
call :get "biz\rice\md_40ebafa4065c8.jpeg" md_40ebafa4065c8.jpeg
call :get "biz\rice\md_da015bbcff5c2.jpeg" md_da015bbcff5c2.jpeg
call :get "biz\rice\md_266d9d1d4b0ac.jpeg" md_266d9d1d4b0ac.jpeg
call :get "biz\rice\md_9814ac43be0f2.jpeg" md_9814ac43be0f2.jpeg
call :get "biz\rice\md_ea6c71493c01a.jpeg" md_ea6c71493c01a.jpeg
call :get "biz\rice\md_4012e16c29d18.jpeg" md_4012e16c29d18.jpeg
call :get "biz\rice\md_4e121c6eb708c.png" md_4e121c6eb708c.png
call :get "biz\rice\md_17f7c9f8efcae.jpeg" md_17f7c9f8efcae.jpeg
call :get "biz\rice\md_de0ff5d3e1c89.png" md_de0ff5d3e1c89.png
call :get "biz\rice\md_69fd59ed828be.jpeg" md_69fd59ed828be.jpeg
call :get "biz\rice\md_7fb713bc79518.png" md_7fb713bc79518.png
call :get "biz\rice\md_81e359f67a11d.png" md_81e359f67a11d.png
if not exist "images\biz\machinery" mkdir "images\biz\machinery"
call :get "biz\machinery\md_9df5804192a14.jpeg" md_9df5804192a14.jpeg
call :get "biz\machinery\md_a3c8d53ea6226.jpeg" md_a3c8d53ea6226.jpeg
call :get "biz\machinery\md_0ac69e494e1a2.jpeg" md_0ac69e494e1a2.jpeg
call :get "biz\machinery\md_0ae9c960dad0a.jpeg" md_0ae9c960dad0a.jpeg
call :get "biz\machinery\md_6a2331096384b.jpeg" md_6a2331096384b.jpeg
call :get "biz\machinery\md_a899d7aae2007.jpeg" md_a899d7aae2007.jpeg
call :get "biz\machinery\md_2ea44b0e6e8a1.jpeg" md_2ea44b0e6e8a1.jpeg
call :get "biz\machinery\md_74a90d4fd66d1.jpeg" md_74a90d4fd66d1.jpeg
call :get "biz\machinery\md_0df656c339773.jpeg" md_0df656c339773.jpeg
call :get "biz\machinery\md_52118b7ffc6b9.jpeg" md_52118b7ffc6b9.jpeg
call :get "biz\machinery\md_f80ef62288463.jpeg" md_f80ef62288463.jpeg
call :get "biz\machinery\md_d352890965f0d.jpeg" md_d352890965f0d.jpeg
call :get "biz\machinery\md_35c465855a42b.jpeg" md_35c465855a42b.jpeg
call :get "biz\machinery\md_16a9087410b72.png" md_16a9087410b72.png
call :get "biz\machinery\md_d63cda198ed93.png" md_d63cda198ed93.png
call :get "biz\machinery\md_81f762b61c2f7.png" md_81f762b61c2f7.png
call :get "biz\machinery\md_17b62c2215ca6.png" md_17b62c2215ca6.png
call :get "biz\machinery\md_7c3c830c5838b.png" md_7c3c830c5838b.png
call :get "biz\machinery\md_1efcb32b2d2be.png" md_1efcb32b2d2be.png
call :get "biz\machinery\md_c7a6eb2ea2028.png" md_c7a6eb2ea2028.png
call :get "biz\machinery\md_4b0a5699f720c.png" md_4b0a5699f720c.png
if not exist "images\biz\wood" mkdir "images\biz\wood"
call :get "biz\wood\md_6ed7426ef5772.jpeg" md_6ed7426ef5772.jpeg
call :get "biz\wood\md_623cf2b502e01.jpeg" md_623cf2b502e01.jpeg
call :get "biz\wood\md_19dd0c9e6864f.jpeg" md_19dd0c9e6864f.jpeg
call :get "biz\wood\md_2373214953000.jpeg" md_2373214953000.jpeg
call :get "biz\wood\md_bfd3ce8b1cfc7.jpeg" md_bfd3ce8b1cfc7.jpeg
call :get "biz\wood\md_5ebd9a148a401.jpeg" md_5ebd9a148a401.jpeg
call :get "biz\wood\md_23f49130ee7ec.jpeg" md_23f49130ee7ec.jpeg
call :get "biz\wood\md_e7fe08014bcea.jpeg" md_e7fe08014bcea.jpeg
call :get "biz\wood\md_947421f4d314d.jpeg" md_947421f4d314d.jpeg
call :get "biz\wood\md_e337155fff0ec.jpeg" md_e337155fff0ec.jpeg
call :get "biz\wood\md_61c9fd40aad33.jpeg" md_61c9fd40aad33.jpeg
call :get "biz\wood\md_89f04ad01e020.jpeg" md_89f04ad01e020.jpeg
call :get "biz\wood\md_76219e3db9a5a.jpeg" md_76219e3db9a5a.jpeg
call :get "biz\wood\md_96cfca4fd177b.jpeg" md_96cfca4fd177b.jpeg
call :get "biz\wood\md_ecf4a430d4771.jpeg" md_ecf4a430d4771.jpeg
call :get "biz\wood\md_e69843a53276b.jpeg" md_e69843a53276b.jpeg
call :get "biz\wood\md_ff0a2612c033c.jpeg" md_ff0a2612c033c.jpeg
call :get "biz\wood\md_7ed367b394f02.jpeg" md_7ed367b394f02.jpeg
call :get "biz\wood\md_6ae0073a463e1.jpeg" md_6ae0073a463e1.jpeg
call :get "biz\wood\md_7890487e6bc4f.jpeg" md_7890487e6bc4f.jpeg
call :get "biz\wood\md_1a71f8a27d33e.jpeg" md_1a71f8a27d33e.jpeg
call :get "biz\wood\md_965af72ba39ea.jpeg" md_965af72ba39ea.jpeg
call :get "biz\wood\md_5689e43719aa5.jpeg" md_5689e43719aa5.jpeg
call :get "biz\wood\md_01b2d39624a2a.jpeg" md_01b2d39624a2a.jpeg
call :get "biz\wood\md_53d17220f0473.jpeg" md_53d17220f0473.jpeg
call :get "biz\wood\md_6f899a972a929.jpeg" md_6f899a972a929.jpeg
call :get "biz\wood\md_392abb171ec75.jpeg" md_392abb171ec75.jpeg
call :get "biz\wood\md_0ee905029baec.jpeg" md_0ee905029baec.jpeg
call :get "biz\wood\md_d6b66822c078a.png" md_d6b66822c078a.png
call :get "biz\wood\md_94435e425849b.png" md_94435e425849b.png
call :get "biz\wood\md_71255342df7c4.jpeg" md_71255342df7c4.jpeg
call :get "biz\wood\md_5450bb79761f8.jpeg" md_5450bb79761f8.jpeg
call :get "biz\wood\md_bea4644e5849c.jpeg" md_bea4644e5849c.jpeg
call :get "biz\wood\md_b86a8478c19bb.jpeg" md_b86a8478c19bb.jpeg
call :get "biz\wood\md_84f8adf299ab5.jpeg" md_84f8adf299ab5.jpeg
call :get "biz\wood\md_0f44c6ee1512d.jpeg" md_0f44c6ee1512d.jpeg
call :get "biz\wood\md_1ccd98d1c197c.jpeg" md_1ccd98d1c197c.jpeg
call :get "biz\wood\md_75bc6bcac1854.jpeg" md_75bc6bcac1854.jpeg
if not exist "images\biz\pellet" mkdir "images\biz\pellet"
call :get "biz\pellet\md_52dc75bff51c7.jpeg" md_52dc75bff51c7.jpeg
call :get "biz\pellet\md_7f44c1bfc57c2.jpeg" md_7f44c1bfc57c2.jpeg
call :get "biz\pellet\md_1bedc3299d5bf.jpeg" md_1bedc3299d5bf.jpeg
call :get "biz\pellet\md_54c43a333d62f.jpeg" md_54c43a333d62f.jpeg
call :get "biz\pellet\md_323c7a5b03b06.jpeg" md_323c7a5b03b06.jpeg
call :get "biz\pellet\md_7826027e72f74.jpeg" md_7826027e72f74.jpeg
call :get "biz\pellet\md_a5b2a001ccb1a.jpeg" md_a5b2a001ccb1a.jpeg
call :get "biz\pellet\md_6ea680f42720b.jpeg" md_6ea680f42720b.jpeg
call :get "biz\pellet\md_a9609157c6fd9.png" md_a9609157c6fd9.png
call :get "biz\pellet\md_d77d6ccc4a1a3.png" md_d77d6ccc4a1a3.png
if not exist "images\biz\textile" mkdir "images\biz\textile"
call :get "biz\textile\md_1789a9bb90850.jpeg" md_1789a9bb90850.jpeg
call :get "biz\textile\md_f2defc9c85de6.jpeg" md_f2defc9c85de6.jpeg
call :get "biz\textile\md_84745f6441273.jpeg" md_84745f6441273.jpeg
call :get "biz\textile\md_c1708dee81e6c.jpeg" md_c1708dee81e6c.jpeg
call :get "biz\textile\md_5bc3e1580799d.jpeg" md_5bc3e1580799d.jpeg
call :get "biz\textile\md_9cca52a6cfc03.jpeg" md_9cca52a6cfc03.jpeg
call :get "biz\textile\md_dc93b76d82931.jpeg" md_dc93b76d82931.jpeg
call :get "biz\textile\md_03455ece577e3.jpeg" md_03455ece577e3.jpeg
call :get "biz\textile\md_0306226cc6750.jpeg" md_0306226cc6750.jpeg
call :get "biz\textile\md_4b2d9303b2d7e.jpeg" md_4b2d9303b2d7e.jpeg
call :get "biz\textile\md_b6ad30acbc3a4.jpeg" md_b6ad30acbc3a4.jpeg
call :get "biz\textile\md_d9bd697f2f48a.jpeg" md_d9bd697f2f48a.jpeg
call :get "biz\textile\md_dc143ebca096c.jpeg" md_dc143ebca096c.jpeg
call :get "biz\textile\md_f4a413835cb0d.jpeg" md_f4a413835cb0d.jpeg
call :get "biz\textile\md_2c5b47af21393.jpeg" md_2c5b47af21393.jpeg
call :get "biz\textile\md_b1604899a606a.jpeg" md_b1604899a606a.jpeg
call :get "biz\textile\md_1e0f7cd8b0d06.jpeg" md_1e0f7cd8b0d06.jpeg
call :get "biz\textile\md_e27b6c4a0602c.jpeg" md_e27b6c4a0602c.jpeg
call :get "biz\textile\md_48200da8bbd60.jpeg" md_48200da8bbd60.jpeg
call :get "biz\textile\md_b7fabcd74b31d.jpeg" md_b7fabcd74b31d.jpeg
call :get "biz\textile\md_3ece730526f01.jpeg" md_3ece730526f01.jpeg
if not exist "images\biz\nutrients" mkdir "images\biz\nutrients"
call :get "biz\nutrients\md_cbec7e1478bf3.png" md_cbec7e1478bf3.png
call :get "biz\nutrients\md_60cbfd1ff1571.png" md_60cbfd1ff1571.png
call :get "biz\nutrients\md_7d4cfbe07fe8f.jpeg" md_7d4cfbe07fe8f.jpeg
call :get "biz\nutrients\md_2078a090f8ffc.jpeg" md_2078a090f8ffc.jpeg
call :get "biz\nutrients\md_46d51f080cbb9.jpeg" md_46d51f080cbb9.jpeg
call :get "biz\nutrients\md_70d09e263ce75.jpeg" md_70d09e263ce75.jpeg
call :get "biz\nutrients\md_59ee1bd244ce3.jpeg" md_59ee1bd244ce3.jpeg
call :get "biz\nutrients\md_491481611fe69.jpeg" md_491481611fe69.jpeg
call :get "biz\nutrients\md_5811bddafc74b.jpeg" md_5811bddafc74b.jpeg
call :get "biz\nutrients\md_62eff6e251663.jpeg" md_62eff6e251663.jpeg
call :get "biz\nutrients\md_2fa7fcbb40d51.png" md_2fa7fcbb40d51.png
call :get "biz\nutrients\md_6582c04efbcaf.png" md_6582c04efbcaf.png
call :get "biz\nutrients\md_b147015773238.png" md_b147015773238.png
call :get "biz\nutrients\md_1281d916fc9fe.png" md_1281d916fc9fe.png
call :get "biz\nutrients\md_aaed9fbf89454.png" md_aaed9fbf89454.png
call :get "biz\nutrients\md_101c5f929617c.png" md_101c5f929617c.png
call :get "biz\nutrients\md_df11607b12601.jpeg" md_df11607b12601.jpeg
if not exist "images\biz\liquorice" mkdir "images\biz\liquorice"
call :get "biz\liquorice\md_3c8b6ecba943f.png" md_3c8b6ecba943f.png
call :get "biz\liquorice\md_ee653abf1bfec.jpeg" md_ee653abf1bfec.jpeg
call :get "biz\liquorice\md_0e96a70d2c77b.jpeg" md_0e96a70d2c77b.jpeg
call :get "biz\liquorice\md_9babf6cca8ccc.jpeg" md_9babf6cca8ccc.jpeg
call :get "biz\liquorice\md_c2a1428e7c60c.jpeg" md_c2a1428e7c60c.jpeg
call :get "biz\liquorice\md_78edc962b23c7.jpeg" md_78edc962b23c7.jpeg
call :get "biz\liquorice\md_daafcbc2419d2.jpeg" md_daafcbc2419d2.jpeg
call :get "biz\liquorice\md_ca437f01b4197.jpeg" md_ca437f01b4197.jpeg
call :get "biz\liquorice\md_efd0d1e1cea9d.jpeg" md_efd0d1e1cea9d.jpeg
call :get "biz\liquorice\md_b8f92932400ad.jpeg" md_b8f92932400ad.jpeg
call :get "biz\liquorice\md_0fe419e8c5a40.jpeg" md_0fe419e8c5a40.jpeg
call :get "biz\liquorice\md_73e18fa4926a3.jpeg" md_73e18fa4926a3.jpeg
call :get "biz\liquorice\md_8638f8bbf4b0d.jpeg" md_8638f8bbf4b0d.jpeg
call :get "biz\liquorice\md_cdfddebab3328.jpeg" md_cdfddebab3328.jpeg
call :get "biz\liquorice\md_aebe6423a8052.jpeg" md_aebe6423a8052.jpeg
call :get "biz\liquorice\md_ac3a54d6f6e25.jpeg" md_ac3a54d6f6e25.jpeg
call :get "biz\liquorice\md_9eabc9eb32186.jpeg" md_9eabc9eb32186.jpeg
call :get "biz\liquorice\md_64b10d55e88b3.jpeg" md_64b10d55e88b3.jpeg
call :get "biz\liquorice\md_38ebb1a03083f.jpeg" md_38ebb1a03083f.jpeg
call :get "biz\liquorice\md_302cc5b0aff12.png" md_302cc5b0aff12.png
call :get "biz\liquorice\md_4da28ad7a157e.png" md_4da28ad7a157e.png
if not exist "images\biz\greenhouse" mkdir "images\biz\greenhouse"
call :get "biz\greenhouse\md_645d14022c090.jpeg" md_645d14022c090.jpeg
call :get "biz\greenhouse\md_1251b432fa730.jpeg" md_1251b432fa730.jpeg
call :get "biz\greenhouse\md_eb5f9734162b3.jpeg" md_eb5f9734162b3.jpeg
call :get "biz\greenhouse\md_c326ce12167ef.jpeg" md_c326ce12167ef.jpeg
call :get "biz\greenhouse\md_5238c0d949ce2.jpeg" md_5238c0d949ce2.jpeg
call :get "biz\greenhouse\md_e7b1259e11967.jpeg" md_e7b1259e11967.jpeg
call :get "biz\greenhouse\md_513858c874112.jpeg" md_513858c874112.jpeg
call :get "biz\greenhouse\md_8742c248437cd.jpeg" md_8742c248437cd.jpeg
call :get "biz\greenhouse\md_4a42419bc20fd.jpeg" md_4a42419bc20fd.jpeg
call :get "biz\greenhouse\md_40958280ee9ae.jpeg" md_40958280ee9ae.jpeg
call :get "biz\greenhouse\md_233f016857720.jpeg" md_233f016857720.jpeg
call :get "biz\greenhouse\md_dd07d72515bd5.jpeg" md_dd07d72515bd5.jpeg
call :get "biz\greenhouse\md_d4e173a9eb536.jpeg" md_d4e173a9eb536.jpeg
call :get "biz\greenhouse\md_b14aa15d378d8.jpeg" md_b14aa15d378d8.jpeg
call :get "biz\greenhouse\md_4ffa4a06066bf.jpeg" md_4ffa4a06066bf.jpeg
call :get "biz\greenhouse\md_1bcb169168bcd.jpeg" md_1bcb169168bcd.jpeg
call :get "biz\greenhouse\md_bec690a92494f.jpeg" md_bec690a92494f.jpeg
call :get "biz\greenhouse\md_1f83d733e7635.jpeg" md_1f83d733e7635.jpeg
call :get "biz\greenhouse\md_7c7ccabcfdb6d.jpeg" md_7c7ccabcfdb6d.jpeg
call :get "biz\greenhouse\md_82fc6686cd913.jpeg" md_82fc6686cd913.jpeg
call :get "biz\greenhouse\md_8d28a049303d5.jpeg" md_8d28a049303d5.jpeg
call :get "biz\greenhouse\md_d46b52d7bd413.jpeg" md_d46b52d7bd413.jpeg
call :get "biz\greenhouse\md_c4c8cc43b049e.jpeg" md_c4c8cc43b049e.jpeg
call :get "biz\greenhouse\md_ff141baf6dbf7.jpeg" md_ff141baf6dbf7.jpeg
call :get "biz\greenhouse\md_db3b8ab25456b.jpeg" md_db3b8ab25456b.jpeg
call :get "biz\greenhouse\md_196b033625996.jpeg" md_196b033625996.jpeg
call :get "biz\greenhouse\md_9243890716d27.jpeg" md_9243890716d27.jpeg
call :get "biz\greenhouse\md_1796f3fe83405.jpeg" md_1796f3fe83405.jpeg
curl -fsSL -o images\partner-jntp.png "https://www.jntp.or.kr/template/resources/images/theme/base/header-logo-color.png" && echo OK partner-jntp.png
echo.
echo 완료. images 폴더를 확인하세요.
pause
goto :eof
:get
curl -fsSL -o "images\%~1" "%B%/%2/resize?v=w1920" && echo OK %~1 || echo 실패 %~1
goto :eof
