# ASI Product Image Recovery Handoff - LP3477

Product number: LP3477
Record ID: recuYsANVGq0d7
Base token: SF9ibzjI4a0YFJsDZtKcLvtbnfh
Table ID: tbl3KNB7zP8EQ1d0

This is a recovery task for the same product after the previous worker timed out.

Previous worker:
- Child session: agent:global-trading-product:subagent:c71d8dd6-20a6-4e3d-abc9-c9f51ce08186
- Run ID: f3263e26-b76f-44c9-8acf-be2e5a4ae93a
- Status observed by parent: timeout
- Evidence: `.temp/LP3477_asi_recuYsANVGq0d7/` exists but contains only empty `references/`, `outputs/`, and `uploads/` folders. Parent live Base readback `.temp/asi_has_inquiry_manifest/live_record_LP3477_timeout_20260626_162838.json` still shows `参考图片=1`, `白底图=0`, `商品主图=0`.

You must use the `asi-product-image-generator` skill for ASI套图/image rules. This is mandatory, not optional.

Read and follow:
- /Users/vincent/.openclaw/workspace-logopress/.temp/asi_has_inquiry_manifest/worker_instructions.md
- /Users/vincent/.openclaw/workspace-logopress/skills/asi-product-image-generator/SKILL.md
- /Users/vincent/.openclaw/workspace-logopress/skills/generate-white-background/SKILL.md because 白底图 is empty
- /Users/vincent/.openclaw/skills/generate-image/SKILL.md

Live-check summary:
- Mark: 有询单
- 产品名称: Portable sports Crossbody Golf Club Bag Grip Practice case
- 简要说明: Our Portable Crossbody Golf Club Bag Practice Bag is a convenient and stylish accessory for golfers.Rush service is available.
- 产品类型: Bags & Luggage
- 产品颜色: Black, blue, red, orange, green, pink
- 产品材质: Polyester
- 产品尺寸 长(cm): 20.5
- 产品尺寸 宽(cm): 30.5
- 产品尺寸 高(cm): 0
- 参考图片: 1 attachment, 19208524351759575040527.jpeg, token AVFhbzhqkoFKpixb3tpcctIFnxg
- 白底图: empty
- 商品主图: empty

Task:
Recover and complete exactly this one product record. Reuse or recreate `.temp/LP3477_asi_recuYsANVGq0d7/` with `references/`, `outputs/`, and `uploads/`. Download only this record's current product attachments.

If the reference contains logos, sample marks, QR codes, watermarks, supplier/platform/contact/URL information, or other visible marks, clean it first while preserving product shape, structure, color, material, proportions, angle, background, lighting, shadows, texture, and non-logo details. Upload the cleaned image back to `参考图片`, remove the marked original, and read back to confirm only the cleaned reference remains.

Because `白底图` is empty, generate/upload/read back a white-background image first. Then generate valid ASI `商品主图` images according to the mandatory `asi-product-image-generator` skill. Skip image types that lack reliable support.

Use Oracle first for every new image-generation attempt, alternating ChatGPT and Gemini where possible. Do not use image CLI. Save prompts, route logs, upload responses, and readbacks inside the product temp directory. Use English prompts only. No Chinese text, prices, QR codes, watermarks, supplier/manufacturer/platform/contact/URL information, product number, record ID, or internal IDs in visible image text.

Final report to parent must include product number, record id, generated files, uploaded tokens, final readback status/counts, skipped/rejected image types, blockers if any, and absolute output paths for Feishu delivery.
