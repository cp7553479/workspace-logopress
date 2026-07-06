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
- 商品图 subagent 派发偏好：每次派生 subagent 时，要尽量把任务需求描述清楚，或写入产品专用 handoff 文档；明确要求 subagent 先阅读该 handoff 文档、共享 worker instructions 和相关生图 skill 后再执行。
- ASI 首图 Logo 规则：如果参考图商品本身有 logo，首图 prompt 必须要求替换为 Logo 图片文件上的 logo，或替换为不含任何图形标记的纯文字 `YOUR LOGO`，不得保留参考图商品原有 logo 图案。
- ASI 商品图前置规则：后续派发商品图 subagent 时，handoff 必须要求先用 `参考图片` 字段原始图生成一张干净无 logo 商品参考图，去掉产品上的原有 logo/sample logo/品牌图案/示例印刷/平台厂家标记；生成后必须上传回并替换当前记录 `参考图片` 字段里的原始图片，回读确认旧原图已移除；后续白底图和 ASI 套图必须基于这张已回填的干净参考图生成，不能直接用原始参考图片生成套图。
- 后续商品/电商生图任务必须由 subagent 执行；2026-07-06 用户更新并发规则：允许同时处理两个产品，分别由两个 subagent 运行。一个 subagent 使用 Oracle 优先，ChatGPT/Gemini 交替生图（ChatGPT 优先且使用 medium 模型，Gemini 生成白底图），Codex 兜底；另一个 subagent 使用 Codex 优先，Oracle 兜底。超过两个商品仍需排队，避免同一记录被重复处理。
- 禁止 Gemini 2.5 Flash Image
- 英文提示词、1:1、无中文/价格/水印/QR、不虚构
- 商品/电商生图最多两个产品并行，按 Oracle 优先通道与 Codex 优先通道分工；禁止脚本、贴图、局部覆盖、透视变换或程序合成最终图片。
- 不喜欢被说"我会一直跑"但实际做不到——要诚实
- 长批量任务偏好：及时使用 `update_plan` 记录当前任务状态，并把关键进度、阻塞、恢复点及时写入记忆，避免中断后丢失上下文。
- 商品/电商生图交付偏好：生成好的图片必须在飞书聊天里逐张发给用户，不能只上传到表格；如果用户说有图片没收到，要重新发送缺失图片并确认媒体回执。
- 长期 ASI 商品图监控偏好：不要依赖 `HEARTBEAT.md`；使用 cron 定时任务周期性唤醒并投递到当前飞书私聊 session。当前 ASI 监控 cron 为 `asi-subagent-watch-current-session`，每 30 分钟运行一次，sessionTarget 固定到 `agent:global-trading-product:feishu:global-trading-product:direct:ou_61123e30e1c1bfd2d0d31af923d4982d`。

## Promoted From Short-Term Memory (2026-07-05)

<!-- openclaw-memory-promotion:memory:memory/2026-07-01.md:4:7 -->
- 2026-07-01 18:19 CST - ASI image generation queue memory: User corrected ASI ecommerce image batch filter: process only `商品表` records where `Mark=有询单`, `参考图片` is non-empty, and `商品主图` is empty. Do not include records merely because `白底图` is empty if `商品主图` already exists.; `MEMORY.md` rule remains active: main session must orchestrate ASI ecommerce image batches as a serial product queue; per product may spawn Oracle/Codex image routes, but Base upload/writeback and user delivery must be single-writer finalization.... [score=0.869 recalls=0 avg=0.620 source=memory/2026-07-01.md:4-7]
<!-- openclaw-memory-promotion:memory:memory/2026-07-01.md:8:9 -->
- 2026-07-01 18:19 CST - ASI image generation queue memory: LP4246 Codex route completed with outputs under `.temp/LP4246_asi_recuYsANVGvs6Z/outputs/codex/`: clean no-logo, white background, lifestyle, selling point, dimension (`7.87 x 7.87 x 0.59 inch`), material/detail, and hero/main with `LOGO-BK.png` + `YOUR LOGO`. SKU image skipped because only one reliable white SKU/color exists. No Codex-route Feishu upload or user file send was done.; LP4246 evidence/prompts were saved under `.temp/LP4246_asi_recuYsANVGvs6Z/evidence/` and `.temp/LP4246_asi_recuYsANVGvs6Z/prompts/`.... [score=0.869 recalls=0 avg=0.620 source=memory/2026-07-01.md:8-9]
<!-- openclaw-memory-promotion:memory:memory/2026-06-30.md:4:7 -->
- ASI product image batch / LP3736: Batch ASI image generation had progressed through LP3736.; LP3736 missing 3 images were completed: material image, SKU image, and main/hero image.; LP3736 final 8 images were sent to the user; rejected failed images were not sent.; At that checkpoint, there were no leftover Oracle / image generation / lark-cli / acpx processes. [score=0.868 recalls=0 avg=0.620 source=memory/2026-06-30.md:4-7]
<!-- openclaw-memory-promotion:memory:memory/2026-06-30.md:8:9 -->
- ASI product image batch / LP3736: Base backfill for LP3736 was not completed yet at the first checkpoint because the OpenClaw lark-cli environment initially could not use the `logopress` profile correctly.; Next operational intent after auth recovery: upload LP3736's 6 product main images, read back/verify in Base, then continue LP3737. [score=0.868 recalls=0 avg=0.620 source=memory/2026-06-30.md:8-9]
