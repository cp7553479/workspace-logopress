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
- 后续商品/电商生图任务必须由 subagent 执行；主会话每次只能派生一个商品生图 subagent，等完成、阻塞或恢复点明确后再派下一个。
- 2026-06-10 用户再次明确纠正：商品/电商生图批量任务每次仅允许同时派生一个 subagent；处理完一个商品之后再派生下一个 subagent。心跳或恢复逻辑发现已有商品图 subagent 运行时，只能监督当前商品、停止重复会话或记录阻塞，不能启动新商品。
- 禁止 Gemini 2.5 Flash Image
- 英文提示词、1:1、无中文/价格/水印/QR、不虚构
- 商品/电商生图串行排队，不并发；禁止脚本、贴图、局部覆盖、透视变换或程序合成最终图片。
- 不喜欢被说"我会一直跑"但实际做不到——要诚实
- 长批量任务偏好：及时使用 `update_plan` 记录当前任务状态，并把关键进度、阻塞、恢复点及时写入记忆，避免中断后丢失上下文。
- 商品/电商生图交付偏好：生成好的图片必须在飞书聊天里逐张发给用户，不能只上传到表格；如果用户说有图片没收到，要重新发送缺失图片并确认媒体回执。
- 长期 ASI 商品图监控偏好：不要依赖 `HEARTBEAT.md`；使用 cron 定时任务周期性唤醒并投递到当前飞书私聊 session。当前 ASI 监控 cron 为 `asi-subagent-watch-current-session`，每 30 分钟运行一次，sessionTarget 固定到 `agent:global-trading-product:feishu:global-trading-product:direct:ou_61123e30e1c1bfd2d0d31af923d4982d`。

## Promoted From Short-Term Memory (2026-06-13)

<!-- openclaw-memory-promotion:memory:memory/2026-06-07.md:27:27 -->
- Heartbeat: `HEARTBEAT.md` 检查时为空，已保持为空。 [score=0.814 recalls=0 avg=0.620 source=memory/2026-06-07.md:27-27]
<!-- openclaw-memory-promotion:memory:memory/2026-06-09.md:5:8 -->
- 01:11 生图交付纠偏: Context: ASI 套图批量任务中，LP2045 已生成并上传到 Base，用户指出“刚刚生成的图片也发给我”，并要求以后生成图片必须发给他。; Trigger: 图片交付标准不应只以 Base 上传完成为准，用户实际需要在飞书聊天里直接收到图片。; Actions: 重新发送 LP2045 的 12 张本地终稿图片，逐张使用 `message(filePath=...)`，回执均为媒体图片消息；同时把稳定偏好写入 `MEMORY.md`，不写入 `TOOLS.md`。; Lesson: 商品/电商生图任务的完成条件必须包含“发给用户本人并确认媒体回执”，上传表格只是归档步骤，不等于交付。 [score=0.812 recalls=0 avg=0.620 source=memory/2026-06-09.md:5-8]

## Promoted From Short-Term Memory (2026-06-14)

<!-- openclaw-memory-promotion:memory:memory/2026-06-09.md:12:15 -->
- 17:01 ASI 生图执行边界纠偏: Context: LP0924 重试中，subagent 超时后 main session 接手并直接调用 Codex/生图工具补齐部分 ASI 图片。; Trigger: 用户明确纠正：“main session 不要自己生图，只能派生多个 subagent 去给指定产品使用 skill 生成 ASI 套图”。; Actions: 承认越界；将 main session 只能编排、复核、记录和回读核验，不能直接生图/补图/修图的规则写入 `AGENTS.md`、`MEMORY.md` 和 `asi-product-image-generator` skill。; Lesson: ASI 商品图片缺失、失败、超时或部分完成时，main session 必须重新派生只处理该产品的新 subagent，而不是亲自补图。 [score=0.812 recalls=0 avg=0.620 source=memory/2026-06-09.md:12-15]

## Promoted From Short-Term Memory (2026-06-15)

<!-- openclaw-memory-promotion:memory:memory/2026-06-10.md:11:14 -->
- LP0927 Current Image/Base State: LP0927 has 4 generated white-background images for supported colors `natural`, `dark brown`, `white`, and `black`; these were uploaded to the Base `白底图` field and read back as verified.; Those 4 LP0927 white-background images were sent to the user in Feishu as media messages.; LP0927 `商品主图` remains empty; main images were not completed before the pause.; Prior Oracle blocker encountered for LP0927: `--model "5.2 Thinking"` failed because the ChatGPT picker only showed `Instant`, `Thinking• Standard`, `Pro• Standard`, `Configure...`; `--model "Thinking"` normalized to `GPT-5.2 Thinking` and failed;... [score=0.812 recalls=0 avg=0.620 source=memory/2026-06-10.md:11-14]
<!-- openclaw-memory-promotion:memory:memory/2026-06-10.md:17:17 -->
- Skill/Oracle Clarification: User asked whether the image-generation skill says Oracle image generation must only use Oracle to launch ChatGPT image generation. The answer given: the skill/memory preference requires Oracle priority and forbids Gemini 2.5 Flash Image, but it is not necessarily worded as “only Oracle may launch ChatGPT image generation” unless the specific skill file says so. Future changes should keep wording concise and avoid overclaiming. [score=0.812 recalls=0 avg=0.620 source=memory/2026-06-10.md:17-17]
<!-- openclaw-memory-promotion:memory:memory/2026-06-10.md:21:24 -->
- Product Image Batch Pause / Resume State: 2026-06-10 19:06 Asia/Shanghai: User requested product image task pause. Already-started LP0927 work was first allowed to finish only started work, then user clarified to stop subagents too and wait 5 hours.; HEARTBEAT.md was updated to pause until `2026-06-10 23:07 Asia/Shanghai`; at that time the assistant should first clean/modify the HEARTBEAT.md pause block, then resume work.; User rule reaffirmed: for product/e-commerce image generation, run only one product subagent at a time. Do not start a second product subagent while one is active.... [score=0.812 recalls=0 avg=0.620 source=memory/2026-06-10.md:21-24]
<!-- openclaw-memory-promotion:memory:memory/2026-06-10.md:25:25 -->
- Product Image Batch Pause / Resume State: Until `2026-06-10 23:07 Asia/Shanghai`, do not start, retry, continue, upload, or send any new product image generation outputs. [score=0.812 recalls=0 avg=0.620 source=memory/2026-06-10.md:25-25]
<!-- openclaw-memory-promotion:memory:memory/2026-06-10.md:4:7 -->
- Product Image Batch Pause / Resume State: 2026-06-10 19:06 Asia/Shanghai: User requested product image task pause. Already-started LP0927 work was first allowed to finish only started work, then user clarified to stop subagents too and wait 5 hours.; HEARTBEAT.md was updated to pause until `2026-06-10 23:07 Asia/Shanghai`; at that time the assistant should first clean/modify the HEARTBEAT.md pause block, then resume work.; User rule reaffirmed: for product/e-commerce image generation, run only one product subagent at a time. Do not start a second product subagent while one is active.... [score=0.812 recalls=0 avg=0.620 source=memory/2026-06-10.md:4-7]
<!-- openclaw-memory-promotion:memory:memory/2026-06-10.md:8:8 -->
- Product Image Batch Pause / Resume State: Until `2026-06-10 23:07 Asia/Shanghai`, do not start, retry, continue, upload, or send any new product image generation outputs. [score=0.812 recalls=0 avg=0.620 source=memory/2026-06-10.md:8-8]
