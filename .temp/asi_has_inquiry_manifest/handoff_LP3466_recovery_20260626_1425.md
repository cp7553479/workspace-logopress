# ASI product image recovery handoff: LP3466

You are recovering exactly one ASI product-image task.

Product:
- 产品编号: LP3466
- record_id: recuYsANVG4xl1
- Base token: SF9ibzjI4a0YFJsDZtKcLvtbnfh
- Table ID: tbl3KNB7zP8EQ1d0
- Workspace: /Users/vincent/.openclaw/workspace-logopress/.temp/LP3466_asi_recuYsANVG4xl1

Required instructions:
- Read and use `/Users/vincent/.openclaw/workspace-logopress/.temp/asi_has_inquiry_manifest/worker_instructions.md`.
- Read and use `/Users/vincent/.openclaw/workspace-logopress/skills/asi-product-image-generator/SKILL.md`.
- The `asi-product-image-generator` skill is mandatory and governs ASI套图/image rules, prompt constraints, image-type selection, acceptance/rejection, upload/readback requirements, and final reporting.

Current recovery evidence from parent heartbeat at 2026-06-26T14:25:00+0800:
- Previous child session `agent:global-trading-product:subagent:a4211bf1-d6f6-4802-a8b6-236cf042f0c0` / run `84568503-62a6-41c6-8a97-b62cf91a41f6` is `timeout`.
- Local files show no accepted output newer than 2026-06-26T13:16:04+0800.
- Existing completed assets:
  - `outputs/LP3466_clean_no_logo_reference.png`
  - `outputs/LP3466_white_background.png`
- Fresh Base readback with projected fields is saved at:
  - `/Users/vincent/.openclaw/workspace-logopress/.temp/asi_has_inquiry_manifest/live_record_LP3466_parent_20260626_1424_fields.json`
- Fresh Base readback confirms:
  - `参考图片`: 1 clean image (`LP3466_clean_no_logo_reference.png`)
  - `白底图`: 1 image (`LP3466_white_background.png`)
  - `商品主图`: empty

Recovery objective:
- Continue from the existing clean reference and white-background evidence.
- Generate valid ASI `商品主图` images according to the mandatory ASI skill.
- Do not redo completed upload work unless a readback proves it is invalid.
- Use current product reference images for every generation.
- Follow the route policy in worker instructions: Oracle first for every new image-generation attempt; alternate ChatGPT/Gemini where possible; no image CLI.
- Save prompts, route logs, upload responses, and readbacks in the LP3466 workspace.
- Upload accepted final images to `商品主图`.
- Final report must include product number, record id, generated files, uploaded tokens, readback status, skipped/rejected image types, blockers if any, and absolute paths that the parent must deliver to Feishu.
