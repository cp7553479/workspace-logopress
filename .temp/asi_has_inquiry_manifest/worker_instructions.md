# ASI Product Image Worker Instructions

Scope: process exactly one product record from `商品表`.

Base:
- Base token: `SF9ibzjI4a0YFJsDZtKcLvtbnfh`
- Table: `商品表`
- Table ID: `tbl3KNB7zP8EQ1d0`

Required skills to read before acting:
- `/Users/vincent/.openclaw/workspace-logopress/skills/asi-product-image-generator/SKILL.md`
- `/Users/vincent/.openclaw/workspace-logopress/skills/generate-white-background/SKILL.md` if `白底图` is empty
- `/Users/vincent/.openclaw/skills/generate-image/SKILL.md`

Mandatory ASI skill rule:
- Every product-image subagent for this queue must use the `asi-product-image-generator` skill as the governing ASI套图/image workflow. Do not treat it as optional background reading; apply its rules when deciding image types, logo/mark cleanup, prompt constraints, acceptance/rejection, and upload/readback requirements.

Operational rules:
- Handle only the assigned `record_id` and `产品编号`.
- Do not batch other products.
- Parent dispatch rule for this ASI queue: spawn only one product-image subagent at a time.
- Create `.temp/<产品编号>_asi_<record_id>/` with `references/`, `outputs/`, and `uploads/`.
- Download only this product's `参考图片` and `白底图` attachments.
- If a reference product already contains logo artwork, sample logos, brand marks, imprints, manufacturer/platform marks, QR codes, watermarks, contact info, or URLs, use an image-generation tool only to remove those visible marks from the existing product image while preserving product shape, structure, color, material, proportions, angle, background, lighting, shadows, texture, and non-logo details. Upload the cleaned result back to `参考图片`, remove the original marked reference, and read back to confirm only the cleaned reference remains.
- If `白底图` is empty, generate a white-background image first from suitable cleaned product reference images, upload it to `白底图`, and include the output path in the final report.
- Then generate valid ASI套图 images according to the ASI skill. Skip image types that lack reliable support.
- Every generated final image must be uploaded to `商品主图` and reported to the parent for Feishu delivery.
- Image-generation route policy: try Oracle first for every new image-generation attempt. Within Oracle, alternate ChatGPT and Gemini across images/attempts whenever possible. Use non-image-CLI Codex image generation only after Oracle ChatGPT and Oracle Gemini are both blocked or rejected with concrete evidence.
- Do not use `image CLI` for image generation or fallback. If all available non-image-CLI routes are blocked, report the blocker and stop for that product.
- Do not use scripts or programmatic compositing for final product images.
- Use English prompts only. No Chinese text in images. No prices, QR codes, watermarks, supplier/manufacturer/platform/contact/URL information.
- Do not include product number, record ID, or internal IDs in image prompts or visible image text.
- Each generation must use at least one current product reference image.
- Save prompts and upload responses inside the product temp directory.
- If image generation or attachment download/upload is blocked, report the exact failing step and stop for that product.

Useful field names:
- `产品编号`
- `产品名称`
- `产品简称`
- `简要说明`
- `产品类型`
- `产品颜色`
- `产品材质`
- `产品尺寸 长(cm)`
- `产品尺寸 宽(cm)`
- `产品尺寸 高(cm)`
- `参考图片`
- `白底图`
- `商品主图`
- `Mark`

Attachment upload notes:
- Current local lark-cli upload should omit `--name`.
- Upload attachment command:
  `lark-cli base +record-upload-attachment --base-token SF9ibzjI4a0YFJsDZtKcLvtbnfh --table-id tbl3KNB7zP8EQ1d0 --record-id <record_id> --field-id <field> --file ./<file>`

Delivery:
- Native subagents in this run cannot reliably call the Feishu `message` handler. Workers must generate and upload images, then report absolute output paths to the parent. The parent session will send each final image to the user with `message(action="send", attachments=[...])`.
- Final worker answer should include product number, record id, generated files, reference/readback status, uploaded fields, paths that the parent must send, skipped image types, and blockers if any.
