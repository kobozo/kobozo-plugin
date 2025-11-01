---
description: Generate AI images with intelligent prompt engineering using Nano Banana (Gemini) or DALL-E
---

# Generate Image

Orchestrates AI image generation through a multi-agent workflow: requirements analysis → style extraction → prompt engineering → image generation.

## Usage

```bash
/generate-image [prompt] [options]
```

### Examples

```bash
# Basic usage (auto-detect service)
/generate-image "hero image for SaaS platform, modern and professional"

# Specify service
/generate-image "button icon" --service nano-banana
/generate-image "logo design" --service dalle

# With output path
/generate-image "product photo of coffee mug" --output public/images/products/

# Multiple variations
/generate-image "mascot character" --count 3

# Force style guide integration
/generate-image "hero banner" --use-style-guide

# With service-specific parameters
/generate-image "hero image" --aspect-ratio 16:9  # Nano Banana
/generate-image "portrait" --size 1024x1792 --quality hd  # DALL-E
```

## Options

### Common Options
- `--service <name>` - Image generation service ('nano-banana' or 'dalle')
  - Default: Auto-detect based on requirements
- `--output <path>` - Output directory for generated images
  - Default: Auto-detected based on project type
- `--count <number>` - Number of image variations to generate
  - Default: 1
- `--use-style-guide` - Force style guide integration (asks by default)
- `--no-style-guide` - Skip style guide integration

### Nano Banana Options
- `--aspect-ratio <ratio>` - Image aspect ratio
  - Options: 1:1, 16:9, 9:16, 4:3, 3:4, 16:10, 10:16, 3:2, 2:3, 21:9
  - Default: Auto-detected from purpose

### DALL-E Options
- `--size <dimensions>` - Image dimensions
  - Options: 1024x1024, 1024x1792, 1792x1024
  - Default: 1024x1024
- `--quality <level>` - Image quality
  - Options: standard, hd
  - Default: standard
- `--style <style>` - Visual style preference
  - Options: vivid, natural
  - Default: vivid

## How It Works

This command orchestrates four specialized agents in sequence:

### Phase 1: Requirements Analysis (requirements-analyzer agent)

**Purpose**: Understand user intent and project context

**Actions**:
- Parse user prompt to extract image requirements
- Detect repository type (Next.js, React, Vue, docs, etc.)
- Identify reference images (URLs or local paths)
- Assess whether style guide integration is appropriate
- Determine optimal output location and filename
- Recommend appropriate service if not specified

**Output**: Structured requirements specification

### Phase 2: Style Context Extraction (style-context-extractor agent)

**Purpose**: Extract design system tokens from style guide

**Conditions**:
- Only runs if style guide exists in `docs/style-guide/`
- Only runs if integration is appropriate (UI components, branded materials)
- Can be forced with `--use-style-guide` or skipped with `--no-style-guide`

**Actions**:
- Read style guide markdown files
- Extract color palette, typography, visual style
- Translate design tokens into descriptive language
- Build style context for prompt engineering

**Output**: Style context with design tokens and descriptions

**Skip**: If no style guide or not appropriate for image type

### Phase 3: Prompt Engineering (prompt-engineer agent)

**Purpose**: Engineer optimal service-specific prompts

**Actions**:
- Read service info file (`services/nano-banana.json` or `services/dalle.json`)
- Apply service-specific prompt engineering guidelines
- Integrate style context if available
- Analyze and transfer style from reference images
- Generate variations if `--count > 1` specified
- Optimize prompts within token limits
- Present prompts for user approval

**Output**: Engineered prompts ready for generation

**User Approval**: Shows prompts and asks for confirmation before generation

### Phase 4: Image Generation (image-generator agent)

**Purpose**: Generate and save images via MCP

**Actions**:
- Validate API credentials (GEMINI_API_KEY or OPENAI_API_KEY)
- Invoke MCP server with engineered prompts
- Download and save generated images
- Handle errors gracefully with helpful recovery suggestions
- Generate comprehensive summary report
- Provide framework-specific usage examples

**Output**: Generated images + usage documentation

## Services

### Nano Banana (Google Gemini 2.5 Flash Image)

**Best For**:
- Photorealistic images
- Detailed scenes and environments
- Character designs with consistency
- Architectural visualizations
- Product photography with specific lighting

**Capabilities**:
- 10 aspect ratios
- Style consistency
- Reference style transfer
- Character consistency across generations

**Cost**: ~$0.039 per image

**Authentication**: Set `GEMINI_API_KEY` environment variable
- Get API key: https://aistudio.google.com/apikey

### DALL-E 3 (OpenAI)

**Best For**:
- Conceptual and abstract art
- Creative interpretations
- Text within images (logos, signs)
- Surreal and imaginative scenes
- Marketing visuals

