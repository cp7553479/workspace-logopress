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
- 商品/电商生图完成后复述偏好：每次 subagent 完成一个商品后，主会话必须先完成父级复核，再向用户干净、完整地复述任务要求与执行结果；不是让 subagent 复述。若生图细则已在当前 skills/handoff 中，只需说明 subagent 已读取并按其执行，再重点复述产品编号、记录、商品信息、颜色/SKU、尺寸取值、Base 回读结果、已发图片、生成路径和异常/拒绝记录。
- 商品/电商生图跳过规则：subagent 执行某个商品前必须先检查当前记录 `商品主图` 字段是否已经存在图片；若已存在图片则跳过该记录并回报，不得继续覆盖生成。
- 商品/电商生图主动执行规则：遇到问题要主动想办法解决并推进闭环；但任何时候禁止用脚本方式生成图片、修复/修改图片、加 logo、贴图或合成最终图片，所有图片生成、修复、修改、加 logo 等图片操作必须使用当前生图 skill / 生图工具完成。
- 商品/电商生图水印提示词规则：生图 prompt 里禁止写任何关于右下角四角星水印的内容；该要求只作为审核标准传达给 subagent，审核时知道自然出现的右下角四角星水印可判合格即可。
- 长期 ASI 商品图监控偏好：不要依赖 `HEARTBEAT.md`；使用 cron 定时任务周期性唤醒并投递到当前飞书私聊 session。当前 ASI 监控 cron 为 `asi-subagent-watch-current-session`，每 30 分钟运行一次，sessionTarget 固定到 `agent:global-trading-product:feishu:global-trading-product:direct:ou_61123e30e1c1bfd2d0d31af923d4982d`。

## Promoted From Short-Term Memory (2026-07-12)

<!-- openclaw-memory-promotion:memory:memory/2026-07-07.md:3:5 -->
- Memory - 2026-07-07: 2026-07-07 11:21 CST - Pre-compaction flush only. No active user task beyond memory persistence; no Feishu-visible reply needed unless explicitly requested.; Current Feishu context is direct chat for account/workspace `logopress`; normal final replies are private, so visible chat replies require OpenClaw message send tool when appropriate.; Preserve canonical memory flush behavior: write only to `memory/2026-07-07.md`, never timestamped variants; treat `MEMORY.md`, `DREAMS.md`, `SOUL.md`, `TOOLS.md`, and `AGENTS.md` as read-only during flushes. [score=0.815 recalls=0 avg=0.620 source=memory/2026-07-07.md:3-5]
<!-- openclaw-memory-promotion:memory:memory/2026-07-06-1429.md:37:39 -->
- Conversation Summary: 我已更新 MEMORY、HANDOFF 和 HEARTBEAT。后续最多保持两个商品同时运行；任一通道完成或阻塞后，再补派下一件商品到空闲通道。 assistant: Background task cancelled: ASI套图-Codex优先-LP0413 (run 3d05cc8f). assistant: Background task cancelled: ASI套图-Oracle优先-LP0407 (run 26dd88d5). [score=0.812 recalls=0 avg=0.620 source=memory/2026-07-06-1429.md:37-39]
<!-- openclaw-memory-promotion:memory:memory/2026-07-06.md:3:6 -->
- Memory - 2026-07-06: 2026-07-06 23:38 CST - Pre-compaction flush: Current active durable preferences from `MEMORY.md` remain important for ASI/product image work. Use the canonical Feishu Base token `SF9ibzjI4a0YFJsDZtKcLvtbnfh`; old base tokens/table IDs are obsolete. For ASI image batches, process only 商品表 records where `Mark=有询单`, `参考图片` is non-empty, and `商品主图` is empty. Generated images must be uploaded/written back to Base, verified by readback, and also sent one by one in Feishu chat.; 2026-07-06 23:38 CST - ASI image generation operating rules to preserve after compaction: use at most two product subagents in parallel.... [score=0.806 recalls=0 avg=0.620 source=memory/2026-07-06.md:3-6]
<!-- openclaw-memory-promotion:memory:memory/2026-07-06-1429.md:25:28 -->
- Conversation Summary: user: [OpenClaw heartbeat poll] user: [OpenClaw heartbeat poll] user: [OpenClaw heartbeat poll] user: [OpenClaw heartbeat poll] [score=0.801 recalls=0 avg=0.620 source=memory/2026-07-06-1429.md:25-28]

