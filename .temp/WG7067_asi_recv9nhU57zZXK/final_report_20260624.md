# WG7067 ASI Recovery Final Report

Product: WG7067
Record ID: recv9nhU57zZXK
Base token: SF9ibzjI4a0YFJsDZtKcLvtbnfh
Table ID: tbl3KNB7zP8EQ1d0

## Final Field Readback

- 参考图片: H5PnbcgwVodSLtxIFsCcUoYZnTd, WG7067_clean_no_logo_retry_no_sparkle.png
- 白底图: BOMvbv13Wovj9WxWtMrcUQ1Cndf, WG7067_white_background_strict.png
- 商品主图:
  - IkiCbssr9ozqaAxQzVrcGyQhnaf, WG7067_hero_main.png
  - Jjiyb2A9ZoOupux0gY0cLOiLnw3, WG7067_lifestyle_scene_chatgpt.png
  - NWCmb3DiMoVuRaxEHoqcx13Pnfh, WG7067_selling_point_gemini.png
  - KgVhbT36QohTedxwIYZcNARqnPc, WG7067_dimensions.png
  - BZY8bhlK6o8xYtxJNSLcKcEdnnd, WG7067_material_detail.png

Readback files:
- uploads/final_readback_raw_20260624.json
- uploads/final_readback_summary_20260624.json
- uploads/final_readback_record_get_20260624.txt

## Generated Files For Parent Feishu Delivery

- /Users/vincent/.openclaw/workspace-logopress/.temp/WG7067_asi_recv9nhU57zZXK/outputs/WG7067_white_background_strict.png
- /Users/vincent/.openclaw/workspace-logopress/.temp/WG7067_asi_recv9nhU57zZXK/outputs/WG7067_hero_main.png
- /Users/vincent/.openclaw/workspace-logopress/.temp/WG7067_asi_recv9nhU57zZXK/outputs/WG7067_lifestyle_scene_chatgpt.png
- /Users/vincent/.openclaw/workspace-logopress/.temp/WG7067_asi_recv9nhU57zZXK/outputs/WG7067_selling_point_gemini.png
- /Users/vincent/.openclaw/workspace-logopress/.temp/WG7067_asi_recv9nhU57zZXK/outputs/WG7067_dimensions.png
- /Users/vincent/.openclaw/workspace-logopress/.temp/WG7067_asi_recv9nhU57zZXK/outputs/WG7067_material_detail.png

## Accepted Image Types

- 白底图: uploaded to 白底图.
- 首图: uploaded to 商品主图.
- 场景图: uploaded to 商品主图.
- 卖点图: uploaded to 商品主图.
- 尺寸图: uploaded to 商品主图; record has reliable 16.9 inch length and 2 inch diameter.
- 材质工艺图: uploaded to 商品主图; record material is Wood and generated image shows wood grain and engraved texture.

## Skipped Types

- SKU 图: skipped because current live record only supports one confirmed product color (`natural`) and no reliable multiple SKU/color/style set is present.

## Route Notes And Rejections

- Oracle was tried first for generation. Image CLI was not used.
- White-background ChatGPT route failed with attachment `fetch failed`; log: logs/route_02_white_background_oracle_chatgpt.log.
- First Oracle Gemini white-background output was rejected because it simplified the product group to a single rolling pin; rejection log: logs/rejection_02_white_background_oracle_gemini.txt.
- First two Oracle Gemini scene outputs were rejected because they contained a bottom-right sparkle/generated-image mark; rejection logs: logs/rejection_03_lifestyle_scene_oracle_gemini.txt and logs/rejection_03b_lifestyle_scene_oracle_gemini.txt.
- Selling-point ChatGPT route failed with attachment `fetch failed`; log: logs/route_04_selling_point_oracle_chatgpt.log.
- Dimension route first command had an invalid two-word Oracle slug and did not start generation; retry log succeeded: logs/route_05_dimensions_oracle_gemini_retry.log.

## Upload Response Files

- uploads/upload_white_background_20260624.json
- uploads/upload_main_images_20260624.json

## Blockers

- No remaining blocker for WG7067.