**Capabilities**:
- Natural language understanding
- Creative interpretation
- Text rendering
- Multiple size options
- Quality levels (standard/HD)

**Cost**: $0.040-$0.120 per image (depending on size/quality)

**Authentication**: Set `OPENAI_API_KEY` environment variable
- Get API key: https://platform.openai.com/api-keys

### Service Auto-Detection

If no service is specified, the command automatically recommends the best service based on:
- Image purpose (UI component, hero, product photo, illustration)
- Visual style requirements (photorealistic, artistic, conceptual)
- Technical specifications (dimensions, quality needs)
- Available API credentials

## Workflow Phases

### 1. Discovery & Analysis (Pure Functions)

**Requirements Analyzer** runs pure analysis:
- Parses intent
- Detects repo context
- Finds references
- Assesses style needs
- Determines output location

**No side effects** - just analysis and recommendations.

### 2. Style Extraction (Pure Functions)

**Style Context Extractor** runs pure extraction:
- Reads style guide files
- Parses design tokens
- Translates to descriptive language
- Builds style context

**No side effects** - just reading and transforming data.

### 3. Prompt Engineering (Pure Functions)

**Prompt Engineer** runs pure composition:
- Loads service info files
- Analyzes references
- Composes prompts functionally
- Integrates style context
- Generates variations
- Optimizes for service

**No side effects** - just pure transformations.

### 4. Generation & Execution (Side Effects Isolated)

**Image Generator** handles all side effects:
- Validates API keys
- Invokes MCP tools
- Downloads images
- Saves files
- Generates reports

**All side effects isolated** - previous phases stay pure.

## Reference Images

You can provide reference images to guide style:

### URL References
```bash
/generate-image "product photo like https://example.com/image.jpg"
```

The system will analyze the URL (or ask you to describe it) and transfer visual style to the generated image.

### Local Path References
```bash
/generate-image "hero image similar to ./examples/hero.jpg"
```

The system will read the local image, analyze visual characteristics, and apply similar style to the new generation.

### Style Transfer Elements

Extracted from references:
- Composition (rule of thirds, centered, asymmetric)
- Lighting (golden hour, studio, dramatic)
- Color mood (warm, cool, vibrant, muted)
- Texture quality (sharp, soft, detailed)
- Artistic style (photorealistic, illustrated, minimalist)

## Style Guide Integration

If a style guide exists at `docs/style-guide/`, the system can integrate design tokens:

### When Style Integration Happens

**Automatic** (asks user):
- UI components (icons, buttons, logos)
- Hero images and banners
- Branded marketing materials

**Optional** (less common):
- Product photographs
- Illustrations and artwork
- Generic imagery

### What Gets Integrated

- **Colors**: Brand color palette applied to generated images
- **Typography style**: Font characteristics translated to visual style
- **Visual effects**: Shadows, gradients, glass morphism
- **Overall aesthetic**: Design principles and visual identity

### Integration Levels

**Full** (UI components):
- Complete color palette
- All design tokens
- Visual effects and treatments

**Colors Only** (illustrations):
- Brand colors applied
- Style freedom maintained

**Aesthetic Only** (photos):
- Overall design feel
- Professional quality
- Minimal color constraint

**Minimal** (artistic):
- Professional polish
- No strict adherence

## Variations

Generate multiple variations with `--count`:

```bash
/generate-image "mascot character" --count 3
```

### Variation Strategies

**Angle Variations**:
- Front view
- Three-quarter view
- Side view
- Top-down view

**Color Variations**:
- Warm tones
- Cool tones
- Vibrant saturated
- Muted pastels

**Style Variations**:
- Photorealistic
- Illustrated
- Minimalist
- Artistic

**Composition Variations**:
- Centered
- Rule of thirds
- Asymmetric
- Close-up vs wide

The system intelligently chooses variation strategy based on image purpose.

## Error Handling

### Common Errors

**Missing API Key**:
```
❌ Error: GEMINI_API_KEY not set

Solution:
1. Get API key from https://aistudio.google.com/apikey
2. Set environment variable: export GEMINI_API_KEY="your-key"
3. Restart Claude Code

Alternative: Try --service dalle if you have OpenAI credits
```

**Rate Limit**:
```
❌ Error: Rate limit exceeded

Solution:
1. Wait a few moments
2. Check usage at service dashboard
3. Try alternative service
```

**Content Policy**:
```
❌ Error: Content policy violation

Solution:
1. Review prompt for problematic content
2. Rephrase with more neutral language
3. Request assistance with rephrasing
```

### Partial Success

If some images succeed and others fail:
- Successfully generated images are saved
- Failed generations are reported with errors
- Recovery options provided
- Can retry failed images individually

