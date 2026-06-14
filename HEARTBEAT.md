tasks:

- name: asi-image-workers
  interval: 30m
  prompt: "Use subagents/sessions tools to check ASI product-image subagent status and progress; use shell/jq to inspect progress.json, current product files/readbacks, and active image-generation processes; compare current time with started_at/last_parent_check. Do not rely on history alone. If a subagent is active but timed out/stale, nudge or催促 that same subagent and record the nudge before starting recovery. If Oracle ChatGPT and Oracle Gemini both have problems on the current product, report to the user, keep the queue on that same product, and wait until the next heartbeat interval before starting another generation attempt or recovery. If no ASI worker is active and no current product is blocked/waiting, live-check the next eligible Base record, then call sessions_spawn. Treat spawn as successful only after sessions_spawn returns child session/run ID and progress.json shows running_count=1. Deliver completed images and update memory/progress."

# Notes

- Current state is in `.temp/asi_has_inquiry_manifest/progress.json`; batch files are pointers only, not fixed heartbeat targets.
- Durable rules/history: `memory/2026-06-12.md` and `.temp/asi_has_inquiry_manifest/worker_instructions.md`.
- Do not rely on historical chat summaries to decide that work is running. Verify active subagents, current product output/upload files, active image-generation processes, and `progress.json`.
- When a worker is marked running, compare current time with `started_at` / `last_parent_check`; if too much time passed with no new files, no active tool process, or no active subagent, first nudge/c催促 the same subagent when it is still active; if it is inactive, mark the same product for recovery instead of waiting silently.
- When both Oracle ChatGPT and Oracle Gemini fail or are unavailable for the current product, report the exact issue to the user and wait until the next heartbeat interval before starting another generation attempt. Keep `running_count=1` on the same product during this wait; do not spawn the next product.
