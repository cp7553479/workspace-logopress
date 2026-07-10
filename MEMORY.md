# Long-Term Memory

## 用户信息
- 姓名：陈鹏（阿呆）
- 公司：LogoPress Trading Inc
- 行业：Global B2B Trading / Customized Printing
- 时区：Asia/Shanghai (北京，UTC+8)

## 稳定偏好
- Skill 修改/规则话术：偏好简洁、精炼，不添加无关解释；修改后检查上下文是否冲突、重复或累赘。
- 创建或改写 Skill 时，`SKILL.md` 应以说明文为主，保持抽象、普适、可复用；不要硬编码 baseId、tableId、文件路径等具体值，示例命令使用占位符。
- 飞书主多维表格以 `https://mingjiainno.feishu.cn/base/SF9ibzjI4a0YFJsDZtKcLvtbnfh?table=tbl3KNB7zP8EQ1d0&view=vewMQ68Gd5` 为准；base-token 为 `SF9ibzjI4a0YFJsDZtKcLvtbnfh`，历史旧 token / 旧 table id 不再作为准绳。
- 商品/电商生图工具规则：subagent 必须阅读当前可用的生图 skill，并按该 skill/tool 当前推荐的最新、最适合商品图的生图模型生成图片；handoff 可明确允许 Oracle 生图，但不要把 Oracle 或其他具体服务写成唯一方式。
- 商品图生图路径策略：后续派发商品图 subagent 时，handoff 必须明确告诉 subagent 优先使用 Oracle 生图，并在 Oracle ChatGPT 和 Oracle Gemini 之间交替尝试；只有 ChatGPT 与 Gemini 两条 Oracle 路径都遇到问题、失败、不可用或结果被拒绝并记录证据后，才切换 Codex 生图。每张图仍需记录实际使用路径和失败证据。
- Oracle 生图模型偏好：subagent 使用 Oracle 生成图片时，应优先选择最轻量/最快的模型档位，例如 instant、立即、快速等。
- 商品图 subagent 派发偏好：每次派生 subagent 时，要尽量把任务需求描述清楚，或写入产品专用 handoff 文档；明确要求 subagent 先阅读该 handoff 文档、共享 worker instructions 和相关生图 skill 后再执行。
- ASI 首图 Logo 规则：如果参考图商品本身有 logo，首图 prompt 必须要求替换为 Logo 图片文件上的 logo，或替换为不含任何图形标记的纯文字 `YOUR LOGO`，不得保留参考图商品原有 logo 图案。
- ASI 商品图前置规则：后续派发商品图 subagent 时，handoff 必须要求先用 `参考图片` 字段原始图生成一张干净无 logo 商品参考图，去掉产品上的原有 logo/sample logo/品牌图案/示例印刷/平台厂家标记；生成后必须上传回并替换当前记录 `参考图片` 字段里的原始图片，回读确认旧原图已移除；后续白底图和 ASI 套图必须基于这张已回填的干净参考图生成，不能直接用原始参考图片生成套图。
- 后续商品/电商生图任务必须由 subagent 执行；2026-07-06 用户更新并发规则：允许同时处理两个产品，分别由两个 subagent 运行。一个 subagent 使用 Oracle 优先，ChatGPT/Gemini 交替生图（ChatGPT 优先且使用 medium 模型，Gemini 生成白底图），Codex 兜底；另一个 subagent 使用 Codex 优先，Oracle 兜底。超过两个商品仍需排队，避免同一记录被重复处理。
- 英文提示词、1:1、无中文/价格/水印/QR、不虚构
- 商品/电商生图最多两个产品并行，按 Oracle 优先通道与 Codex 优先通道分工；禁止脚本、贴图、局部覆盖、透视变换或程序合成最终图片。
- 不喜欢被说"我会一直跑"但实际做不到——要诚实
- 长批量任务偏好：及时使用 `update_plan` 记录当前任务状态，并把关键进度、阻塞、恢复点及时写入记忆，避免中断后丢失上下文。
- 商品/电商生图交付偏好：生成好的图片必须在飞书聊天里逐张发给用户，不能只上传到表格；如果用户说有图片没收到，要重新发送缺失图片并确认媒体回执。
- 商品/电商生图完成后复述偏好：每一次商品生成套图任务完成后，主会话必须再向用户完整复述一遍任务详情和要求；不是让 subagent 复述。
- 商品/电商生图跳过规则：subagent 执行某个商品前必须先检查当前记录 `商品主图` 字段是否已经存在图片；若已存在图片则跳过该记录并回报，不得继续覆盖生成。
- 商品/电商生图主动执行规则：遇到问题要主动想办法解决并推进闭环；但任何时候禁止用脚本方式生成图片、修复/修改图片、加 logo、贴图或合成最终图片，所有图片生成、修复、修改、加 logo 等图片操作必须使用当前生图 skill / 生图工具完成。
- 商品/电商生图水印提示词规则：生图 prompt 里禁止写任何关于右下角四角星水印的内容；该要求只作为审核标准传达给 subagent，审核时知道自然出现的右下角四角星水印可判合格即可。
- 长期 ASI 商品图监控偏好：不要依赖 `HEARTBEAT.md`；使用 cron 定时任务周期性唤醒并投递到当前飞书私聊 session。当前 ASI 监控 cron 为 `asi-subagent-watch-current-session`，每 30 分钟运行一次，sessionTarget 固定到 `agent:global-trading-product:feishu:global-trading-product:direct:ou_61123e30e1c1bfd2d0d31af923d4982d`。

