# WG7100 ASI Image Prompts

## Ecommerce Reference Search

Query: Amazon clear ice cube maker whiskey cocktail listing image examples

Prompt direction learned: clear ice cube maker listing images emphasize crystal clear ice, whiskey/cocktail use, premium bar setting, natural freezing/bubble-free benefits, and clean stainless-steel/silicone material presentation.

## clean-no-logo-reference

Output: `outputs/WG7100_clean_no_logo.png`

Model route attempt 1: Oracle ChatGPT, model `gpt-5.5-Medium`

Prompt:

```text
Edit the provided product reference image into a clean commercial product reference image. Keep the exact same real product: a compact silver stainless steel clear ice cube maker with a black lid and a clear skull-shaped ice cube beside it. Preserve the product shape, structure, proportions, material, brushed stainless steel texture, black top lid, water droplets, ice cube shape, angle, lighting, and realistic reflections. Remove all visible Chinese text, title text, captions, sample marks, brand marks, logos, manufacturer/platform marks, QR codes, watermarks, contact information, website URLs, and any other non-product graphic marks. Do not add any new text. Do not redesign the product. Do not invent unsupported details. Make the background clean and premium, suitable as a product reference for future ecommerce images. Product must be 100% identical to reference in all details (shape, texture, parts). No Chinese, no QR codes, no watermarks, no manufacturer information, no supplier information, no platform marks, no contact information, no website URLs, no price info. All text in English, but this image should contain no text. Ratio 1:1.
```

## white-background

Output: `outputs/WG7100_white_background.png`

Model route: Oracle Gemini, model `gemini-3.5-flash`

Prompt:

```text
Create a pure white background ecommerce product image using the provided clean product reference. Show the exact same compact silver stainless steel clear ice cube maker with black lid and the clear skull-shaped ice cube if visible in the reference. Professional studio lighting, clean edges, realistic shadow, premium Amazon-style main product photo, centered composition, product occupying most of the frame. Preserve the exact real product structure, color, brushed stainless steel material, black lid, proportions, and accessories. Remove any logo, brand word, imprint, QR code, watermark, manufacturer information, supplier information, platform marks, contact information, website URL, and any non-product marks. No extra props except the product and the clear ice cube already supported by the reference. Product must be 100% identical to reference in all details (shape, texture, parts). No Chinese, no QR codes, no watermarks, no manufacturer information, no supplier information, no platform marks, no contact information, no website URLs, no price info. All text in English, but this image should contain no text. Do not invent unsupported details. Ratio 1:1.
```

## lifestyle-scene

Output: `outputs/WG7100_lifestyle_scene.png`

Model route: Oracle ChatGPT, model `gpt-5.5-Medium`

Prompt:

```text
Lifestyle ecommerce poster image for a compact stainless steel clear ice cube maker for whiskey and cocktails. Use the provided clean product reference and white-background reference. Show the exact same silver stainless steel cylinder with black lid and the clear skull-shaped ice cube in a premium home bar scene beside a whiskey glass or cocktail glass. Emphasize crystal-clear ice and elevated drink presentation. Professional, beautiful, high-converting Amazon-style ecommerce image, clean premium layout, strong visual hierarchy, attractive lighting, polished commercial poster design, modern typography. Include only natural English text if needed: "Crystal Clear Ice" and "For Whiskey & Cocktails". Do not include prices or promotional claims. Product must be 100% identical to reference in all details (shape, texture, parts). No Chinese, no QR codes, no watermarks, no manufacturer information, no supplier information, no platform marks, no contact information, no website URLs, no price info. All text in English. Do not invent unsupported details. Ratio 1:1.
```

## selling-point

Output: `outputs/WG7100_selling_point.png`

Model route: Oracle Gemini, model `gemini-3.5-flash`

Prompt:

```text
Selling point ecommerce infographic poster for the provided compact stainless steel clear ice cube maker. Use the clean product reference and white-background reference. Highlight the benefit of crystal, bubble-free clear ice for whiskey and cocktails with a premium layout. Show the product and clear skull-shaped ice cube accurately. Professional, beautiful, high-converting Amazon-style ecommerce image, clean premium layout, strong visual hierarchy, attractive lighting, polished commercial poster design, modern typography. Use concise English text only: "Bubble-Free Clear Ice" and "Elevates Whiskey & Cocktails". Do not include prices, discounts, shipping, supplier, or manufacturer text. Product must be 100% identical to reference in all details (shape, texture, parts). No Chinese, no QR codes, no watermarks, no manufacturer information, no supplier information, no platform marks, no contact information, no website URLs, no price info. All text in English. Do not invent unsupported details. Ratio 1:1.
```

Rejected: added unsupported extra claims/elements ("Long-Lasting Chill", "Preserves Flavor", extra ice forms) and misspelled "Directional" as "Directionational".

Retry output: `outputs/WG7100_selling_point_retry_chatgpt.png`

Model route attempt 2: Oracle ChatGPT, model `gpt-5.5-Medium`

Prompt:

