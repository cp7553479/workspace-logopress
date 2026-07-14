# WG7056 ASI Product Image Recovery Summary

- Product number: WG7056
- Record ID: recv9nhVyeHz3p
- Live precheck: `参考图片` contained only `Sl6xbadLKoFLGExbKFycPzacnMe`; `白底图` contained `WXCUbTkWyoF79YxL6wPc3ZgpnCf`; `商品主图` was empty.
- Final readback: `readbacks/record_after_product_images_upload.json`

## Uploaded 商品主图 Images

| Type | Output path | File token |
| --- | --- | --- |
| Hero main image | `/Users/vincent/.openclaw/workspace-logopress/.temp/WG7056_asi_recv9nhVyeHz3p/outputs/WG7056_hero_main_logo.png` | `I65IbssIZo3f2CxGhozclOIBnNe` |
| Lifestyle scene | `/Users/vincent/.openclaw/workspace-logopress/.temp/WG7056_asi_recv9nhVyeHz3p/outputs/WG7056_lifestyle_gym_yoga_textless.png` | `FVBUbwxEkoRPgmx4yTBcOfZXnV3` |
| Selling point | `/Users/vincent/.openclaw/workspace-logopress/.temp/WG7056_asi_recv9nhVyeHz3p/outputs/WG7056_selling_point_breathable.png` | `PvVgbnFV5o89aHxsvPjc40MJnUh` |
| Material/detail | `/Users/vincent/.openclaw/workspace-logopress/.temp/WG7056_asi_recv9nhVyeHz3p/outputs/WG7056_material_detail_nylon.png` | `KREybTfbJoWorWxZf50cmHyTn7e` |
| SKU sheet 1 | `/Users/vincent/.openclaw/workspace-logopress/.temp/WG7056_asi_recv9nhVyeHz3p/outputs/WG7056_sku_sheet_01_codex.png` | `Xn06bvfWvo98kOxehedckdp9nCh` |
| SKU sheet 2 | `/Users/vincent/.openclaw/workspace-logopress/.temp/WG7056_asi_recv9nhVyeHz3p/outputs/WG7056_sku_sheet_02.png` | `ITiXb6LadoLV8exG667cWMDcnzb` |
| Dimension image | `/Users/vincent/.openclaw/workspace-logopress/.temp/WG7056_asi_recv9nhVyeHz3p/outputs/WG7056_dimension_inches.png` | `YffIbpCXIoEzn6xvlgmcmfy1nXg` |

## Route Notes

- Oracle Gemini produced the accepted lifestyle, material/detail, dimension, and hero images.
- Oracle ChatGPT produced the accepted selling-point image and SKU sheet 2.
- SKU sheet 1 required Codex fallback after ChatGPT fetch failure and Gemini outputs with unsupported sparkle marks.
- Rejected/blocked attempts are logged under `logs/`.