## Promoted From Short-Term Memory (2026-07-09)

<!-- openclaw-memory-promotion:memory:memory/2026-07-04.md:23:23 -->
- 2026-07-04 18:50 Asia/Shanghai - Pre-compaction flush: 2026-07-04 18:50 Asia/Shanghai - User updated ASI image acceptance rule: if a generated image has a small four-point star watermark in the lower-right corner, it is allowed to pass and should not be rejected for that reason alone. Other obvious watermarks, garbled text, brand/platform marks, QR codes, prices, URLs, and unsupported marks still follow the original rejection rules. Active product at this time: LP3930 (`recuYsAZXyNqVz`), sessionKey `agent:logopress:subagent:e3d103c1-4a36-4459-8c6d-d59b8f8b07db`. [score=0.886 recalls=0 avg=0.620 source=memory/2026-07-04.md:23-23]
<!-- openclaw-memory-promotion:memory:memory/2026-07-06-0919.md:13:16 -->
- Conversation Summary: assistant: LP4937_clean_no_logo_chatgpt.png assistant: LP4937_white_gemini.png assistant: LP4937_hero_chatgpt_retry.png assistant: LP4937_lifestyle_chatgpt.png [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-06-0919.md:13-16]
<!-- openclaw-memory-promotion:memory:memory/2026-07-06-0919.md:9:12 -->
- Conversation Summary: assistant: LP4933 已完成父级复核、纠正回填和逐张交付；错误尺寸图已从 Base 移除并作为 rejected 发出。下一条 LP4937 已按 live Base 条件选出并启动唯一子任务。 assistant: LP4933 已完成父级复核和交付；错误尺寸图已从 Base 移除并作为 rejected 发出。下一条 LP4937 已启动为唯一子任务，HEARTBEAT 已更新到该 session。 user: [OpenClaw heartbeat poll] assistant: LP4937 父级复核通过：Base 回读确认 `参考图片=1`、`白底图=1`、`商品主图=6`；accepted 8 张，本地文件均为有效 PNG。另有 `LP4937_hero_gemini.png` 未采用，已由 retry 版 hero 替换；下面逐张发送。 [score=0.803 recalls=0 avg=0.620 source=memory/2026-07-06-0919.md:9-12]

## Promoted From Short-Term Memory (2026-07-09)

<!-- openclaw-memory-promotion:memory:memory/2026-07-06-0919.md:17:20 -->
- Conversation Summary: assistant: LP4937_selling_point_gemini.png assistant: LP4937_dimension_chatgpt.png assistant: LP4937_sku_gemini.png assistant: LP4937_detail_chatgpt.png [score=0.809 recalls=0 avg=0.620 source=memory/2026-07-06-0919.md:17-20]
<!-- openclaw-memory-promotion:memory:memory/2026-07-06-0919.md:21:22 -->
- Conversation Summary: assistant: LP4937_hero_gemini.png assistant: LP4937 已完成父级复核、回填确认和逐张交付；未采用 hero 草稿也已按原因发出。 [score=0.809 recalls=0 avg=0.620 source=memory/2026-07-06-0919.md:21-22]
<!-- openclaw-memory-promotion:memory:memory/2026-07-06-1429.md:9:9 -->
- Conversation Summary: assistant: 明白，刚才口径我修正了。 [score=0.809 recalls=0 avg=0.620 source=memory/2026-07-06-1429.md:9-9]

## Promoted From Short-Term Memory (2026-07-10)

