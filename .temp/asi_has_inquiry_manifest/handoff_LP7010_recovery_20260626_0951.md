# ASI Product Image Recovery Handoff - LP7010

You are recovering the ASI product image generation task for exactly one product record.

Mandatory governing workflow:
- You must read and use `/Users/vincent/.openclaw/workspace-logopress/skills/asi-product-image-generator/SKILL.md` before generating or accepting any ASI套图/product images.
- You must follow `.temp/asi_has_inquiry_manifest/worker_instructions.md` for worker routing, upload/readback, and image-generation rules.
- If `白底图` is empty, also read and use `/Users/vincent/.openclaw/workspace-logopress/skills/generate-white-background/SKILL.md`.
- For image generation, also read `/Users/vincent/.openclaw/skills/generate-image/SKILL.md`.

Assigned product:
- 产品编号: LP7010
- record_id: recv6hAEbSKu4Q
- Base token: SF9ibzjI4a0YFJsDZtKcLvtbnfh
- Table ID: tbl3KNB7zP8EQ1d0
- Product workspace: `.temp/LP7010_asi_recv6hAEbSKu4Q`
- Parent live readback: `.temp/asi_has_inquiry_manifest/live_record_LP7010_parent_20260626_0951.json`

Current parent verification:
- Previous LP7010 worker session failed and produced no files in `.temp/LP7010_asi_recv6hAEbSKu4Q`.
- Live Base readback at 2026-06-26 09:51 Asia/Shanghai shows:
  - `参考图片`: 1 attachment
  - `白底图`: empty
  - `商品主图`: empty
  - `Mark`: 有询单

Required output:
- Work only on LP7010 / recv6hAEbSKu4Q.
- Create or reuse `.temp/LP7010_asi_recv6hAEbSKu4Q` with `references/`, `outputs/`, and `uploads/`.
- Download the current reference image.
- Clean reference marks if any are present, preserving the product accurately.
- Generate and upload `白底图` first because it is empty.
- Generate valid ASI套图 images according to `asi-product-image-generator`.
- Upload final accepted images to `商品主图`.
- Read back the record after uploads and save the raw readback in the product workspace.
- Final answer must include product number, record id, generated files, uploaded fields/tokens, readback status, exact output paths for parent Feishu delivery, skipped image types, and any blockers.

Important route policy:
- Try Oracle first for every new image-generation attempt.
- Within Oracle, alternate ChatGPT and Gemini across images/attempts when possible.
- Use non-image-CLI Codex image generation only after Oracle ChatGPT and Oracle Gemini are both blocked or rejected with concrete evidence.
- Do not use image CLI.
- Do not use scripts or programmatic compositing for final product images.
- English prompts only; no Chinese text, no prices, no QR codes, no watermarks, no supplier/manufacturer/platform/contact/URL information.
- Every generated image must use at least one current LP7010 product reference image.