## Promoted From Short-Term Memory (2026-07-14)

<!-- openclaw-memory-promotion:memory:memory/2026-07-07.md:11:13 -->
- Memory - 2026-07-07: 2026-07-07 11:50 CST - ASI image batch progress: LP0528 completed and parent-verified. Product: portable timer white noise night light Bluetooth speaker, record_id `recuR7yao62Zyb`. Clean reference used Codex/gpt-image-2 at 1254x1254; Codex batch suite failed (`fetch failed`, `Refresh token was revoked`), then Oracle fallback via browser `gemini-3.5-flash` produced 1024x1024 final suite. 8 images delivered: clean reference, white background, hero, lifestyle, selling point, dimension, material/detail, SKU/color. SKU used reliable MEDIUM WHITE and MEDIUM BLACK evidence.... [score=0.876 recalls=0 avg=0.620 source=memory/2026-07-07.md:11-13]
<!-- openclaw-memory-promotion:memory:memory/2026-07-07.md:15:17 -->
- Memory - 2026-07-07: 2026-07-07 12:11 CST - User asked to restate the full ASI ecommerce image-suite requirements and continue proactively. Main session restated the complete rules: process `商品表` records with `Mark=有询单`, non-empty `参考图片`, empty `商品主图`; max two parallel products split into Oracle-priority and Codex-priority channels; each subagent handles one record only; before any generation, subagent must re-read `商品主图` and skip if already populated; first generate and backfill clean no-logo reference, then use it for white background and main suite; reliable multi-color evidence required for SKU; all image operations must use... [score=0.876 recalls=0 avg=0.620 source=memory/2026-07-07.md:15-17]
<!-- openclaw-memory-promotion:memory:memory/2026-07-07.md:7:10 -->
- Memory - 2026-07-07: 2026-07-07 11:50 CST - ASI image batch progress: LP4961 was parent-verified and delivered. Base was backfilled with clean no-logo reference, 1 white-background image, and 5 product main images; 6 images were sent in Feishu (hero, white background, lifestyle, selling point, dimension, detail/material). SKU skipped because only one reliable natural bamboo color evidence existed.... [score=0.876 recalls=0 avg=0.620 source=memory/2026-07-07.md:7-10]
<!-- openclaw-memory-promotion:memory:memory/2026-07-08.md:3:3 -->
- Memory - 2026-07-08: 2026-07-08 00:49 Asia/Shanghai - Pre-compaction flush: no new operational progress beyond what was already in MEMORY.md. [score=0.844 recalls=0 avg=0.620 source=memory/2026-07-08.md:3-3]
<!-- openclaw-memory-promotion:memory:memory/2026-07-08.md:5:5 -->
- Memory - 2026-07-08: 2026-07-08 ~17:00 Asia/Shanghai - ASI 商品套图队列完成：对飞书主 Base 商品表 `Mark=有询单`、`参考图片` 非空、`商品主图` 为空的筛选条件执行 +record-search，返回 0 eligible records。所有 LP 系列商品均已处理闭环（包括历史批次和 2026-07-07/07-08 新增记录如 LP5247、LP5249、LP5250、LP5254、LP5258、LP5260、LP5276、LP5285、LP5290、LP5305 等）。队列当前无活跃 subagent，无待处理候选。如用户新增符合条件记录或修改筛选条件，队列可重新启动。 [score=0.844 recalls=0 avg=0.620 source=memory/2026-07-08.md:5-5]
