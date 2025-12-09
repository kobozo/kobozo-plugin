---
description: This skill should be used when the user asks to "generate image", "create image", "make image", "generate a hero image", "create an icon", "make a logo", or needs AI-generated images for their project. Provides guidance on prompt engineering and image generation with Nano Banana (Gemini) or DALL-E.
---

# Image Generation Skill

Generate AI images through intelligent prompt engineering using Nano Banana (Google Gemini) or DALL-E (OpenAI).

## When to Use

- Creating hero images for websites
- Generating icons or UI components
- Creating product photography
- Designing logos or mascots
- Making social media graphics
- Creating documentation illustrations

## Available Services

### Nano Banana (Google Gemini)
**Best for:** Photorealistic images, character designs, architectural visualizations, product photography

**Capabilities:**
- 10 aspect ratios (1:1, 16:9, 9:16, 4:3, 3:4, etc.)
- Style consistency
- Reference style transfer
- Cost: ~$0.039 per image

**Authentication:** `GEMINI_API_KEY` environment variable

### DALL-E 3 (OpenAI)
**Best for:** Conceptual art, creative interpretations, text in images, surreal scenes, marketing visuals

**Capabilities:**
- Multiple sizes (1024x1024, 1024x1792, 1792x1024)
- Quality levels (standard/HD)
- Natural language understanding
- Cost: $0.040-$0.120 per image

**Authentication:** `OPENAI_API_KEY` environment variable

## Prompt Engineering Guidelines

### Structure
1. **Subject**: What is the main focus
2. **Style**: Photorealistic, illustrated, minimalist
3. **Mood**: Warm, cool, vibrant, muted
4. **Composition**: Centered, rule of thirds, wide shot
5. **Technical**: Lighting, camera angle, quality

### Good Prompt Example
```
"Professional product photo of a modern coffee mug on a wooden table,
warm natural lighting, shallow depth of field, minimalist background,
high resolution, commercial photography style"
```

### Bad Prompt Example
```
"coffee mug" (too vague, no style guidance)
```

### Service-Specific Tips

**Nano Banana:**
- Be specific about lighting conditions
- Mention camera angles explicitly
- Reference real photography styles
- Use consistent character descriptions for series

**DALL-E:**
- Embrace creative descriptions
- Good for conceptual/abstract requests
- Can include text in images
- Use "vivid" for bold colors, "natural" for realistic

## Use Cases by Image Type

### Hero Images
- Aspect ratio: 16:9 or 21:9
- Style: Matches brand, professional
- Consider: Text overlay space, focal points

### UI Icons
- Aspect ratio: 1:1
- Style: Clean, simple, consistent
- Consider: Scalability, transparency

### Product Photos
- Style: Photorealistic
- Consider: Lighting, background, angles
- Multiple variations recommended

### Social Media
- Instagram: 1:1 or 4:5
- Stories: 9:16
- Twitter/LinkedIn: 16:9

### Documentation
- Style: Clear, instructional
- Consider: Diagrams, step illustrations

## Style Guide Integration

If a style guide exists (`docs/style-guide/`), integrate design tokens:
- **Colors**: Apply brand palette
- **Typography feel**: Match font characteristics
- **Visual effects**: Shadows, gradients
- **Overall aesthetic**: Design principles

### Integration Levels
- **Full**: UI components (all tokens)
- **Colors Only**: Illustrations (brand colors, style freedom)
- **Aesthetic Only**: Photos (general feel, minimal constraints)
- **Minimal**: Artistic (professional polish only)

## Workflow Overview

1. **Analyze requirements**: Understand image purpose and context
2. **Extract style**: Pull design tokens if style guide exists
3. **Engineer prompt**: Craft service-optimized prompt
4. **Generate image**: Call appropriate MCP server
5. **Save and report**: Store image, provide usage examples

## Invoke Full Workflow

For complete image generation with all phases:

**Use the Task tool** to launch image generation agents:

1. **Requirements Analysis**: Launch `image-generator:requirements-analyzer` to understand context
2. **Style Context**: Launch `image-generator:style-context-extractor` if style guide exists
3. **Prompt Engineering**: Launch `image-generator:prompt-engineer` to craft optimal prompts
4. **Image Generation**: Launch `image-generator:image-generator` to generate and save images

**Example prompt for agent:**
```
Generate a hero image for a SaaS platform landing page. Modern, professional,
16:9 aspect ratio. Should convey productivity and collaboration.
```

## Quick Reference

### Aspect Ratios by Use Case
| Use Case | Nano Banana | DALL-E |
|----------|-------------|--------|
| Hero banner | 16:9 | 1792x1024 |
| Instagram post | 1:1 | 1024x1024 |
| Instagram story | 9:16 | 1024x1792 |
| Product photo | 1:1 or 4:3 | 1024x1024 |
| Icon | 1:1 | 1024x1024 |

### Service Selection
- **Photorealistic**: Nano Banana
- **Creative/Abstract**: DALL-E
- **Text in image**: DALL-E
- **Character consistency**: Nano Banana
- **Budget conscious**: Nano Banana ($0.039 vs $0.040+)

### Output Locations
- Next.js: `public/images/`
- React: `public/images/` or `src/assets/`
- Documentation: `docs/images/`
- Generic: `images/`
