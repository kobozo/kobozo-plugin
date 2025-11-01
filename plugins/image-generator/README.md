# Image Generator Plugin

AI-powered image generation with intelligent prompt engineering for Claude Code. Supports multiple services (Nano Banana/Gemini, DALL-E) with automatic style guide integration.

## Features

- 🎨 **Multi-Service Support**: Nano Banana (Gemini 2.5 Flash Image) and DALL-E 3
- 🧠 **Intelligent Prompt Engineering**: Automatically engineers optimal prompts for each service
- 🎯 **Service Auto-Detection**: Recommends best service based on requirements
- 📐 **Style Guide Integration**: Seamlessly integrates brand colors and design tokens
- 🖼️ **Reference Style Transfer**: Extract visual style from reference images
- 🔄 **Variation Generation**: Generate multiple variations with different angles/colors/styles
- 📁 **Smart File Placement**: Context-aware output location based on project type
- 💰 **Cost Tracking**: Transparent cost estimation and actual cost reporting
- ⚡ **Functional Architecture**: Pure functions with side effects isolated
- 🔧 **Extensible Design**: Easy to add new services via service info files

## Installation

This plugin is part of the kobozo-plugins collection. Install via:

```bash
# Clone the repository
git clone https://github.com/yannickdb/kobozo-plugins.git

# Add to Claude Code plugin path
# (Follow Claude Code plugin installation instructions)
```

## Quick Start

### 1. Set up API Keys

Get API keys from the services you want to use:

**Nano Banana (Gemini)**:
```bash
export GEMINI_API_KEY="your-api-key-here"
# Get key from: https://aistudio.google.com/apikey
```

**DALL-E (OpenAI)**:
```bash
export OPENAI_API_KEY="your-api-key-here"
# Get key from: https://platform.openai.com/api-keys
```

### 2. Generate Your First Image

```bash
/generate-image "hero image for SaaS platform, modern and professional"
```

The system will:
1. Analyze your requirements
2. Detect your project type
3. Check for style guide
4. Engineer an optimal prompt
5. Generate the image
6. Save it to the appropriate location
7. Provide usage examples

### 3. Use the Generated Image

The plugin provides framework-specific usage examples:

**Next.js / React**:
```jsx
import Image from 'next/image'

<Image
  src="/images/saas-hero-image.png"
  alt="Hero image"
  width={1920}
  height={1080}
/>
```

## Usage Examples

### Basic Usage

```bash
# Simple generation (auto-detects service and location)
/generate-image "button icon with play symbol"

# Specify service
/generate-image "logo design" --service nano-banana
/generate-image "abstract art" --service dalle

# Custom output location
/generate-image "product photo" --output public/images/products/
```

### With Style Guide Integration

```bash
# Force style guide integration
/generate-image "hero banner" --use-style-guide

# Skip style guide integration
/generate-image "random artwork" --no-style-guide

# Style guide is automatically considered for UI components
/generate-image "button icon"  # Asks about style guide
```

### Reference Images

```bash
# From URL
/generate-image "product photo like https://example.com/reference.jpg"

# From local path
/generate-image "hero image similar to ./examples/hero.jpg"

# Multiple references
/generate-image "combine styles from ./ref1.jpg and ./ref2.jpg"
```

### Variations

```bash
# Generate 3 variations
/generate-image "mascot character" --count 3

# System automatically chooses variation strategy:
# - Angle variations (front, side, three-quarter view)
# - Color variations (warm, cool, vibrant tones)
# - Style variations (photorealistic, illustrated, minimalist)
```

### Service-Specific Parameters

**Nano Banana**:
```bash
# Aspect ratios: 1:1, 16:9, 9:16, 4:3, 3:4, etc.
/generate-image "hero image" --aspect-ratio 16:9
/generate-image "social media post" --aspect-ratio 1:1
/generate-image "mobile story" --aspect-ratio 9:16
```

**DALL-E**:
```bash
# Sizes: 1024x1024, 1024x1792, 1792x1024
/generate-image "portrait" --size 1024x1792 --quality hd --style natural

# Quality: standard (cheaper) or hd (higher detail)
# Style: vivid (dramatic) or natural (realistic)
```

## Architecture

The plugin uses a **4-agent workflow** with functional programming principles:

### Agent Pipeline

```
User Input
    ↓
requirements-analyzer (pure)
    ↓ RequirementsSpecification
style-context-extractor (pure)
    ↓ StyleContext
prompt-engineer (pure)
    ↓ EngineeredPrompts
image-generator (side effects)
    ↓
Generated Images
```

### Agents

1. **requirements-analyzer**: Pure analysis
   - Parses user intent
   - Detects project type
   - Identifies references
   - Determines output location
   - Recommends service

