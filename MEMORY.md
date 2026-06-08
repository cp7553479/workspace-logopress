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
- 生图工具：Oracle 优先（`@steipete/oracle`），失败可切 Codex exec
- 禁止 Gemini 2.5 Flash Image
- 英文提示词、1:1、无中文/价格/水印/QR、不虚构
- Oracle 串行排队，不并发
- 不喜欢被说"我会一直跑"但实际做不到——要诚实
- 长批量任务偏好：及时使用 `update_plan` 记录当前任务状态，并把关键进度、阻塞、恢复点及时写入记忆，避免中断后丢失上下文。
- 商品/电商生图交付偏好：生成好的图片必须在飞书聊天里逐张发给用户，不能只上传到表格；如果用户说有图片没收到，要重新发送缺失图片并确认媒体回执。

## Promoted From Short-Term Memory (2026-06-08)

<!-- openclaw-memory-promotion:memory:memory/2026-06-03.md:5:8 -->
- LP0686 首图 Logo 修正: Context: ASI 套图批量任务中，用户指出 LP0686 首图 Logo 不对。; Trigger: 旧首图和第一次 AI 重生成图没有严格使用 `LOGO-BK.png` 的原始 LogoPress 图形。; Actions: 重新阅读 ASI 生图 skill；确认浅色水壶应使用黑色 `LOGO-BK.png`；用本地精确合成把原始 Logo 文件覆盖到首图印刷区；移除飞书 `商品主图` 字段里的旧首图并上传新首图。; Outcome: 最终验表 `白底图=1`、`商品主图=5`，新首图文件为 `LP0686_hero_main_logo_exact_v2.png`，已发给用户。 [score=0.879 recalls=0 avg=0.620 source=memory/2026-06-03.md:5-8]
<!-- openclaw-memory-promotion:memory:memory/2026-06-03.md:9:9 -->
- LP0686 首图 Logo 修正: Lesson: 首图 Logo 不能只靠 prompt 让模型“照着生成”；如模型没有完全复刻指定 Logo 文件，应直接用原始 Logo 文件精确合成或后处理，避免错误 Logo 上传。 [score=0.879 recalls=0 avg=0.620 source=memory/2026-06-03.md:9-9]
<!-- openclaw-memory-promotion:memory:memory/2026-05-30-2118-2.md:18:21 -->
- Conversation Summary: **白底图生成**：完成了 LP0241/LP0257/LP0401 的白底图，以及 LP0041/LP0105/LP0189 的 ASI 主图; **上传问题**：`lark-cli base +record-upload-attachment` 会追加而非替换附件，OpenAPI 也标记附件字段只读; **Skill 规则收紧**：白底图 skill 明确禁止脚本合成/本地拼接，必须用 image_gen 生成; **LP0041 素材图**：生成了物料信息图（第二版，去掉额外卖点文字） [score=0.859 recalls=0 avg=0.620 source=memory/2026-05-30-2118-2.md:18-21]
<!-- openclaw-memory-promotion:memory:memory/2026-05-30-2118.md:3:5 -->
- Session: 2026-05-30 21:18:05 GMT+8: **Session Key**: agent:main:feishu:group:oc_ec473251e4d81e5d4285a200b5e704e7; **Session ID**: 649f8f9a-cc90-4b1d-aa0b-580b01c2194b; **Source**: feishu [score=0.859 recalls=0 avg=0.620 source=memory/2026-05-30-2118.md:3-5]
<!-- openclaw-memory-promotion:memory:memory/2026-05-31.md:23:23 -->
- 飞书主 Base 切换确认: >>>>>>> 39da275bed94029b53d500e75171514b13dd9185 [score=0.859 recalls=0 avg=0.620 source=memory/2026-05-31.md:23-23]
<!-- openclaw-memory-promotion:memory:memory/2026-06-03-0950.md:12:14 -->
- Conversation Summary: 旧错误首图 `LP0686_hero_main.png` 已从商品主图移除; 新首图 `LP0686_hero_main_logo_exact_v2.png` 已上传; 飞书最终验表：白底图 1，商品主图 5 [score=0.851 recalls=0 avg=0.620 source=memory/2026-06-03-0950.md:12-14]
<!-- openclaw-memory-promotion:memory:memory/2026-06-03-0950.md:17:18 -->
- Conversation Summary: 我也更新了 progress 和 plan。LP0729 仍在运行中，后面继续按队列处理。 assistant: LP0686 首图已修正并替换完成：旧错图已移除，新首图已上传，飞书验表仍是白底图 1、商品主图 5。新首图也已发给你。 [score=0.851 recalls=0 avg=0.620 source=memory/2026-06-03-0950.md:17-18]
<!-- openclaw-memory-promotion:memory:memory/2026-06-03-0950.md:20:23 -->
- Conversation Summary: 我已更新 progress、plan，并记录了这次 Logo 修正教训。LP0729 继续运行中。 assistant: LP0729 完成，我需要验表、检查首图 Logo 是否正确、发图给用户，然后继续下一条。 assistant: Base verified: LP0729 has 白底图=1, 商品主图=6. Now let me check the hero image for correct logo before sending. assistant: Image analysis not available. Let me send the hero image to the user and they can flag if the logo is wrong like they did for LP0686. Let me send all images now. [score=0.851 recalls=0 avg=0.620 source=memory/2026-06-03-0950.md:20-23]
<!-- openclaw-memory-promotion:memory:memory/2026-06-03-0950.md:24:27 -->
- Conversation Summary: assistant: LP0729 完成！飞书验表：白底图 1 张、商品主图 6 张（含 SKU 图）。 请检查首图 Logo 是否正确。 assistant: LP0729_white_background_sku_v2.png assistant: LP0729_white_background_sku_v2.png [score=0.851 recalls=0 avg=0.620 source=memory/2026-06-03-0950.md:24-27]
<!-- openclaw-memory-promotion:memory:memory/2026-06-03-0950.md:3:5 -->
- Session: 2026-06-03 09:50:42 GMT+8: **Session Key**: agent:global-trading-product:feishu:global-trading-product:direct:ou_61123e30e1c1bfd2d0d31af923d4982d; **Session ID**: c416f419-d12b-4ee0-969d-e2c51913ffff; **Source**: webchat [score=0.851 recalls=0 avg=0.620 source=memory/2026-06-03-0950.md:3-5]

