# ASI Hero Regeneration Handoff - LP2994

You are processing exactly one 商品表 record.

Required governing skill:
- Read and use `/Users/vincent/.openclaw/workspace-logopress/skills/asi-product-image-generator/SKILL.md` before acting.
- Also read `.temp/asi_has_inquiry_manifest/worker_instructions.md`.
- The `asi-product-image-generator` skill is mandatory for ASI套图/image rules. Apply it for image type selection, logo cleanup, prompt constraints, acceptance/rejection, upload/readback, and final reporting.

Product:
- 产品编号: LP2994
- Record ID: recuYsACVI4xsE
- Base token: SF9ibzjI4a0YFJsDZtKcLvtbnfh
- Table ID: tbl3KNB7zP8EQ1d0
- Task type: hero/main image regeneration only

Live check:
- Fresh parent live-check file: `.temp/asi_has_inquiry_manifest/livecheck_LP2994_20260623_1753.json`
- 参考图片 token: `RX4KbDWBnosANpxC3kVcIOX9nWh`
- 白底图 token: `BRB8bDVwvoct4Zx15mFcwP8Fnkh`
- Current old hero/main token to replace: `LRjjbZ4zqoYf4XxLJ9LcFXtLntd` (`hero_main_LOGO-BK_codex.png`)
- Preserve existing non-hero 商品主图 tokens:
  - `IcvBbUzk8oUM8MxIDtkcogusn7e` (`lifestyle_fishing_codex.png`)
  - `B0TIbtDV5oimqyxcKLRcjm1OnDh` (`selling_point_foldable_codex.png`)
  - `JDxlbxvxwoQ0KZxRTG9cDNw7n0f` (`size_dimensions_codex.png`)
  - `QG17bRLvhozmDmxoK2UcvtKGnqe` (`material_detail_codex.png`)
  - `KvwmbUJceo3tPPxgOE2cWksVn3g` (`sku_colors_codex.png`)

Product context from live check:
- 产品名称: Portable Fishing Home Travel Collapsible Foldable Bucket
- 简要说明: Our portable folding bucket is made of safe materials, perfect for storing food. Rush service is availble.
- 产品颜色: custom color
- 产品材质: Polypropylene

Rules:
- Work only in `.temp/LP2994_hero_regen/`.
- Download only this product's current reference/white-background attachments as needed.
- Regenerate only the ASI hero/main image.
- Use Oracle first. Within Oracle, use ChatGPT/Gemini route policy from worker instructions.
- No Chinese text, prices, QR codes, watermarks, supplier/manufacturer/platform/contact/URL info in the image.
- Do not include product number, record ID, or internal IDs in image prompts or visible image text.
- Use at least one current product reference image.
- Upload the accepted hero image to `商品主图`.
- Remove only the old hero token listed above; preserve all non-hero `商品主图` tokens, `参考图片`, and `白底图`.
- Fresh readback is mandatory after upload/removal.
- Save prompts, upload responses, readbacks, and verification summary in the workspace.

Final report to parent must include:
- Product number and record ID.
- Generated output path(s).
- New uploaded hero token.
- Old hero token removed.
- Preserved non-hero tokens.
- Reference and white-background tokens retained.
- Fresh readback path and verification result.
- Any rejected attempts or blockers.
