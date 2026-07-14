# LP3426 Route Log

- Product: LP3426
- Record ID: recuYsANVGL5Ks
- Required route policy: try Oracle first for every new image-generation attempt; alternate ChatGPT and Gemini within Oracle when possible; use non-image-CLI Codex only after Oracle ChatGPT and Oracle Gemini are blocked or rejected with concrete evidence.

## Clean no-logo reference

- Oracle ChatGPT attempt: blocked. Command used `oracle --engine browser --model "5.5 Medium" --generate-image ... --file original_reference.jpeg`. Result: Oracle reported `No images generated`; ChatGPT response contained a preview file whose fetch failed (`file_00000000e1ec7207b646af23b4eea2fd: fetch failed`). Full log: `outputs/oracle_clean_chatgpt.log`.
- Oracle Gemini attempt: succeeded. Output: `outputs/LP3426_clean_no_logo_oracle_gemini.png`. Full log: `outputs/oracle_clean_gemini.log`.
- Reference upload/readback: uploaded clean reference token `XH7ubqB9aoMeaPxkuEKc3V17nPh`, removed original marked token `URJQbSZJgoCnQQxxlbUch7wnnbC`, readback confirmed only the clean PNG remains in `参考图片`.

## White-background image

- Oracle Gemini attempt: succeeded. Output: `outputs/LP3426_white_background_oracle_gemini.png`. Full log: `outputs/oracle_white_gemini.log`.
- White-background upload/readback: uploaded token `Jd3RblZmLo5dClxNvRtcAdACnig`, readback confirmed one image in `白底图`.

## Main images

- Scene image: accepted candidate `outputs/LP3426_scene_golf_use_oracle_gemini.png`.
- Selling point image v1: rejected. Output `outputs/LP3426_selling_points_oracle_gemini.png` added unsupported text/claims: "reels" and "Smudge-Free!" badge.
- Selling point image v2: accepted candidate `outputs/LP3426_selling_points_v2_oracle_gemini.png`.
- Dimension image: accepted candidate `outputs/LP3426_dimensions_oracle_gemini.png`.
- SKU image Oracle Gemini attempt: blocked. Command used `oracle --engine browser --model gemini-3.5-flash --generate-image ...`; result: `ERROR: fetch failed` before output file was saved. Full log: `outputs/oracle_sku_gemini.log`. Oracle ChatGPT image route had already been blocked by generated-preview fetch failure for this product, so SKU generation may use non-image-CLI Codex fallback.
- SKU image Codex fallback: accepted candidate `outputs/LP3426_sku_chart_codex.png`.
- Material detail image: accepted candidate `outputs/LP3426_material_detail_oracle_gemini.png`.
- Hero image Oracle Gemini v1: rejected. Output `outputs/LP3426_hero_logo_oracle_gemini.png` added an unsupported dark sleeve/panel and changed the reference product body structure.
- Hero image Codex fallback: accepted candidate `outputs/LP3426_hero_logo_codex.png`.

## Upload/readback final

- `参考图片`: 1 file, token `XH7ubqB9aoMeaPxkuEKc3V17nPh`, name `LP3426_clean_no_logo_oracle_gemini.png`.
- `白底图`: 1 file, token `Jd3RblZmLo5dClxNvRtcAdACnig`, name `LP3426_white_background_oracle_gemini.png`.
- `商品主图`: 6 files:
  - `PHarb24Nuo9MaFxzj7vc5RWZnRg` `LP3426_scene_golf_use_oracle_gemini.png`
  - `V319b6649ohG03xcI8ccfQ9cnQf` `LP3426_selling_points_v2_oracle_gemini.png`
  - `Ob7TbxYdEoQmN0xrxbXci0WRnIh` `LP3426_dimensions_oracle_gemini.png`
  - `FOKHbW5YMosvSPxLHD3cIp83ncc` `LP3426_sku_chart_codex.png`
  - `FVaIbupqaoJ2SmxdtrTcVrIMnK1` `LP3426_material_detail_oracle_gemini.png`
  - `XYeXbo1YOolC4IxksNjcid7qnmc` `LP3426_hero_logo_codex.png`