## Promoted From Short-Term Memory (2026-06-09)

<!-- openclaw-memory-promotion:memory:memory/2026-06-03-0950.md:9:11 -->
- Conversation Summary: assistant: 收到，我重新按 skill 的首图 Logo 规则处理 LP0686：只重做首图，不动其它图。先复核原首图和 Logo 文件要求，再重新生成、上传替换/追加，并把新首图发你。 assistant: LP0686_hero_main_logo_exact_v2.png assistant: LP0686 首图已按 skill 修好： [score=0.871 recalls=0 avg=0.620 source=memory/2026-06-03-0950.md:9-11]
<!-- openclaw-memory-promotion:memory:memory/2026-06-03.md:13:16 -->
- LP0474 首图完成: User request: `LP0474生成首图`.; Product: International portable power outlets travel plug adapter; record_id `recuQUIlEIktPa` in 商品表.; Assets: 白底图 `LP0474_white_background.png`; existing 商品主图 details `LP0474_scene.png`, `LP0474_selling_point.png`, `LP0474_size.png`, `LP0474_material_process.png`.; Output: generated `temp/LP0474_asi_recuQUIlEIktPa/outputs/LP0474_hero_main.png` (PNG 1254x1254, ~1.2MB), sent to user via Feishu, uploaded to `商品主图`. [score=0.871 recalls=0 avg=0.620 source=memory/2026-06-03.md:13-16]
<!-- openclaw-memory-promotion:memory:memory/2026-06-03.md:17:17 -->
- LP0474 首图完成: Verification: 商品主图 field had 5 attachments after upload, including `LP0474_hero_main.png`; 白底图 remained 1 attachment. [score=0.871 recalls=0 avg=0.620 source=memory/2026-06-03.md:17-17]
<!-- openclaw-memory-promotion:memory:memory/2026-06-03.md:21:24 -->
- LP0824 首图完成: User request: `LP0824生成首图`.; Product: Large iridescent beach stadium travel handbag clear tote bag; record_id `recuSr4b7XMiSE` in 商品表.; Product facts used: colors Black/Silver/White; material PVC; size `14.57 x 11.42 x 3.94 inch`. Do not invent extra colors/styles.; Assets: 白底图 `LP0824-white-background.png`; existing 商品主图 details `LP0824-scene.png`, `LP0824-selling-point.png`, `LP0824-size.png`, `LP0824-material.png`, `LP0824-sku.png`. [score=0.871 recalls=0 avg=0.620 source=memory/2026-06-03.md:21-24]
<!-- openclaw-memory-promotion:memory:memory/2026-06-03.md:25:26 -->
- LP0824 首图完成: Output: generated `temp/LP0824_asi_recuSr4b7XMiSE/outputs/LP0824_hero_main.png` (PNG 1254x1254, ~1.6MB), sent to user via Feishu, uploaded to `商品主图`.; Verification: 商品主图 field had 6 attachments after upload, including `LP0824_hero_main.png`; 白底图 remained 1 attachment. [score=0.871 recalls=0 avg=0.620 source=memory/2026-06-03.md:25-26]
<!-- openclaw-memory-promotion:memory:memory/2026-06-04.md:13:15 -->
- 长任务自动停止排查: Context: 用户问为什么每次运行 1-2 小时左右就自动停止、不继续运行。; Evidence: OpenClaw 配置里 `tools.exec.timeoutSec=1800`，单个 exec 工具最多约 30 分钟；Oracle 浏览器生图自身常提示最长可运行约 1 小时。最近 ASI 任务轨迹显示北京时间约 00:37 继续、01:34 `session.ended`，属于当前 turn 完成后结束，不是常驻后台 worker 自动续跑。; Lesson: 普通 Feishu 对话 turn 不能被当作“会一直后台跑”的任务。跨小时 ASI 批量任务要显式拆分为可恢复队列，并用 cron、heartbeat、后台 session 或分批交付来续跑；若没有这些机制，完成一次回复或遇到工具阻塞/等待确认后就会停止。 [score=0.851 recalls=0 avg=0.620 source=memory/2026-06-04.md:13-15]
<!-- openclaw-memory-promotion:memory:memory/2026-06-04.md:19:21 -->
- Turn 结束不是压缩直接杀掉: Context: 用户进一步怀疑“一个 turn 为什么这么短；是不是 Codex harness 压缩后就结束 turn”。; Evidence: 轨迹里每轮顺序是 `context.compiled -> prompt.submitted -> tool.call/tool.result... -> model.completed -> session.ended`；最近 `model.completed` 记录显示 `timedOut=false`、`yieldDetected=false`、`aborted=false`，随后 `session.ended status=success`。OpenClaw 配置为 `agents.defaults.compaction.mode=safeguard`、`plugins.slots.contextEngine=lossless-claw`，但未发现“压缩后结束 turn”的配置或日志证据。`openclaw status` 显示当前 direct session 约 `199k/272k`，有上下文压力但未满。; Lesson: 当前证据更支持“模型认为已完成/主动 final 后 harness 正常收尾”，而不是“compaction 自动杀 turn”。长任务中应避免过早 final/停问，或用后台/队列机制让后续步骤明确存在。 [score=0.851 recalls=0 avg=0.620 source=memory/2026-06-04.md:19-21]
<!-- openclaw-memory-promotion:memory:memory/2026-06-04.md:25:27 -->
- Turn 结束表述更正：不要把 completed 等同 stop: Context: 用户追问“模型为什么会发出 stop？真的是模型发 stop 的原因吗？”; Evidence: 重新检查 raw trajectory 后，只能看到 `model.completed`、`timedOut=false`、`aborted=false`、`yieldDetected=false`、`promptError=null`，没有看到原始 API 的 `finish_reason: stop` 字段。; Lesson: 以后排查 turn 结束时，不能把 OpenClaw 轨迹里的 `model.completed` 直接说成“模型发了 stop”。更准确说法是：模型响应正常完成且没有继续产生 tool call，runtime 因此结束 turn。若要证明 API-level stop，需要找到原始响应里的 finish/stop reason。 [score=0.851 recalls=0 avg=0.620 source=memory/2026-06-04.md:25-27]
<!-- openclaw-memory-promotion:memory:memory/2026-06-04.md:31:34 -->
- Finalize Guard 设计偏好: Context: 用户想研究 OpenClaw 是否能在一个 turn 准备结束时再让 LLM 自检：如果确实该结束则输出 `SESSION_OK`，否则继续任务；并希望清理该检查提示，避免污染上下文。; Evidence: 已查到 OpenClaw plugin typed hook 中存在 `before_agent_finalize`，返回值支持 `action: "revise"` 与 `retry.instruction`，适合在自然 final 被接受前请求模型再跑一轮；这比“结束后再开一轮”更干净。hook 事件可提供 `sessionKey/sessionId/turnId/cwd/transcriptPath/lastAssistantMessage/messages/stopHookActive` 等。; User preference: 用户坚决不同意写 ASI 专用、progress.json 专用或特定任务规则；核心思想应保持由 LLM 自己判断是否真的该结束。若存在 `update_plan` 且有未完成任务，可作为提示给 LLM，但不要把特定业务 pending 文件作为硬判断。; User preference: 不要把“不要 ASI 专用规则”等负规则写进正式文件，也不要在插件代码里写 ASI、progress.json、特定任务相关注释或判断。正式代码应保持通用 final... [score=0.851 recalls=0 avg=0.620 source=memory/2026-06-04.md:31-34]
<!-- openclaw-memory-promotion:memory:memory/2026-06-05-0049.md:13:13 -->
- Conversation Summary: assistant: 测试结果如下： [score=0.851 recalls=0 avg=0.620 source=memory/2026-06-05-0049.md:13-13]
