<<<<<<< HEAD
# Long-Term Memory


## Promoted From Short-Term Memory (2026-06-27)

<!-- openclaw-memory-promotion:memory:memory/2026-06-22-0946.md:23:23 -->
- Conversation Summary: What I confirmed: [score=0.822 recalls=0 avg=0.620 source=memory/2026-06-22-0946.md:23-23]
<!-- openclaw-memory-promotion:memory:memory/2026-06-22-0946.md:24:27 -->
- Conversation Summary: The original worker had timed out.; Reference cleanup is already done.; White background generation/upload is already done.; `商品主图` is still missing. [score=0.814 recalls=0 avg=0.620 source=memory/2026-06-22-0946.md:24-27]
<!-- openclaw-memory-promotion:memory:memory/2026-06-22-0946.md:9:9 -->
- Conversation Summary: assistant: LP3273 已复核完成。 [score=0.812 recalls=0 avg=0.620 source=memory/2026-06-22-0946.md:9-9]
<!-- openclaw-memory-promotion:memory:memory/2026-06-22.md:4:5 -->
- 2026-06-22 14:11 Asia/Shanghai - ASI queue flush: LP3321 completed and was parent-verified before this compaction flush. Live Feishu Base readback for record `recuYsACVIHeTT` confirmed `参考图片=1` clean no-logo reference, `白底图=1`, and `商品主图=5` (hero main retry, SKU chart, dimension, material/detail, lifestyle retry). Two first-version images were rejected/removed because of right-corner decoration/border artifacts; only retry versions were uploaded and sent to the user.; After LP3321 completion, LP3346 passed live eligibility check and exactly one new serial ASI image worker was spawned.... [score=0.812 recalls=0 avg=0.620 source=memory/2026-06-22.md:4-5]

## Promoted From Short-Term Memory (2026-06-28)

<!-- openclaw-memory-promotion:memory:memory/2026-06-22-0946.md:43:43 -->
- Conversation Summary: `asi-product-image-generator` 里要求： [score=0.847 recalls=0 avg=0.620 source=memory/2026-06-22-0946.md:43-43]
<!-- openclaw-memory-promotion:memory:memory/2026-06-22-0946.md:30:33 -->
- Conversation Summary: Created a recovery handoff for LP3276.; Spawned a new recovery subagent with the required `asi-product-image-generator` workflow.; Updated `progress.json` so it now tracks the new child session instead of the stale timeout.; Recorded the heartbeat outcome with no user interruption needed. [score=0.819 recalls=0 avg=0.620 source=memory/2026-06-22-0946.md:30-33]
<!-- openclaw-memory-promotion:memory:memory/2026-06-22-0946.md:36:37 -->
- Conversation Summary: Progress is `running` again under the recovery worker.; Next check is set for later, so I’m not polling aggressively. [score=0.819 recalls=0 avg=0.620 source=memory/2026-06-22-0946.md:36-37]
<!-- openclaw-memory-promotion:memory:memory/2026-06-22-0946.md:38:41 -->
- Conversation Summary: user: [message_id: om_x100b6cbcaad018bcc456bcd4263d82a] 陈鹏: asi\-product\-image\-generator / ASI 生图 skill 里面有没有说，首图要在商品可以印logo的地方印上logo的要求 user: [System] Your previous turn was interrupted by a gateway restart while OpenClaw was waiting on tool/model work. Continue from the existing transcript and finish the interrupted response. assistant: 有，而且写得很明确。 [score=0.819 recalls=0 avg=0.620 source=memory/2026-06-22-0946.md:38-41]
<!-- openclaw-memory-promotion:memory:memory/2026-06-22-0946.md:29:29 -->
- Conversation Summary: What I did: [score=0.809 recalls=0 avg=0.620 source=memory/2026-06-22-0946.md:29-29]
<!-- openclaw-memory-promotion:memory:memory/2026-06-22-0946.md:35:35 -->
- Conversation Summary: Current state: [score=0.809 recalls=0 avg=0.620 source=memory/2026-06-22-0946.md:35-35]

## Promoted From Short-Term Memory (2026-06-29)

<!-- openclaw-memory-promotion:memory:memory/2026-06-22-0946.md:45:47 -->
- Conversation Summary: **首图必须带 Logo**。; 生成首图时 **必须把指定 Logo 文件作为参考图**。; Prompt 里必须明确写类似： [score=0.851 recalls=0 avg=0.620 source=memory/2026-06-22-0946.md:45-47]
<!-- openclaw-memory-promotion:memory:memory/2026-06-22-0946.md:48:48 -->
- Conversation Summary: `Use LOGO-BK.png logo file and print it on the printable area of the main product in the hero image.` [score=0.851 recalls=0 avg=0.620 source=memory/2026-06-22-0946.md:48-48]
<!-- openclaw-memory-promotion:memory:memory/2026-06-22-0946.md:49:51 -->
- Conversation Summary: 如果产品参考图上原本有 logo / sample logo / 示例印刷 / 品牌字样，首图必须用指定 Logo 替换，不能保留原 logo。; Logo 必须由生图模型自然生成在商品的 **可印刷区域**，禁止后期脚本贴图或程序合成。; 还特别写了：首图 Logo 是带有 `YOUR LOGO` 字样的 LogoPress logo 示意，`YOUR LOGO` 不能省略，要写进 prompt。 [score=0.825 recalls=0 avg=0.620 source=memory/2026-06-22-0946.md:49-51]
<!-- openclaw-memory-promotion:memory:memory/2026-06-22-0946.md:53:56 -->
- Conversation Summary: 所以结论是：**有规定，首图必须在商品可印 logo 的位置印上指定 LogoPress logo。** assistant: Context overflow: prompt too large for the model. Try /reset (or /new) to start a fresh session, or use a larger-context model. assistant: white_background_oracle_gemini35_flash.png, asi_hero_main_oracle_gemini35_flash_retry.png assistant: NO_REPLY [score=0.807 recalls=0 avg=0.620 source=memory/2026-06-22-0946.md:53-56]
=======
# MEMORY.md

- ASI ecommerce image batches for `商品表` must be orchestrated by the main session as a product queue. One subagent handles exactly one product; parallel subagents must process different products, with the chosen Oracle/Codex route written in each task requirement rather than in the skill. Keep Base writeback verification and user delivery under main-session review, and maintain `.temp/asi-image-task/status.md` and `HEARTBEAT.md` for recovery.
>>>>>>> origin/main
