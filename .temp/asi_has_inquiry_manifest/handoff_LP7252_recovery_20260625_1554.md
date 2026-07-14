# LP7252 ASI Product Image Recovery Handoff

You are assigned exactly one recovery job for LP7252 / recvcuSPFvlHGa.

Mandatory governing skill:
- You must read and use `/Users/vincent/.openclaw/workspace-logopress/skills/asi-product-image-generator/SKILL.md` before acting. Treat it as the governing ASI套图/image workflow for image types, logo/mark cleanup, prompt constraints, acceptance/rejection, upload/readback, and final reporting.
- Also read and follow `.temp/asi_has_inquiry_manifest/worker_instructions.md`.

Scope:
- Process only product LP7252, record `recvcuSPFvlHGa`.
- Base token: `SF9ibzjI4a0YFJsDZtKcLvtbnfh`
- Table ID: `tbl3KNB7zP8EQ1d0` (商品表)
- Product summary: magnetic clip-on flashlight / nurse light, silicone, colors blue/pink/red/white/light green, size 16.5 x 3.5 x 1.3 cm.
- Workspace: `.temp/LP7252_asi_recvcuSPFvlHGa`

Current verified state from parent heartbeat:
- Previous worker session `agent:global-trading-product:subagent:5b074b24-b042-40c6-9b2d-0badd97e0082`, run `9e06f5a5-b19f-4b88-87dd-5f23efa0f53c`, failed/inactive.
- Base readback at `.temp/asi_has_inquiry_manifest/live_record_LP7252_heartbeat_20260625_1551.json` shows:
  - `参考图片`: 1 cleaned image, `clean_reference_chatgpt.png`
  - `白底图`: 1 image, `white_background_codex.png`
  - `商品主图`: empty
  - `Mark`: 有询单
- Existing local outputs include:
  - `.temp/LP7252_asi_recvcuSPFvlHGa/outputs/clean_reference_chatgpt.png`
  - `.temp/LP7252_asi_recvcuSPFvlHGa/outputs/white_background_codex.png`
  - `.temp/LP7252_asi_recvcuSPFvlHGa/outputs/lifestyle_chatgpt.png`
  - `.temp/LP7252_asi_recvcuSPFvlHGa/outputs/selling_point_chatgpt.png`
  - `.temp/LP7252_asi_recvcuSPFvlHGa/outputs/dimension_chatgpt.png`
  - `.temp/LP7252_asi_recvcuSPFvlHGa/outputs/material_chatgpt.png`
  - `.temp/LP7252_asi_recvcuSPFvlHGa/outputs/sku_codex.png`

Required recovery work:
1. Inspect the existing local output images against the ASI skill acceptance rules and the product facts. Reject any image that invents unsupported features, has bad text, bad structure, or violates ASI/product-image rules.
2. Generate the missing hero/main ASI image if no acceptable hero image exists. Try Oracle first and alternate ChatGPT/Gemini where possible. Use non-image-CLI Codex generation only after Oracle routes are blocked or rejected with evidence.
3. Upload accepted ASI final images to `商品主图`. Include the accepted existing images only if they pass inspection.
4. Read back `参考图片`, `白底图`, and `商品主图` after upload.
5. Write a final report in the workspace with product number, record id, accepted uploaded files, final readback path/counts, rejected/skipped notes, blockers if any, and output paths for the parent to send to Feishu.

Route and safety constraints:
- Do not use image CLI.
- Do not use scripts or programmatic compositing for final product images.
- English prompts only. No Chinese text in images.
- No prices, QR codes, watermarks, supplier/manufacturer/platform/contact/URL information.
- Do not include product number, record ID, or internal IDs in image prompts or visible image text.
- Every new generation must use at least one current product reference image.
- Do not batch or touch any other products.

Parent delivery note:
- Native workers do not need to send Feishu messages. Return local output paths and final readback evidence so the parent can verify and deliver.