2. **style-context-extractor**: Pure extraction
   - Reads style guide files
   - Extracts design tokens
   - Translates to descriptive language
   - Builds style context

3. **prompt-engineer**: Pure composition
   - Reads service info files
   - Composes prompts functionally
   - Integrates style context
   - Generates variations
   - Optimizes for service

4. **image-generator**: Side effects isolated
   - Validates API credentials
   - Invokes MCP tools
   - Saves images
   - Generates reports

### Functional Programming

The architecture emphasizes:
- **Pure functions** for analysis and prompt engineering
- **Immutable data** structures throughout
- **Side effects isolation** in final agent only
- **Function composition** via `pipe()`
- **Declarative** approach over imperative

## Services

### Nano Banana (Google Gemini 2.5 Flash Image)

**Model**: `gemini-2-5-flash-image-preview`

**Best For**:
- Photorealistic images
- Detailed scenes and environments
- Product photography
- Architectural visualizations
- Character designs with consistency

**Capabilities**:
- 10 aspect ratios
- Style transfer from references
- Character consistency
- High detail and realism

**Cost**: ~$0.039 per image

**Prompt Style**: Highly descriptive, cinematic language with technical photography details

### DALL-E 3 (OpenAI)

**Model**: `dall-e-3`

**Best For**:
- Conceptual and abstract art
- Creative interpretations
- Text within images
- Surreal scenes
- Marketing visuals

**Capabilities**:
- Natural language understanding
- Creative interpretation
- Text rendering
- Multiple size options
- Quality levels

**Cost**: $0.040-$0.120 per image

**Prompt Style**: Natural, conversational descriptions

## Service Info Files

A key innovation of this plugin is **service info files** - JSON files describing service-specific requirements:

```
services/
├── nano-banana.json    # Nano Banana prompt guidelines
└── dalle.json          # DALL-E prompt guidelines
```

Each file contains:
- Prompt engineering guidelines
- Examples (user intent → engineered prompt)
- Parameter definitions
- Optimization tips
- Error handling guidance

The **prompt-engineer agent reads these files**, eliminating the need for per-service agents and avoiding code duplication.

### Adding New Services

To add a new service:

1. Add MCP server to `plugin.json`
2. Create `services/new-service.json` with requirements
3. Update image-generator agent for MCP invocation

No changes needed to prompt-engineer agent - it reads service info automatically!

## Style Guide Integration

If you have a style guide at `docs/style-guide/`, the plugin can integrate design tokens:

### What Gets Integrated

- **Color Palette**: Brand colors applied to generated images
- **Typography Style**: Font characteristics → visual style
- **Visual Effects**: Shadows, gradients, glass morphism
- **Design Principles**: Overall aesthetic and feel

### Integration Levels

**Full** (UI components, hero images):
```
Modern button icon with vibrant blue (#4A90E2) to deeper blue (#357ABD)
gradient, 8px rounded corners, subtle shadow elevation, clean geometric style
reflecting Inter font's modern aesthetic
```

**Colors Only** (illustrations):
```
Creative illustration using brand colors: vibrant blue (#4A90E2), deep navy
(#1A1F36), purple (#6B46C1) accents
```

**Aesthetic Only** (product photos):
```
Product photograph with modern, minimalist aesthetic featuring clean lines
and professional polish
```

**Minimal** (artistic freedom):
```
Artwork with professional, polished quality
```

### Creating a Style Guide

Use the `ui-checker` plugin to create a style guide:

```bash
/ui-checker:create-style-guide
```

This generates comprehensive design documentation that image-generator can use.

## Cost Management

### Cost Estimation

Before generation:
```
Estimated cost: $0.12 for 3 images (DALL-E HD 1024x1024)
```

After generation:
```
Total cost: ~$0.117 (3 images generated successfully)
```

### Cost Comparison

**Nano Banana**:
- Standard: $0.039 per image (all aspect ratios)

**DALL-E**:
- Standard 1024x1024: $0.040
- Standard 1024x1792 or 1792x1024: $0.080
- HD 1024x1024: $0.080
- HD 1024x1792 or 1792x1024: $0.120

### Tracking Usage

- **Gemini**: https://console.cloud.google.com/billing
- **OpenAI**: https://platform.openai.com/usage

## Error Handling

The plugin handles errors gracefully:

### Missing API Key
```
❌ Error: GEMINI_API_KEY not set

Solution:
1. Get API key from https://aistudio.google.com/apikey
2. Set: export GEMINI_API_KEY="your-key"
3. Restart Claude Code

Alternative: Try --service dalle if available
```

### Rate Limits
```
❌ Rate limit exceeded

Solution:
1. Wait a few moments
2. Check usage dashboard
3. Try alternative service
```

### Partial Success

If some images succeed:
- Successful images are saved
- Failures are reported clearly
- Recovery options provided
- Can retry individually

