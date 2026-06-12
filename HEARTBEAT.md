tasks:

- name: asi-image-workers
  interval: 30m
  prompt: "Use subagents/sessions tools to check ASI product-image subagent status, use shell/jq to inspect progress.json and current product files, check Oracle lock/processes, and compare current time with started_at/last_parent_check. Do not rely on history alone. If no ASI worker is active, live-check the next eligible Base record, then call sessions_spawn. Treat spawn as successful only after sessions_spawn returns child session/run ID and progress.json shows running_count=1. Deliver completed images and update memory/progress."

# Notes

- Current state is in `.temp/asi_has_inquiry_manifest/progress.json`; batch files are pointers only, not fixed heartbeat targets.
- Durable rules/history: `memory/2026-06-12.md` and `.temp/asi_has_inquiry_manifest/worker_instructions.md`.
- Do not rely on historical chat summaries to decide that work is running. Verify active subagents, Oracle lock/processes, current product output/upload files, and `progress.json`.
- When a worker is marked running, compare current time with `started_at` / `last_parent_check`; if too much time passed with no new files, no active tool process, or no active subagent, mark the same product for recovery instead of waiting silently.
