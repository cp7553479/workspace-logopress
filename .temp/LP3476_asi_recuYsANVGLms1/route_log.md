# LP3476 Route Log

Policy:
- Prefer Oracle image generation.
- Alternate Oracle ChatGPT and Oracle Gemini across image types where practical.
- Do not use image CLI.
- Only use Codex image generation if Oracle routes fail or produce rejected results with recorded evidence.

Planned route order:
- white_background: Oracle Gemini, model gemini-3.5-flash
- lifestyle_scene: Oracle ChatGPT, model gpt-5.5-Medium
- selling_point: Oracle Gemini, model gemini-3.5-flash
- material_detail: Oracle ChatGPT, model gpt-5.5-Medium
- sku_chart: Oracle Gemini, model gemini-3.5-flash
- dimension_chart: Oracle ChatGPT, model gpt-5.5-Medium
- hero_logo_main: Oracle Gemini, model gemini-3.5-flash, with LOGO-BK.png reference

Actual accepted routes:
- white_background: Oracle Gemini browser, requested model gemini-3.5-flash, output outputs/LP3476_white_background.png. Oracle reported model selection resolved unavailable but generated and saved one image successfully; accepted after visual inspection.
- lifestyle_scene: Oracle ChatGPT browser, requested model gpt-5.5-Medium, output outputs/LP3476_lifestyle_scene.png. Oracle reported resolved unavailable/status already-selected but generated and saved one image successfully; accepted after visual inspection.
- selling_point: Oracle Gemini browser, requested model gemini-3.5-flash, output outputs/LP3476_selling_point.png. Oracle reported model selection resolved unavailable but generated and saved one image successfully; accepted after visual inspection.
- material_detail: Oracle ChatGPT browser, requested model gpt-5.5-Medium, output outputs/LP3476_material_detail.png. Oracle reported resolved unavailable/status already-selected but generated and saved one image successfully; accepted after visual inspection.
- sku_chart: Oracle Gemini browser, requested model gemini-3.5-flash, output outputs/LP3476_sku_chart.png. Oracle reported model selection resolved unavailable but generated and saved one image successfully; accepted after visual inspection.
- dimension_chart: Oracle ChatGPT browser, requested model gpt-5.5-Medium, output outputs/LP3476_dimension_chart.png. Oracle reported resolved unavailable/status already-selected but generated and saved one image successfully; accepted after visual inspection.
- hero_logo_main: Oracle Gemini browser, requested model gemini-3.5-flash, input included LOGO-BK.png, output outputs/LP3476_hero_logo_main.png. Oracle reported model selection resolved unavailable but generated and saved one image successfully; accepted after visual inspection.