## Output

### Smart File Placement

Based on project type:
- **Next.js**: `public/images/`
- **React**: `public/images/` or `src/assets/`
- **Vue**: `public/images/`
- **Documentation**: `docs/images/`
- **Generic**: `images/`

### Filename Generation

From prompt:
- "hero image for SaaS" → `saas-hero-image.png`
- "button icon play" → `button-icon-play.png`
- "coffee mug product" → `coffee-mug-product.png`

### Summary Report

After generation:
1. Generated images with paths
2. Framework-specific usage code
3. Prompt details (what was sent)
4. Cost breakdown
5. Next steps and optimization tips
6. File structure

## Examples by Use Case

### UI Component
```bash
/generate-image "modern search icon, minimalist style" --aspect-ratio 1:1
```
→ Uses style guide, optimized for web, saved to `public/images/`

### Website Hero
```bash
/generate-image "hero image showing team collaboration" --aspect-ratio 16:9 --use-style-guide
```
→ Brand colors integrated, 16:9 for header, high quality

### Social Media
```bash
/generate-image "Instagram post about productivity" --aspect-ratio 1:1 --count 3
```
→ Square format, 3 variations, brand-consistent

### Product Photography
```bash
/generate-image "coffee mug on wooden table, warm lighting, professional" --quality hd
```
→ Photorealistic, minimal style constraint, focuses on lighting

### Logo/Branding
```bash
/generate-image "tech startup mascot, friendly robot character" --count 3 --use-style-guide
```
→ Full brand integration, 3 options to choose from

## Advanced Usage

### Combining Features

```bash
/generate-image "hero image similar to ./examples/ref.jpg" \
  --aspect-ratio 16:9 \
  --count 2 \
  --use-style-guide \
  --quality hd
```

This:
1. Analyzes reference image for style
2. Uses 16:9 aspect ratio
3. Generates 2 variations
4. Integrates style guide
5. Uses HD quality
6. Engineers optimal prompts for all requirements

### Iterative Refinement

```bash
# First attempt
/generate-image "product photo of headphones"

# Review result, refine
/generate-image "product photo of headphones, dramatic lighting, black background" --quality hd

# Final iteration with reference
/generate-image "product photo like ./prev-image.png but closer angle" --quality hd
```

## Best Practices

1. **Start Simple**: Test basic prompts first
2. **Use Style Guide**: For branded content
3. **Provide References**: For specific visual styles
4. **Generate Variations**: Get multiple options
5. **Choose Right Service**:
   - Nano Banana: Photorealistic, detailed
   - DALL-E: Creative, conceptual
6. **Iterate**: Refine prompts based on results
7. **Track Costs**: Monitor API usage
8. **Document Success**: Save prompts that work well

## Troubleshooting

### Plugin Not Found
- Verify plugin installation
- Check `.claude-plugin/plugin.json` exists
- Restart Claude Code

### MCP Server Errors
- Verify API key is set correctly
- Check network connectivity
- Try manual install: `npx -y <package>`

### Style Guide Not Integrated
- Ensure style guide exists at `docs/style-guide/`
- Use `--use-style-guide` to force
- Create with: `/ui-checker:create-style-guide`

### Images Not Saved
- Check output directory permissions
- Verify disk space available
- Try explicit `--output` path

## Development

### Plugin Structure

```
plugins/image-generator/
├── .claude-plugin/
│   └── plugin.json              # MCP servers, metadata
├── commands/
│   └── generate-image.md        # Main command orchestrator
├── agents/
│   ├── requirements-analyzer.md # Requirements analysis (pure)
│   ├── style-context-extractor.md # Style extraction (pure)
│   ├── prompt-engineer.md       # Prompt engineering (pure)
│   └── image-generator.md       # Generation (side effects)
├── services/
│   ├── nano-banana.json         # Nano Banana service info
│   └── dalle.json               # DALL-E service info
├── examples/
│   └── prompts.md               # Example prompts
└── README.md
```

### Testing

Use mock mode for testing without API costs:
- Agents 1-3 (pure functions) can be tested directly
- Agent 4 (image-generator) has mock MCP responses
- Test each agent independently
- Test full pipeline integration

### Contributing

Contributions welcome! Areas for improvement:
- Additional services (Midjourney, Stable Diffusion, etc.)
- Enhanced style transfer algorithms
- Better reference image analysis
- More variation strategies
- Cost optimization features

## Related Plugins

- **ui-checker**: Create and manage style guides
- **feature-dev**: Feature development workflow
- **brainstorm**: Research and requirements gathering

## License

Part of the kobozo-plugins collection.

## Author

Yannick De Backer <yannick@kobozo.eu>

## Version

1.0.0

---

**Generate beautiful AI images with intelligent prompt engineering, seamlessly integrated with your design system.**
