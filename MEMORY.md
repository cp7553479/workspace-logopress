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
- 商品图生图路径策略：2026-06-12 用户更正，后续派发商品图 subagent 时，handoff 必须明确要求优先使用 Oracle 生图，可交替使用 Oracle ChatGPT 和 Oracle Gemini；只有 ChatGPT 与 Gemini 两条 Oracle 路径都遇到问题或失败后，才切换 Codex 生图。每张图仍需记录实际使用路径和失败证据；如 Oracle 遇到额度、登录、页面异常、网络或认证问题，按当前商品图恢复规则记录阻塞或等待后重试。
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

## Promoted From Short-Term Memory (2026-06-11)

<!-- openclaw-memory-promotion:memory:memory/2026-06-05.md:26:28 -->
- Preference: Skill Writing Style: Context: User requested a new skill for syncing ASI/ESP upload results back to ASI商品表.; Evidence: User said generated skills should make `SKILL.md` primarily explanatory, abstract, universal, and reusable, without hardcoded baseId, tableId, or file paths; examples should use placeholders.; Lesson: When creating or updating skills, write durable instructions in reusable prose first and keep concrete command examples parameterized with placeholders. [score=0.862 recalls=0 avg=0.620 source=memory/2026-06-05.md:26-28]

## Promoted From Short-Term Memory (2026-06-12)