<!-- openclaw-memory-promotion:memory:memory/2026-07-06-1429.md:21:24 -->
- Conversation Summary: user: [OpenClaw heartbeat poll] user: [OpenClaw heartbeat poll] user: [OpenClaw heartbeat poll] user: [OpenClaw heartbeat poll] [score=0.880 recalls=0 avg=0.620 source=memory/2026-07-06-1429.md:21-24]
<!-- openclaw-memory-promotion:memory:memory/2026-07-06-0919.md:24:25 -->
- Conversation Summary: 我已重新扫描 live Base：当前没有剩余符合 `Mark=有询单`、`参考图片` 已存在、`商品主图` 为空的商品，所以没有继续启动新的子任务。`HEARTBEAT.md` 已清空，避免后续空转。 assistant: Done. [score=0.848 recalls=0 avg=0.620 source=memory/2026-07-06-0919.md:24-25]
<!-- openclaw-memory-promotion:memory:memory/2026-07-06-0919.md:3:5 -->
- Session: 2026-07-06 09:19:12 GMT+8: **Session Key**: agent:logopress:main; **Session ID**: 9cdab10d-7378-4edd-bc64-e9150306aae8; **Source**: feishu [score=0.848 recalls=0 avg=0.620 source=memory/2026-07-06-0919.md:3-5]
<!-- openclaw-memory-promotion:memory:memory/2026-07-06-1429.md:12:15 -->
- Conversation Summary: 总任务描述：从商品表筛选 `商品主图` 为空且 `参考图片` 有图的记录，按队列逐个生成 ASI 套图。; 全部任务要求：每个 subagent 只处理一个商品；先生成并回填干净无 logo 参考图；基于干净参考图生成套图；Oracle ChatGPT / Gemini 交替，禁用 Gemini 2.5 Flash Image；两条 Oracle 路径都失败后才 Codex；右下角四角星水印可判合格；英文 prompt，1:1，无中文/价格/QR，不虚构；合格图写回 `商品主图` 并逐张发给你。; 当前任务进度：已完成哪些商品、当前正在第几件、当前 subagent 状态、剩余队列怎么继续。; 当前商品计划：当前商品的 record_id / 产品编号 / 名称，以及接下来具体步骤。 [score=0.848 recalls=0 avg=0.620 source=memory/2026-07-06-1429.md:12-15]
<!-- openclaw-memory-promotion:memory:memory/2026-07-06-1429.md:17:20 -->
- Conversation Summary: 我已把这个要求写进 `.temp/asi-main-image-queue-20260706/HANDOFF.md` 和 `HEARTBEAT.md`。当前第二个 subagent 已经在跑，工具权限不允许我直接插话给它；如果它这次没有按新口径完整复述，我会在恢复/检查时补齐，并从下一个商品开始严格按这个格式执行。 user: [message_id: om_x100b6b854420388cc10536d740d57fd] 文森-练物-超级管理员: 允许同时处理两个产品分别两个subagent运行。一个subagent使用oracle，chatgpt/gemini交替生图（chatgpt优先且使用medium模型，gemini生成白底图），codex兜底，另一个subagent使用codex生图，oracle兜底。 user: [OpenClaw heartbeat poll] [score=0.848 recalls=0 avg=0.620 source=memory/2026-07-06-1429.md:17-20]
<!-- openclaw-memory-promotion:memory:memory/2026-07-06-1429.md:3:5 -->
- Session: 2026-07-06 14:29:49 GMT+8: **Session Key**: agent:logopress:main; **Session ID**: c51753ea-37f5-4ada-9159-323e42728602; **Source**: feishu [score=0.848 recalls=0 avg=0.620 source=memory/2026-07-06-1429.md:3-5]
<!-- openclaw-memory-promotion:memory:memory/2026-07-06-1429.md:11:11 -->
- Conversation Summary: 你要的“复述”是： [score=0.838 recalls=0 avg=0.620 source=memory/2026-07-06-1429.md:11-11]
<!-- openclaw-memory-promotion:memory:memory/2026-07-06-1429.md:29:31 -->
- Conversation Summary: user: [message_id: om_x100b6b802636fcb0c3ffaa5d74c7e9f] 文森-练物-超级管理员: 请继续任务 assistant: 继续任务已执行，并按你最新规则改成两个产品并行： [score=0.808 recalls=0 avg=0.620 source=memory/2026-07-06-1429.md:29-31]
<!-- openclaw-memory-promotion:memory:memory/2026-07-06-1429.md:33:35 -->
- Conversation Summary: 已核验完成：LP0394 已写回 8 张商品主图并发送；LP0398 已写回 7 张商品主图并发送。; 当前 Oracle 优先通道：LP0407 / recuQNGAa2MTCV，ChatGPT medium 优先，ChatGPT/Gemini 交替，白底图走 Gemini，Codex 兜底。; 当前 Codex 优先通道：LP0413 / recuQUCUOo3Gmh，Codex 优先，Oracle 兜底。 [score=0.807 recalls=0 avg=0.620 source=memory/2026-07-06-1429.md:33-35]
