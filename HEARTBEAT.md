Watch: ASI product image pipeline.

This heartbeat is responsible for actively keeping the ASI product image pipeline moving. It must inspect runtime state, decide whether work is active, and start exactly one recovery/continuation SubAgent when the pipeline is idle.

Do not reply only `ok`. After checking, reply `NO_REPLY` if no user-facing update is needed.

## Files To Read Every Heartbeat

1. Read `.temp/asi-image-task/status.md`.
   - Identify the latest completed product.
   - Identify the latest incomplete product, blocked product, active handoff, or spawned SubAgent.
   - Pay special attention to lines containing `Current next task`, `blocked`, `recovery`, `resume`, `Spawned`, and product IDs like `LP3712`.
2. Inspect `.temp/` product directories.
   - List `.temp/LP*_asi_*` sorted by modification time.
   - For the newest relevant directories, inspect:
     - `before_record.json`
     - `outputs/`
     - `uploads/`
     - `prompts/`
     - any `status.md`
   - A directory with only `before_record.json` is not complete and should be resumed when no process is active.
3. For a candidate product directory, check completion evidence:
   - `outputs/` should contain final required images when available:
     - `*_clean_no_logo.png`
     - `*_white_background.png`
     - `*_hero.png`
     - `*_lifestyle.png`
     - `*_selling_point.png`
     - `*_dimension.png`
     - `*_material_detail.png`
     - `*_sku.png`
   - `uploads/` should contain Base writeback records and final reread records such as `final_record_check_*.json`.
   - `uploads/` should contain message delivery records for all final images.

## Runtime State To Check Every Heartbeat

1. Check active SubAgents with `subagents action=list` for the current requester session.
   - Treat any active ASI image-generation SubAgent as work in progress.
   - Match by task name, product number, record ID, or task text.
   - Do not rely on only one stored session key.
2. Check local processes.
   - Use `ps` and look for:
     - `oracle`
     - `generate-image`
     - `codex-imagen`
     - `lark-cli`
     - `Chrome` using `.oracle/browser-profile`
     - product IDs such as the candidate `LP####`
   - If an unrelated Oracle/browser-profile generation is active, do not start another Oracle browser generation because the profile can conflict.
3. Check whether a product directory is still changing.
   - Recent changes in `outputs/` or `uploads/` can mean work is still active even if no SubAgent is visible.
   - If files are actively changing, do not spawn a duplicate.

## Decision Rules

1. If a matching ASI SubAgent is active:
   - Do not spawn another one.
   - Append a short heartbeat note to `.temp/asi-image-task/status.md` only if the current status file lacks that active handoff.
   - Reply `NO_REPLY` unless the user explicitly asked for status.
2. If any Oracle/generate-image/codex-imagen/lark-cli process is active:
   - Determine which product it belongs to from command arguments or touched paths.
   - If it belongs to the candidate product, wait and do not duplicate.
   - If it belongs to another product but uses Oracle browser/profile, do not start another Oracle job; record the block in `.temp/asi-image-task/status.md`.
   - On the next heartbeat, recheck. If the blocking process is gone and the ASI candidate is still incomplete, resume it.
3. If a product directory is complete:
   - Verify final images, Base writeback/reread, and message delivery records.
   - Append a completed status block to `.temp/asi-image-task/status.md`.
   - Continue to the next product by spawning exactly one SubAgent, unless another process is active.
4. If no SubAgent is active, no relevant process is running, and the latest candidate product directory is incomplete:
   - Spawn exactly one SubAgent to resume that product.
   - The task must include product number, record ID, workspace path, current evidence, and the instruction to check again for active processes before doing work.
5. If no SubAgent is active, no relevant process is running, and the latest product is complete with no newer incomplete directory:
   - Spawn exactly one SubAgent to continue with the next ASI product after the latest completed product.

## SubAgent Task Requirements

When spawning a continuation or recovery SubAgent, include:

- Latest completed product and record ID.
- Candidate product and record ID, if known.
- Candidate workspace path, if known.
- Required skill reads:
  - `skills/asi-product-image-generator/SKILL.md`
  - current image generation skill instructions such as `generate-image` and/or `oracle`
- Mandatory duplicate-work check:
  - active SubAgents
  - Oracle/generate-image/codex-imagen/lark-cli processes
  - candidate `.temp/LP*_asi_*` directory contents
- Required output:
  - product number
  - generated final files
  - Base writeback result
  - message delivery result
  - exact blocker if incomplete

## Status Updates To Write

After every heartbeat action, append a short block to `.temp/asi-image-task/status.md` with:

- current timestamp
- latest completed product
- candidate product
- whether a SubAgent is active
- whether Oracle/generate-image/codex-imagen/lark-cli is active
- action taken:
  - waiting
  - blocked by process
  - resumed incomplete product
  - spawned next product
  - verified completed product
- child SubAgent session key when spawned
- next heartbeat instruction

## Current Recovery Focus

As of 2026-06-29 23:33 CST:

- Latest verified completed product: LP3711.
- Incomplete product to resume: LP3712.
- LP3712 record ID: `recuYsANVGK0zr`.
- LP3712 workspace: `.temp/LP3712_asi_recuYsANVGK0zr/`.
- If no active SubAgent and no Oracle/generate-image/codex-imagen/lark-cli process exists, resume LP3712 immediately.
- Do not leave LP3712 idle with only `before_record.json`.

## Completion Requirements

- Final images must include every generated required type available for that product: clean no-logo reference, white-background image, hero/main image, lifestyle/scene image, selling point image, dimension image, material/detail image, and SKU/color image when evidence supports them.
- Do not send rejected or abandoned candidates.
- Base writeback must be verified by reread or saved final check records.
- User delivery must include all final images, not just one, with message/upload records saved under the product `uploads/` directory.
- If any image type cannot be generated due to missing evidence, record the exact reason and tell the user.

## Recovery Rules

- Prefer resuming the most advanced incomplete product directory over starting a newer product.
- Never run duplicate image generation for the same product unless the previous process is confirmed stopped or stale.
- Do not hard-code a stale SubAgent key as the only source of truth; always inspect current runtime state.
- The heartbeat must actively recover idle incomplete work. It is not enough to only report that work is idle.
