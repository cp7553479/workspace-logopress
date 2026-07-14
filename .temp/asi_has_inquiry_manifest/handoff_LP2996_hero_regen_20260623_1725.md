# ASI Hero Regen Handoff: LP2996

You must use the `asi-product-image-generator` skill before doing any image work, and you must follow `.temp/asi_has_inquiry_manifest/worker_instructions.md` for ASI套图/image rules, routing, QA, upload, and readback. Treat the skill as the governing workflow, not optional background.

Scope: regenerate the ASI hero/main image only for this product. Do not batch or touch any other product.

- Product number: LP2996
- Record ID: recuYsACVI67WY
- Base token: SF9ibzjI4a0YFJsDZtKcLvtbnfh
- Table ID: tbl3KNB7zP8EQ1d0
- Workspace: `.temp/LP2996_hero_regen`
- Parent live-check file: `.temp/asi_has_inquiry_manifest/livecheck_LP2996_20260623_1721.json`

Product facts from live readback:
- Product name: Picnic crossbody double layer insulated lunch cooler bag
- Description: The Picnic Crossbody Double-Layer Insulated Cooler Bag is ideal for all kinds of outings and daily use. Rush service is available.
- Product type: Bags & Luggage
- Colors: Black, blue, red, orange, pink, wine red
- Material: Oxford
- Size: 25 x 16 x 23 cm

Current attachment tokens:
- `参考图片`: `VOQwbodHUomdsAxr4ABcJ6MYnbf` (`LP2996_clean_reference.png`)
- `白底图`: `G6BCbuWHKoHH7Nx200schypfn2e` (`LP2996_white_bg.png`)
- Existing non-hero `商品主图` tokens to preserve:
  - `FvfJbcjUKo9kM4xBN5mcZXK6nHb` (`LP2996_sku_chart.png`)
  - `MOB4bKHa6okN53xKZB5cWhHHnHg` (`LP2996_dimension.png`)
  - `WdYpblbGWoWQ4RxPsNnccgRenyf` (`LP2996_material_detail.png`)
  - `OGA1bdSiIofAe4xurHOc04u3nxb` (`LP2996_selling_point.png`)
  - `Ur1zb96Zeo0TB7xCsPncRYNZn8g` (`LP2996_lifestyle_scene.png`)
- Existing hero/main token to replace/remove after successful upload:
  - `SFogbRgH3ooRmbxlq95cLiahnkf` (`LP2996_hero_main.png`)

Required output:
- Generate one new ASI hero/main image using current product reference image(s) and the appropriate LogoPress logo asset.
- Use Oracle first for generation. Within Oracle, alternate ChatGPT/Gemini across attempts when needed. Use Codex image generation only after Oracle ChatGPT and Oracle Gemini are blocked or rejected with concrete evidence.
- Keep prompts in English. No Chinese text, prices, QR codes, watermarks, supplier/manufacturer/platform/contact/URL info, product number, record ID, or internal IDs visible in the image.
- Upload the accepted hero image to `商品主图`, remove only the old hero token listed above, preserve all non-hero `商品主图` tokens and the existing `参考图片` / `白底图` tokens.
- Save prompt, upload responses, final readback, verification summary, and any rejected-attempt notes in `.temp/LP2996_hero_regen`.

Final report to parent must include:
- Product number and record id
- Generated output path(s)
- Selected logo and generation route
- New uploaded token
- Old hero token removed
- Preserved non-hero tokens
- Retained `参考图片` and `白底图` tokens
- Fresh readback/verification file path
- Rejected attempts or blockers, if any
