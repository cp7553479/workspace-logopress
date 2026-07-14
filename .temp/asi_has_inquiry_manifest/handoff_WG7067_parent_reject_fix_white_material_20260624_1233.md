# WG7067 parent-rejected image correction

Process exactly one product:
- Product number: WG7067
- Record ID: recv9nhU57zZXK
- Base token: SF9ibzjI4a0YFJsDZtKcLvtbnfh
- Table: 商品表
- Table ID: tbl3KNB7zP8EQ1d0
- Workspace: `.temp/WG7067_asi_recv9nhU57zZXK`

Mandatory governing instructions:
- Read and follow `.temp/asi_has_inquiry_manifest/worker_instructions.md`.
- Read and use `skills/asi-product-image-generator/SKILL.md` as the governing ASI套图/image workflow.
- Read and follow `skills/generate-white-background/SKILL.md` because the current uploaded white-background image was parent-rejected and must be replaced.
- Read the current available generate-image skill before generating images.
- Do not use image CLI for generation or fallback.
- Try Oracle first for every generation. Alternate Oracle ChatGPT and Oracle Gemini where possible.
- If both Oracle routes are blocked or rejected, only then use a non-image-CLI reference-capable Codex route.
- Do not use scripts, image processing code, compositing, paste-over, local patching, local cleanup, or perspective transforms for final images.
- Every generated final image must use current product reference images and English prompts.
- No Chinese text, price, QR code, watermark, supplier/manufacturer/platform/contact/URL information, or extra decorative marks.

Current verified Base state after previous worker:
- `参考图片`: clean accepted token `H5PnbcgwVodSLtxIFsCcUoYZnTd`, file `WG7067_clean_no_logo_retry_no_sparkle.png`.
- `白底图`: token `BOMvbv13Wovj9WxWtMrcUQ1Cndf`, file `WG7067_white_background_strict.png`. Parent rejected this image because it shows multiple rolling pins and multiple invented patterns instead of a single clean product on white background.
- `商品主图` currently contains:
  - Keep unless your live visual inspection finds a serious issue: `IkiCbssr9ozqaAxQzVrcGyQhnaf`, `WG7067_hero_main.png`.
  - Keep unless your live visual inspection finds a serious issue: `Jjiyb2A9ZoOupux0gY0cLOiLnw3`, `WG7067_lifestyle_scene_chatgpt.png`.
  - Keep unless your live visual inspection finds a serious issue: `NWCmb3DiMoVuRaxEHoqcx13Pnfh`, `WG7067_selling_point_gemini.png`.
  - Keep unless your live visual inspection finds a serious issue: `KgVhbT36QohTedxwIYZcNARqnPc`, `WG7067_dimensions.png`.
  - Replace: `BZY8bhlK6o8xYtxJNSLcKcEdnnd`, `WG7067_material_detail.png`. Parent rejected it because it invents multiple rolling-pin styles/patterns and includes inappropriate visible text on products.

Correction tasks:
1. Live-read WG7067 from Base and save readback before edits.
2. Download/use the clean `参考图片` token as the product reference.
3. Generate a replacement `白底图`: one single natural wood embossed rolling pin matching the clean reference, 1:1, pure white background, no text, no extra products, no multiple SKU/pattern variants, no watermark, no logo, no contact/URL.
4. Upload the replacement `白底图` and remove the rejected `BOMvbv13Wovj9WxWtMrcUQ1Cndf` from `白底图`.
5. Generate a replacement material/process detail image for `商品主图`: focus on the same single paisley-pattern natural wood rolling pin, wood grain, engraved texture, handle/ring details; no invented alternate styles, no product collection, no birthday/holiday/text patterns, no Chinese, no price, no QR/watermark/contact/URL.
6. Upload the replacement material/detail image to `商品主图` and remove rejected token `BZY8bhlK6o8xYtxJNSLcKcEdnnd`. Preserve the four accepted `商品主图` tokens listed above unless you have a concrete parent-grade rejection reason.
7. Save prompts, route logs, upload/remove responses, before/after readbacks, and a final report in the product workspace.
8. Final response must list generated replacement paths, uploaded tokens, removed rejected tokens, final readback, accepted/preserved tokens, and any blockers.

Parent acceptance gate:
- The replacement `白底图` must be a single clean product-only white-background image, not a collage or SKU set.
- The replacement material/detail image must not invent unsupported product variants or visible text. If all non-image-CLI routes fail to satisfy those constraints, stop and report the exact blocker instead of uploading bad images.
