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

## Promoted From Short-Term Memory (2026-05-31)

<!-- openclaw-memory-promotion:memory:memory/2026-05-24-1047.md:9:12 -->
- assistant: [assistant turn failed before producing content] assistant: 现在我知道了数据结构。我来查询所有商品，找出符合要求的商品（没有商品主图 + 选品未勾选）。 assistant: 有6826个符合条件的产品。取前50个，先勾选选品，然后逐个派生子Agent。 assistant: 需要使用 `--data` 而不是 `--body`。 [score=0.889 recalls=0 avg=0.620 source=memory/2026-05-24-1047.md:9-12]
<!-- openclaw-memory-promotion:memory:memory/2026-05-24-1047.md:13:16 -->
- assistant: 50个产品选品已勾选。现在开始逐个派生子Agent。先确认logo文件路径。 assistant: 现在开始派生子Agent。每个子Agent负责一个产品，指令包含skill阅读要求、首图排版、logo参考图。 assistant: 现在我将生成50个子代理。我会创建一个任务文件，其中包含通用说明，并生成每个子代理。 assistant: 现在我来启动50个子代理。我将分批并行运行它们。 [score=0.889 recalls=0 avg=0.620 source=memory/2026-05-24-1047.md:13-16]
<!-- openclaw-memory-promotion:memory:memory/2026-05-24-1047.md:17:20 -->
- assistant: 我将分派所有 50 个子代理。每个代理将处理一个产品。我将按顺序生成它们（它们将在后台并发运行）。 assistant: 我将继续生成剩余的43个子代理。我会将它们批量生成，以加快速度。 user: <<<BEGIN_OPENCLAW_INTERNAL_CONTEXT>>> OpenClaw runtime context (internal): [score=0.889 recalls=0 avg=0.620 source=memory/2026-05-24-1047.md:17-20]
<!-- openclaw-memory-promotion:memory:memory/2026-05-24-1047.md:21:21 -->
- This context is runtime-generated, not user-authored. Keep internal details private. [score=0.889 recalls=0 avg=0.620 source=memory/2026-05-24-1047.md:21-21]
<!-- openclaw-memory-promotion:memory:memory/2026-05-24-1047.md:23:26 -->
- [Internal task completion event] source: subagent session_key: agent:global-trading-product:subagent:54008f62-df37-47f3-989e-fc55451f4404 session_id: 8ebfcd76-9a53-4a66-b963-71303f3edd3c [score=0.889 recalls=0 avg=0.620 source=memory/2026-05-24-1047.md:23-26]

## Promoted From Short-Term Memory (2026-06-01)

<!-- openclaw-memory-promotion:memory:memory/2026-05-25-0903.md:9:10 -->
- assistant: LP0899 完成了但输出显示它派生了7个并行子任务后就结束了（3m58s），图片可能还没生成完。让我检查实际状态。 assistant: Now let me check which of our target 42 products still need images. I can see: [score=0.889 recalls=0 avg=0.620 source=memory/2026-05-25-0903.md:9-10]
