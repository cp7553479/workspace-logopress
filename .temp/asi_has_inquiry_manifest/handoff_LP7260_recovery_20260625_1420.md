# ASI Product Image Recovery Handoff: LP7260

Product number: LP7260
Record ID: recvcuSRzhTNq0
Workspace: `.temp/LP7260_asi_recvcuSRzhTNq0/`

Base:
- Base token: `SF9ibzjI4a0YFJsDZtKcLvtbnfh`
- Table ID: `tbl3KNB7zP8EQ1d0`

You are recovering a partially completed ASI product-image task. Process exactly this one product record only.

Required instructions:
1. Use the `asi-product-image-generator` skill as the governing workflow for ASI套图/image rules.
2. Read and follow `/Users/vincent/.openclaw/workspace-logopress/skills/asi-product-image-generator/SKILL.md` before acting.
3. Read and follow `.temp/asi_has_inquiry_manifest/worker_instructions.md`.
4. Read `/Users/vincent/.openclaw/skills/generate-image/SKILL.md` and follow the current image-generation route rules in the worker instructions.

Known current state, already verified by parent:
- `参考图片` now contains exactly one cleaned reference attachment: `clean_no_logo_reference_oracle_chatgpt.png`.
- `白底图` now contains exactly one white-background attachment: `white_background_oracle_gemini.png`.
- `商品主图` is still empty.
- Existing local files:
  - `.temp/LP7260_asi_recvcuSRzhTNq0/outputs/clean_no_logo_reference_oracle_chatgpt.png`
  - `.temp/LP7260_asi_recvcuSRzhTNq0/outputs/white_background_oracle_gemini.png`
  - `.temp/LP7260_asi_recvcuSRzhTNq0/readbacks/record_after_white_raw.json`
  - `.temp/LP7260_asi_recvcuSRzhTNq0/routes/oracle_route_log.md`
- The earlier worker lost execution context after completing clean-reference and white-background steps.

Product facts:
- Product name: Portable travel toiletry organizer puffy quilted makeup bag
- Summary: puffy quilted cosmetic bag, spill-proof organization for travel essentials
- Colors from record: white, black, pink, light brown, brown, blue, dark pink, green
- Material: Cotton
- Size: 26.5 x 16.5 x 5.5 cm
- Imprint methods: Full color / Silkscreen / Unimprinted

Recovery scope:
- Do not process any other product.
- Do not re-download or re-clean the original reference unless you discover the current cleaned reference is unusable.
- Do not remove or replace the already uploaded `参考图片` or `白底图` unless there is a clear acceptance failure and you document it.
- Continue from ASI main-image generation only.
- Generate valid ASI `商品主图` images according to the ASI skill: lifestyle scene, selling point, dimension chart, material/detail, SKU/color chart if reliably supported, and hero main image last.
- Upload every accepted final ASI image to `商品主图`.
- Save prompts, route logs, upload responses, and final readback inside `.temp/LP7260_asi_recvcuSRzhTNq0/`.
- Final answer must include generated files, uploaded fields, final readback status, absolute output paths for parent Feishu delivery, skipped image types, rejected images, and blockers if any.

Critical image rules:
- Use English prompts only.
- Every image must be 1:1.
- No Chinese text, prices, QR codes, watermarks, supplier/manufacturer/platform/contact/URL information.
- Do not include product number, record ID, or internal IDs in visible image text.
- Do not use scripts, image processing, or programmatic compositing for final product images or logo placement.
- Do not use image CLI.
- Try Oracle first for every generation attempt and alternate ChatGPT/Gemini where possible. Use non-image-CLI Codex image generation only after both Oracle paths are blocked or rejected with concrete evidence.
- Every generation must use at least one current LP7260 reference image. Hero must include the appropriate LogoPress logo file reference and must be generated last.