<!-- openclaw-memory-promotion:memory:memory/2026-06-07-2128.md:13:16 -->
- Conversation Summary: assistant: LP0384_selling_point_v2.png assistant: LP0384_material_detail.png assistant: LP0384_sku.png assistant: LP0383_white_background.png [score=0.812 recalls=0 avg=0.620 source=memory/2026-06-07-2128.md:13-16]
<!-- openclaw-memory-promotion:memory:memory/2026-06-07-2128.md:17:20 -->
- Conversation Summary: assistant: LP0383_hero.png assistant: LP0383_scene.png assistant: LP0383_selling_point.png assistant: LP0383_size.png [score=0.812 recalls=0 avg=0.620 source=memory/2026-06-07-2128.md:17-20]
<!-- openclaw-memory-promotion:memory:memory/2026-06-07-2128.md:21:24 -->
- Conversation Summary: assistant: LP0383_material_detail.png user: [message_id: om_x100b6d6342ddd0a0c357745609fc25b] 陈鹏: 请从之前的checkpoint查找上一次任务的进度。上次你已经做到LP0393了，然后继续之后的任务。 assistant: 我先去查上一轮 checkpoint 和任务记录，确认 LP0393 之后要接着做什么，再继续执行。 [score=0.812 recalls=0 avg=0.620 source=memory/2026-06-07-2128.md:21-24]
<!-- openclaw-memory-promotion:memory:memory/2026-06-07-2128.md:3:5 -->
- Session: 2026-06-07 21:28:02 GMT+8: **Session Key**: agent:global-trading-product:feishu:global-trading-product:direct:ou_61123e30e1c1bfd2d0d31af923d4982d; **Session ID**: a912c478-25b2-4585-91c6-b98b8a427854; **Source**: feishu [score=0.812 recalls=0 avg=0.620 source=memory/2026-06-07-2128.md:3-5]
<!-- openclaw-memory-promotion:memory:memory/2026-06-07-2128.md:9:12 -->
- Conversation Summary: assistant: LP0386_material_detail.png assistant: LP0384_white_background.png assistant: LP0384_hero.png assistant: LP0384_scene.png [score=0.812 recalls=0 avg=0.620 source=memory/2026-06-07-2128.md:9-12]
<!-- openclaw-memory-promotion:memory:memory/2026-06-07.md:14:15 -->
- ASI 图片规则更新: 已修正 `asi-product-image-generator` skill：首图不得包含尺寸图/尺寸示意，右侧小图也不能展示尺寸；首图除产品本身可见信息和按要求合成的 Logo 示意外，不出现额外文字、标题、标签、尺寸数字、尺寸线或尺寸标注。; 用户此前明确纠正：ASI 图片任务不能用本地脚本批量生成/拼图替代 skill 流程；脚本只能做低风险查询、验表、整理。生图必须按 skill 的单品/单图流程执行。 [score=0.812 recalls=0 avg=0.620 source=memory/2026-06-07.md:14-15]
<!-- openclaw-memory-promotion:memory:memory/2026-06-07.md:18:19 -->
- ASI XID 同步 Skill: 创建并应用了 `asi-xid-sync` skill，用于从 Excel/CSV 按 `Product_Number` 回填 ASI 商品表的 `XID` 和 `Prod_Image`。; 最近一次处理 CSV：成功回填 334 个产品；`XID` 核验 334 个，`Prod_Image` 核验 327 个；未匹配 `LP0003`、`LP0002`。 [score=0.812 recalls=0 avg=0.620 source=memory/2026-06-07.md:18-19]
<!-- openclaw-memory-promotion:memory:memory/2026-06-07.md:22:24 -->
- 报价记录: 用户询问 `LP0028, 200个` 报价。已按报价 skill 查商品详情与阶梯价：LP0028，数量 200，对应 Q2=200，单价 USD 1.33/pcs，合计 USD 266.00。; 商品：Thick Reusable Paper Gift Bags with Satin Ribbon Handles；箱规：32 × 27 × 22 cm，4 kg/箱，50 pcs/箱；1688价 RMB 3.5；1688链接 `https://detail.1688.com/offer/827330565391.html?kj_agent_plugin=aibuy`。; 已生成并发送报价表 `2026-06-05-LP0028-200.xlsx`。 [score=0.812 recalls=0 avg=0.620 source=memory/2026-06-07.md:22-24]
<!-- openclaw-memory-promotion:memory:memory/2026-06-07.md:4:7 -->
- ASI / 商品主图批量任务: 用户要求：从飞书主 Base `SF9ibzjI4a0YFJsDZtKcLvtbnfh` 的 `商品表` 中挑 100 个 `商品主图` 为空且有 `参考图片` 的商品，使用 `asi-product-image-generator` skill，持续生成 ASI 商品套图；每次启动 2 个 Codex native subagent，直到 100 个商品主图全部完成。; 用户补充要求：生图时 Codex 与 Oracle 交替使用；Oracle 必须串行，不并发；及时 update plan / 进度。; 当前批次已筛出 100 个目标商品，并开始按队列处理。已完成并交付/上传核验的商品包括：LP0290、LP0326、LP0328、LP0337。; LP0326：`recuLlfsIm3OXi`，生成白底图 + 6 张商品主图（hero/scene/selling point/size/material/SKU），已上传到 `白底图` 和 `商品主图`，已发送图片，record-get 核验通过。 [score=0.812 recalls=0 avg=0.620 source=memory/2026-06-07.md:4-7]
<!-- openclaw-memory-promotion:memory:memory/2026-06-07.md:8:11 -->
- ASI / 商品主图批量任务: LP0290：`recuLlcDJ5KeXW`，已有白底图；生成并上传 6 张商品主图，已发送图片，record-get 核验通过。; LP0337：`recuLlfY50iXJ8`，生成并上传 5 张商品主图（main/scene/selling point/dimensions/material），SKU 因只有一个确认颜色/SKU 跳过；子任务无发图权限，父任务已补发 5 张图，record-get 核验通过。; 最新可见进度：LP0338、LP0340 已作为两个并行 subagent 在跑；队列下一位 LP0343。若恢复任务，先检查 `.temp/asi_100_empty_main/progress.json`、当前 active subagents / sessions，以及 Oracle lock/process，再补启动缺口，始终最多 2 个并行。; 重要操作习惯：子任务完成后必须先验收输出、补发未发送图片、record-get 核验 `商品主图` 非空，再把进度标为完成并启动下一个商品，避免批量任务中断。 [score=0.812 recalls=0 avg=0.620 source=memory/2026-06-07.md:8-11]

## Promoted From Short-Term Memory (2026-06-13)

<!-- openclaw-memory-promotion:memory:memory/2026-06-07.md:27:27 -->
- Heartbeat: `HEARTBEAT.md` 检查时为空，已保持为空。 [score=0.814 recalls=0 avg=0.620 source=memory/2026-06-07.md:27-27]
<!-- openclaw-memory-promotion:memory:memory/2026-06-09.md:5:8 -->
- 01:11 生图交付纠偏: Context: ASI 套图批量任务中，LP2045 已生成并上传到 Base，用户指出“刚刚生成的图片也发给我”，并要求以后生成图片必须发给他。; Trigger: 图片交付标准不应只以 Base 上传完成为准，用户实际需要在飞书聊天里直接收到图片。; Actions: 重新发送 LP2045 的 12 张本地终稿图片，逐张使用 `message(filePath=...)`，回执均为媒体图片消息；同时把稳定偏好写入 `MEMORY.md`，不写入 `TOOLS.md`。; Lesson: 商品/电商生图任务的完成条件必须包含“发给用户本人并确认媒体回执”，上传表格只是归档步骤，不等于交付。 [score=0.812 recalls=0 avg=0.620 source=memory/2026-06-09.md:5-8]
