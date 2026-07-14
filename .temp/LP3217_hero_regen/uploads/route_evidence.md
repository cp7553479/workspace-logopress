LP3217 hero regeneration route evidence

- Oracle ChatGPT attempt: failed. The browser run reported no generated local image and included `Preview file_00000000002871fa94b71eb27038d01e: fetch failed`.
- Oracle Gemini first attempt: generated `.temp/LP3217_hero_regen/outputs/LP3217_hero_main_oracle_gemini_LOGO-WT.png`, but the result was rejected because it visibly rendered `LOGO-WT.png` on the product instead of a clean `YOUR LOGO` placeholder.
- Codex fallback attempt: failed before generation because `codex-imagen.mjs` reported `Refresh token was rejected. Sign in again with Codex or OpenClaw OAuth.`
- image CLI fallback check: failed for ASI reference-image requirements because this installed `image generate` command does not accept `--image`.