```text
Selling point ecommerce infographic poster for the provided compact stainless steel clear ice cube maker. Use the clean product reference and white-background reference. Show only the exact product and the supported clear skull-shaped ice cube. Do not add extra ice shapes, extra accessories, cutaway diagrams, measurement marks, icons, or unsupported claims. Professional, beautiful, high-converting Amazon-style ecommerce image, clean premium layout, strong visual hierarchy, attractive lighting, polished commercial poster design, modern typography. Use exactly these English text lines and no other words: "Bubble-Free Clear Ice" and "Elevates Whiskey & Cocktails". Keep text spelling perfect. Product must be 100% identical to reference in all details (shape, texture, parts). No Chinese, no QR codes, no watermarks, no manufacturer information, no supplier information, no platform marks, no contact information, no website URLs, no price info. All text in English. Do not invent unsupported details. Ratio 1:1.
```

## material-detail

Output: `outputs/WG7100_material_detail.png`

Planned model route: Oracle ChatGPT, model `gpt-5.5-Medium`

Actual route attempt 1: Oracle Gemini, model `gemini-3.5-flash`

Attempt 1 result: blocked, Oracle error `No images generated. Response text: (empty response)`.

Retry output: `outputs/WG7100_material_detail_chatgpt.png`

Actual route attempt 2: Oracle ChatGPT, model `gpt-5.5-Medium`

Attempt 2 result: blocked, Oracle error `file_0000000071c47208b887917e5590034c: fetch failed`.

Fallback output: `outputs/WG7100_material_detail_codex.png`

Fallback route: Codex `gpt-image-2` after both Oracle ChatGPT and Oracle Gemini were blocked.

Fallback result: blocked, Codex error `TypeError: fetch failed` during auth refresh. `image generate --help` did not expose a reference-image input option in this environment, so image CLI was not used because ASI requires at least one current product reference image for every generation.

Prompt:

```text
Material and detail ecommerce poster for the provided compact clear ice cube maker. Use the clean product reference and white-background reference. Accurately show close-up detail of the brushed stainless steel exterior, black lid, condensation droplets, and clear ice cube. Professional, beautiful, high-converting Amazon-style ecommerce material/detail poster design, clean premium layout, close-up detail emphasis, attractive lighting, polished commercial composition, modern typography. Use concise English text only: "Stainless Steel Body" and "Premium Clear Ice Mold". Do not mention unsupported materials beyond Stainless Steel. Product must be 100% identical to reference in all details (shape, texture, parts). No Chinese, no QR codes, no watermarks, no manufacturer information, no supplier information, no platform marks, no contact information, no website URLs, no price info. All text in English. Do not invent unsupported details. Ratio 1:1.
```

## dimension-chart

Output: `outputs/WG7100_dimension_chart.png`

Model route: Oracle Gemini, model `gemini-3.5-flash`

Prompt:

```text
Dimension ecommerce image for the provided compact stainless steel clear ice cube maker on a clean white background. Use the white-background reference. Show the exact same product centered with clear dimension guide lines and English labels only. Dimensions must be: Width 3.35 inch, Depth 3.35 inch, Height 3.66 inch. No marketing text. Product must be 100% identical to reference in all details (shape, texture, parts). No Chinese, no QR codes, no watermarks, no manufacturer information, no supplier information, no platform marks, no contact information, no website URLs, no price info. All text in English. Do not invent unsupported details. Ratio 1:1.
```

## hero-main

Output: `outputs/WG7100_hero_main.png`

Model route: Oracle ChatGPT, model `gpt-5.5-Medium`

Prompt:

```text
Hero main ecommerce image for the provided compact stainless steel clear ice cube maker. Use the provided clean product reference, white-background reference, supporting ecommerce images, and LOGO-BK.png logo file. Create a premium 1:1 main image with the product body occupying about 80% of the frame, large product on the left/center on a clean white or very light premium background, and up to three small circular callout images on the right showing supported usage/detail views only. Do not include a dimension chart, dimension lines, dimension numbers, SKU chart, or extra text in the hero image. Use LOGO-BK.png logo file and print it naturally on the printable area of the main product in the hero image. The logo is a LogoPress sample logo with the words "YOUR LOGO"; the words "YOUR LOGO" must remain visible as part of the logo. If the product in the reference image has a logo, replace it with the logo from the logo image file, or with plain text "YOUR LOGO" without any graphic mark; do not show the product's original logo pattern from the reference image. Professional, beautiful, high-converting Amazon-style ecommerce image, clean premium layout, strong visual hierarchy, attractive lighting, polished commercial poster design, modern typography. Product must be 100% identical to reference in all details (shape, texture, parts). When a logo is required, follow the specified logo file. No Chinese, no QR codes, no watermarks, no manufacturer information, no supplier information, no platform marks, no contact information, no website URLs, no price info. All text in English, but no additional text besides the logo sample. Do not invent unsupported details. Ratio 1:1.
```

## Skipped

SKU chart skipped because the record and reference evidence show only one reliable color/SKU: Silver.
