# MEMORY.md

- ASI ecommerce image batches for `商品表` must be orchestrated by the main session as a product queue. One subagent handles exactly one product; parallel subagents must process different products, with the chosen Oracle/Codex route written in each task requirement rather than in the skill. Keep Base writeback verification and user delivery under main-session review, and maintain `.temp/asi-image-task/status.md` and `HEARTBEAT.md` for recovery.