## Cost Tracking

The system provides cost estimates before generation and actual costs after:

```
Estimated cost: $0.12 for 3 images (DALL-E HD 1024x1024)
Total cost: $0.117 (3 images generated successfully)
```

Track your usage:
- Gemini: https://console.cloud.google.com/billing
- OpenAI: https://platform.openai.com/usage

## Examples by Use Case

### UI Component
```bash
/generate-image "modern button icon with play symbol" --service nano-banana --aspect-ratio 1:1
```
→ Uses style guide colors, optimized for web, PNG with transparency

### Hero Image
```bash
/generate-image "hero image for SaaS platform, modern and professional" --aspect-ratio 16:9
```
→ Integrates brand colors, generates 16:9 for website header

### Product Photography
```bash
/generate-image "product photo of coffee mug on wooden table, warm lighting" --quality hd
```
→ Photorealistic with minimal style constraint, focuses on lighting

### Logo/Branding
```bash
/generate-image "mascot character for tech startup, friendly and approachable" --count 3
```
→ Full style integration, 3 variations for selection

### Social Media
```bash
/generate-image "Instagram post about productivity tips" --aspect-ratio 1:1 --use-style-guide
```
→ 1:1 for Instagram, brand colors applied

### Documentation
```bash
/generate-image "diagram showing user authentication flow" --output docs/images/
```
→ Saved to docs directory, clear and instructional style

## Output

Generated images are saved to context-aware locations:

- **Next.js**: `public/images/`
- **React**: `public/images/` or `src/assets/`
- **Documentation**: `docs/images/`
- **Generic**: `images/`

Filenames are generated from prompt:
- "hero image for SaaS" → `saas-hero-image.png`
- "button icon" → `button-icon.png`
- "product photo" → `product-photo.png`

## Summary Report

After generation, you receive:

1. **Generated images** with paths and metadata
2. **Framework-specific usage examples** (React/Next.js/HTML/Markdown)
3. **Prompt details** (what was sent to the service)
4. **Cost summary** (per-image and total)
5. **Next steps** (optimization, integration, variations)
6. **Files created** (directory structure)

## Extending the Plugin

### Adding New Services

To add a new image generation service:

1. **Add MCP server** to `plugin.json`:
```json
{
  "mcpServers": {
    "new-service": {
      "command": "npx",
      "args": ["-y", "new-service-mcp"],
      "env": {
        "API_KEY": "${NEW_SERVICE_API_KEY}"
      }
    }
  }
}
```

2. **Create service info file** `services/new-service.json`:
```json
{
  "name": "new-service",
  "displayName": "New Service Name",
  "mcpServer": "new-service",
  "mcpTool": "generate",
  "promptRequirements": { ... },
  "parameters": { ... },
  "capabilities": { ... }
}
```

3. **Update prompt-engineer agent** to handle new service (reads service info automatically)

4. **Update image-generator agent** to invoke new MCP tool

No other changes needed - the architecture is designed for easy extensibility!

## Troubleshooting

### "Agent not found"
- Ensure plugin is properly installed
- Check `.claude-plugin/plugin.json` exists
- Restart Claude Code

### "MCP server failed to start"
- Check API key is set correctly
- Verify network connectivity
- Try manual MCP server install: `npx -y <package-name>`

### "Style guide not found"
- Create style guide at `docs/style-guide/style-guide.md`
- Or use `--no-style-guide` to skip integration
- See ui-checker plugin for style guide creation

### "Output directory not writable"
- Check directory permissions
- Ensure directory exists or can be created
- Specify alternative with `--output`

## Best Practices

1. **Start simple**: Test with basic prompts before complex ones
2. **Iterate**: Generate variations and refine
3. **Use style guide**: For branded content, always integrate
4. **Reference images**: Provide examples for style transfer
5. **Choose right service**: Nano Banana for photorealistic, DALL-E for creative
6. **Track costs**: Monitor API usage regularly
7. **Save successful prompts**: Document what works well

---

Your task as the orchestrator is to:

1. **Use TodoWrite** to track each phase
2. **Launch requirements-analyzer** agent first
3. **Conditionally launch style-context-extractor** if appropriate
4. **Launch prompt-engineer** agent with all context
5. **Present prompts** to user for approval
6. **Launch image-generator** agent after approval
7. **Handle errors gracefully** with clear recovery paths
8. **Provide comprehensive summary** with usage examples

The agents are designed for functional programming:
- Phases 1-3 are pure functions (no side effects)
- Phase 4 isolates all side effects
- Each agent receives immutable input
- Composition over mutation throughout

Your goal is to make AI image generation effortless, professional, and perfectly integrated with the user's project and design system.
