# Long-Term Memory

## 用户信息
- 姓名：陈鹏（阿呆）
- 公司：LogoPress Trading Inc
- 行业：Global B2B Trading / Customized Printing
- 时区：Asia/Shanghai (北京，UTC+8)

## 稳定偏好
- Skill 修改/规则话术：偏好简洁、精炼，不添加无关解释；修改后检查上下文是否冲突、重复或累赘。
- 飞书主多维表格以 `https://mingjiainno.feishu.cn/base/SF9ibzjI4a0YFJsDZtKcLvtbnfh?table=tbl3KNB7zP8EQ1d0&view=vewMQ68Gd5` 为准；base-token 为 `SF9ibzjI4a0YFJsDZtKcLvtbnfh`，历史旧 token / 旧 table id 不再作为准绳。
- 生图工具：Oracle 优先（`@steipete/oracle`），失败可切 Codex exec
- 禁止 Gemini 2.5 Flash Image
- 英文提示词、1:1、无中文/价格/水印/QR、不虚构
- Oracle 串行排队，不并发
- 不喜欢被说"我会一直跑"但实际做不到——要诚实

## Promoted From Short-Term Memory (2026-05-20)

<!-- openclaw-memory-promotion:memory:memory/2026-05-14.md:6:6 -->
- 为飞书多维表格"选品"视图中已勾选商品生成 ASI 电商套图（首图/场景/卖点/尺寸/材质/SKU），上传回"商品主图"和"白底图"字段。 [score=0.868 recalls=0 avg=0.620 source=memory/2026-05-14.md:6-6]
<!-- openclaw-memory-promotion:memory:memory/2026-05-14.md:26:26 -->
- `lark-cli base +record-upload-attachment` works for uploading to Bitable attachment fields. For cases where it fails with "Attachment file_token is unavailable", use raw `drive/v1/medias/upload_all` + PUT update record. [score=0.868 recalls=0 avg=0.620 source=memory/2026-05-14.md:26-26]
<!-- openclaw-memory-promotion:memory:memory/2026-05-14.md:29:29 -->
- Use bot to read raw record, then `batch_get_tmp_download_url` to get temp URLs, then `curl -L` to download. Temp URLs expire quickly; never reuse cached URLs. [score=0.868 recalls=0 avg=0.620 source=memory/2026-05-14.md:29-29]

## Promoted From Short-Term Memory (2026-05-21)

<!-- openclaw-memory-promotion:memory:memory/2026-05-14.md:36:39 -->
- | Product | Record ID | 白底图 | 商品主图 | Method | Notes | |---------|-----------|--------|----------|--------|-------| | LP0106 | recuLl0xxwqlix | 1 | 5 | image CLI | | | LP0119 | recvcuTfR4s4(?check) | 1 | 6 | image CLI | | [score=0.881 recalls=0 avg=0.620 source=memory/2026-05-14.md:36-39]
<!-- openclaw-memory-promotion:memory:memory/2026-05-14.md:40:43 -->
- | LP0122 | recuLl1iT6nKQZ | 1 | 2 | image CLI | waterproof selling point + white bg | | LP7291 | (check) | 1 | 4 | image CLI | | | LP7293 | recvcuTeSCwQFZ | 1 | 5 | mixed | 4 non-hero + 1 scene; hero/main still missing | [score=0.881 recalls=0 avg=0.620 source=memory/2026-05-14.md:40-42]

## Promoted From Short-Term Memory (2026-05-22)

<!-- openclaw-memory-promotion:memory:memory/2026-05-14.md:66:66 -->
- Need to identify from latest view data. Previously found 15 products with empty 商品主图. Already processed some. Remaining candidates include: [score=0.904 recalls=0 avg=0.620 source=memory/2026-05-14.md:66-66]

## Promoted From Short-Term Memory (2026-05-28)

<!-- openclaw-memory-promotion:memory:memory/2026-05-13.md:2:2 -->
- 2026-05-13: 用户提示 ACP 后续用 `mode: run` 时加 `thread: true` 进行（若当前工具 schema 支持）。 [score=0.861 recalls=0 avg=0.620 source=memory/2026-05-13.md:2-2]
<!-- openclaw-memory-promotion:memory:memory/2026-05-13.md:4:4 -->
- 2026-05-13: 用户更正 ACP 启动偏好：应使用 `runtime: "acp"`, `agentId: "codex"`, `mode: "session"`, `thread: true`（若工具/版本支持）。 [score=0.861 recalls=0 avg=0.620 source=memory/2026-05-13.md:4-4]
<!-- openclaw-memory-promotion:memory:memory/2026-05-13.md:6:6 -->
- 2026-05-13: 用户指出我在子任务/上传完成后没有主动及时汇报。以后长任务完成并验收后必须主动发最终结果；不要等用户追问。收到 subagent 完成通知后立即接续：查产物→验图→上传/验表→主动汇报。 [score=0.861 recalls=0 avg=0.620 source=memory/2026-05-13.md:6-6]
