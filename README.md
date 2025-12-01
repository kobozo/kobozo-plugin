# Kobozo Plugins

A comprehensive collection of Claude Code plugins for software development, featuring tools for UI validation, bug fixing, code quality, performance optimization, security auditing, and much more.

## Overview

This repository contains 23 professional plugins that extend Claude Code with specialized workflows covering the entire software development lifecycle - from brainstorming and architecture to testing, deployment, and maintenance.

### Why Use This Marketplace?

- ✅ **Comprehensive Coverage**: 23 plugins covering UI, backend, testing, security, DevOps, and more
- ✅ **Easy Installation**: Install directly from GitHub with a single command
- ✅ **Production-Ready**: Battle-tested plugins used in real-world development
- ✅ **Multi-Agent Workflows**: Specialized agents for complex tasks
- ✅ **MCP Integration**: Leverage external services (context7, Playwright, Docker, etc.)
- ✅ **Regular Updates**: Synced with official Claude Code plugins
- ✅ **Open Source**: Free to use and customize

## 🚀 Quick Start

### For Claude Code Users

#### Prerequisites

- [Claude Code](https://docs.claude.com/en/docs/claude-code) installed
- Claude Code version that supports plugin marketplaces

#### Installation

1. **Add this marketplace to Claude Code from GitHub**:
   ```bash
   /plugin marketplace add kobozo/kobozo-plugin
   ```

   This will clone the marketplace from GitHub and make all plugins available to install.

2. **Browse and install plugins**:
   ```bash
   /plugin
   ```
   Then select "kobozo-plugin" marketplace and choose plugins to install.

   Or install directly:
   ```bash
   /plugin install <plugin-name>@kobozo-plugin
   ```

3. **Restart Claude Code** (if required by the plugin)

4. **Use the plugin**:
   ```bash
   /<command-name>
   ```

### Example

```bash
# Add marketplace from GitHub
/plugin marketplace add kobozo/kobozo-plugin

# Install bug-fixer plugin
/plugin install bug-fixer@kobozo-plugin

# Use it
/fix-bug "Payment processing fails with invalid discount codes"
```

### For OpenCode Users

**[OpenCode](https://opencode.ai)** is an AI coding agent built for the terminal, similar to Claude Code but with a different architecture.

All plugins have been restructured for OpenCode compatibility in the `opencode/` directory.

#### Quick Installation

Create a symbolic link to use these plugins with OpenCode:

```bash
# Navigate to this repository
cd /path/to/kobozo-plugin

# Create symbolic link to OpenCode config directory
ln -s $(pwd)/opencode ~/.config/opencode
```

Or link individual directories:

```bash
ln -s $(pwd)/opencode/agent ~/.config/opencode/agent
ln -s $(pwd)/opencode/command ~/.config/opencode/command
ln -s $(pwd)/opencode/opencode.json ~/.config/opencode/opencode.json
```

#### What You Get

- **71 Specialized Agents** - All plugin agents in one place
- **45 Custom Commands** - All slash commands ready to use
- **6 MCP Servers** - Pre-configured external tools
- **Single Configuration** - One `opencode.json` for everything

See [opencode/README.md](./opencode/README.md) for detailed OpenCode setup instructions.

---

## Plugin Categories

### 🎨 UI & Design

#### [ui-checker](./plugins/ui-checker/README.md)
**v2.0.0** - Automated UI validation and React component generation

**Commands**:
- `/ui-check [page-name]` - Validate UI against style guide with Playwright
- `/create-style-guide` - Create comprehensive design system documentation
- `/setup-design-system` - Set up Tailwind with semantic design tokens
- `/create-component` - Generate beautiful React components

**Features**:
- Automated Playwright testing with screenshots
- Style guide compliance scoring (1-10 scale)
- Violation detection with actionable fixes
- React component generation with Tailwind CSS
- Design system token management

---

### 🐛 Development & Debugging

#### [bug-fixer](./plugins/bug-fixer/README.md)
**v1.0.0** - Comprehensive bug fixing workflow

**Commands**:
- `/fix-bug [description]` - Systematic bug analysis, fix, and validation

**Workflow**:
1. **Discovery** - Clarify bug details
2. **Analysis** - Deep root cause investigation
3. **Questions** - Resolve uncertainties
4. **Fix Design** - Present multiple approaches
5. **Implementation** - Implement approved fix
6. **Validation** - Thorough testing
7. **Summary** - Document changes

---

#### [feature-dev](./claude/plugins/feature-dev/README.md)
**v1.1.0** - Guided feature development with codebase understanding and library research

**Commands**:
- `/feature-dev [description]` - Complete feature development workflow

**Agents**:
- **code-explorer** - Analyze existing patterns
- **code-snippet-researcher** - Research library documentation (context7)
- **code-architect** - Design feature architecture
- **code-reviewer** - Review implementation quality

---

#### [dead-code-detector](./plugins/dead-code-detector/README.md)
**v1.0.0** - Detect and eliminate unused code

**Commands**:
- `/scan-dead-code` - Comprehensive dead code analysis

**Detects**:
- Unused functions and variables
- Orphaned files
- Unreachable code paths
- Unused imports
- Dead dependencies
- Circular dependencies

---

### 📚 Documentation

#### [documentation-writer](./plugins/documentation-writer/README.md)
**v1.0.0** - Generate comprehensive technical documentation

**Commands**:
- `/document-this [subject]` - Create GitHub wiki documentation

**Types**:
- Feature documentation
- API documentation
- Architecture guides
- Tutorials
- How-to guides

---

#### [api-documenter](./plugins/api-documenter/README.md)
**v1.0.0** - Automated API documentation generation

**Commands**:
- `/api-docs` - Generate complete API documentation
- `/update-api-docs` - Update existing documentation

**Features**:
- Scans codebase for endpoints
- Generates OpenAPI/Swagger specs
- Creates human-readable documentation
- Supports REST, GraphQL, gRPC

---

### 🏗️ Architecture & Design

#### [brainstorm](./plugins/brainstorm/README.md)
**v1.1.0** - Research-driven brainstorming and specification

**Commands**:
- `/brainstorm [idea]` - Research and architect solutions

**Workflow**:
1. **Research** - Web and codebase research
2. **Architecture** - Design solution approaches
3. **Requirements** - Generate implementation specs
4. **Review** - Gather feedback
5. **Handoff** - Create complete documentation package

**Output**: Comprehensive specs without writing code

---

#### [code-architect](./plugins/code-architect/README.md)
**v1.0.0** - Architecture documentation and visualization

**Commands**:
- `/analyze-architecture` - Generate architecture docs
- `/generate-docs` - Create comprehensive documentation

**Features**:
- Dependency graphs
- Architecture diagrams (Mermaid)
- ADRs (Architecture Decision Records)
- Component documentation
- System design docs

---

### ✅ Testing & Quality

#### [test-suite-generator](./plugins/test-suite-generator/README.md)
**v1.0.0** - Generate comprehensive test suites

**Commands**:
- `/generate-tests` - Create unit and integration tests
- `/coverage-report` - Analyze test coverage

**Features**:
- Unit test generation
- Integration test generation
- Edge case coverage
- Mocking strategies
- Coverage analysis

---

#### [clean-code-checker](./plugins/clean-code-checker/README.md)
**v1.0.0** - Code quality and clean code analysis

**Commands**:
- `/analyze-code-quality` - Comprehensive quality analysis
- `/detect-duplication` - Find duplicated code

**Detects**:
- Code smells
- SOLID violations
- DRY violations
- Complexity issues
- Duplication
- Anti-patterns

---

#### [pr-review-toolkit](./claude/plugins/pr-review-toolkit/README.md)
**v1.0.0** - Comprehensive PR review tools

**Commands**:
- `/review-pr [aspects]` - Multi-agent PR review

**Review Aspects**:
- Code quality and style
- Test coverage
- Silent failures
- Type design
- Comment accuracy
- Code simplification

---

### 🔒 Security & Privacy

#### [security-auditor](./plugins/security-auditor/README.md)
**v1.0.0** - Security vulnerability scanning

**Commands**:
- `/security-audit` - Comprehensive security audit
- `/dependency-check` - Quick dependency scan

**Scans**:
- Code vulnerabilities (SQL injection, XSS, etc.)
- Dependency vulnerabilities
- Authentication/authorization issues
- Security best practices

---

#### [data-privacy-manager](./plugins/data-privacy-manager/README.md)
**v1.0.0** - Data privacy and GDPR compliance

**Commands**:
- `/privacy-audit` - GDPR compliance check
- `/anonymize-data` - Generate anonymization scripts

**Features**:
- GDPR compliance auditing
- Data anonymization
- Privacy policy generation
- Consent mechanism validation

---

### ⚡ Performance & Optimization

#### [performance-optimizer](./plugins/performance-optimizer/README.md)
**v1.0.0** - Application performance optimization

**Commands**:
- `/profile-performance` - Comprehensive performance analysis
- `/optimize-bundle` - Bundle size optimization

**Optimizes**:
- JavaScript bundle sizes
- Database queries
- Code bottlenecks
- Load times
- Runtime performance

---

### 🗄️ Database & Schema

#### [db-schema-manager](./plugins/db-schema-manager/README.md)
**v1.0.0** - Database schema management

**Commands**:
- `/analyze-schema` - Analyze database schema
- `/generate-migration` - Create migration scripts

**Features**:
- Schema analysis
- Relationship mapping
- Migration generation
- Optimization recommendations
- Multi-ORM support

---

### 🌍 Internationalization

#### [i18n-manager](./plugins/i18n-manager/README.md)
**v1.1.0** - i18n and localization management

**Commands**:
- `/extract-translations` - Extract translatable strings
- `/validate-locales` - Validate translation files
- `/migrate-to-i18n` - Refactor hardcoded strings

**Features**:
- Translation extraction
- Locale validation
- Missing translation detection
- i18n optimization
- Multiple framework support

---

### 📱 User Experience

#### [onboarding-assistant](./plugins/onboarding-assistant/README.md)
**v1.0.0** - Interactive user onboarding

**Commands**:
- `/create-tour` - Create product tours
- `/design-onboarding` - Design onboarding flows

**Features**:
- Guided walkthroughs
- Interactive tours
- Tooltips and hints
- Multi-step flows
- Progress tracking

---

### 🐳 DevOps & Deployment

#### [docker-compose-manager](./plugins/docker-compose-manager/README.md)
**v1.0.0** - Docker Compose environment management

**Commands**:
- `/setup-docker-env` - Set up Docker Compose environment
- `/configure-nginx` - Configure nginx reverse proxy

**Features**:
- Container orchestration
- Nginx reverse proxy setup
- Service routing
- SSL configuration
- Load balancing

---

### 🔧 Development Tools

#### [agent-sdk-dev](./claude/plugins/agent-sdk-dev/README.md)
**v1.0.0** - Claude Agent SDK development tools

**Commands**:
- `/new-sdk-app [name]` - Create new Agent SDK application

**Features**:
- TypeScript and Python support
- Template generation
- SDK verification
- Best practices validation

---

#### [commit-commands](./claude/plugins/commit-commands/README.md)
**v1.0.0** - Git workflow automation

**Commands**:
- `/commit` - Create git commit
- `/commit-push-pr` - Commit, push, and create PR
- `/clean_gone` - Clean deleted branches

---

#### [security-guidance](./claude/plugins/security-guidance/README.md)
**v1.0.0** - Security guidance for Claude Code agents

Provides security context and guidance for defensive security tasks.

---

## Installation by Use Case

### For UI/Frontend Developers
```bash
/plugin install ui-checker@kobozo-plugin
/plugin install onboarding-assistant@kobozo-plugin
/plugin install i18n-manager@kobozo-plugin
```

### For Backend Developers
```bash
/plugin install api-documenter@kobozo-plugin
/plugin install db-schema-manager@kobozo-plugin
/plugin install security-auditor@kobozo-plugin
```

### For Full-Stack Developers
```bash
/plugin install feature-dev@kobozo-plugin
/plugin install bug-fixer@kobozo-plugin
/plugin install test-suite-generator@kobozo-plugin
```

### For DevOps Engineers
```bash
/plugin install docker-compose-manager@kobozo-plugin
/plugin install performance-optimizer@kobozo-plugin
```

### For Team Leads
```bash
/plugin install code-architect@kobozo-plugin
/plugin install brainstorm@kobozo-plugin
/plugin install clean-code-checker@kobozo-plugin
```

### For Security Specialists
```bash
/plugin install security-auditor@kobozo-plugin
/plugin install data-privacy-manager@kobozo-plugin
```

## Plugin Development

### Structure

Each plugin follows this structure:

```
plugin-name/
├── .claude-plugin/
│   └── plugin.json           # Plugin metadata
├── agents/                   # Specialized agents
│   └── agent-name.md
├── commands/                 # Slash commands
│   └── command-name.md
└── README.md                # Plugin documentation
```

### Creating a Plugin

1. Create plugin directory in `./plugins/` or `./claude/plugins/`
2. Add `.claude-plugin/plugin.json` with metadata
3. Create command files in `commands/` directory
4. Create agent files in `agents/` directory
5. Write comprehensive `README.md`

### Plugin Metadata

```json
{
  "name": "my-plugin",
  "version": "1.0.0",
  "description": "Plugin description",
  "author": {
    "name": "Your Name",
    "email": "your@email.com"
  },
  "mcpServers": {
    "server-name": {
      "command": "command",
      "args": ["arg1", "arg2"]
    }
  }
}
```

## Repository Structure

```
kobozo-plugins/
├── plugins/                  # Kobozo-authored plugins (18 plugins)
│   ├── ui-checker/
│   ├── bug-fixer/
│   ├── brainstorm/
│   ├── api-documenter/
│   ├── code-architect/
│   ├── clean-code-checker/
│   ├── performance-optimizer/
│   ├── security-auditor/
│   ├── test-suite-generator/
│   ├── documentation-writer/
│   ├── db-schema-manager/
│   ├── data-privacy-manager/
│   ├── i18n-manager/
│   ├── onboarding-assistant/
│   ├── docker-compose-manager/
│   ├── dead-code-detector/
│   └── ...
├── claude/plugins/           # Official Claude plugins (5 plugins)
│   ├── feature-dev/
│   ├── pr-review-toolkit/
│   ├── agent-sdk-dev/
│   ├── commit-commands/
│   └── security-guidance/
├── README.md                 # This file
└── sync-official-plugins.sh  # Sync script for official plugins
```

## Official Claude Plugins

This repository includes official Claude Code plugins synced from the official repository:

- **feature-dev** - Comprehensive feature development workflow
- **pr-review-toolkit** - Multi-agent PR review system
- **agent-sdk-dev** - Agent SDK development tools
- **commit-commands** - Git workflow automation
- **security-guidance** - Security guidance for agents

These are synced using `./sync-official-plugins.sh` to stay up-to-date with the official repository.

## Contributing

Contributions are welcome! To contribute:

1. Fork the repository
2. Create a new branch for your plugin
3. Follow the plugin structure guidelines
4. Write comprehensive documentation
5. Test thoroughly
6. Submit a pull request

## Best Practices

### Using Plugins Effectively

1. **Start with Research**: Use `/brainstorm` before implementing complex features
2. **Architecture First**: Use `/analyze-architecture` to understand codebase structure
3. **Fix Systematically**: Use `/fix-bug` for comprehensive bug fixing
4. **Test Thoroughly**: Use `/generate-tests` for comprehensive test coverage
5. **Review Quality**: Use `/analyze-code-quality` before merging
6. **Document Everything**: Use `/document-this` to keep docs updated
7. **Maintain Cleanliness**: Run `/scan-dead-code` regularly

### Workflow Example

```bash
# 1. Research a new feature
/brainstorm "Real-time notification system"

# 2. Develop the feature
/feature-dev "Implement notification system based on brainstorm specs"

# 3. Generate tests
/generate-tests

# 4. Check code quality
/analyze-code-quality

# 5. Review PR
/review-pr

# 6. Document
/document-this "notification system"

# 7. Optimize
/profile-performance
/optimize-bundle
```

## Troubleshooting

### Marketplace not found

**Issue**: "Marketplace not found" error when adding from GitHub

**Solution**:
- Ensure you have an internet connection
- Verify the repository name is correct: `kobozo/kobozo-plugin`
- Check that Claude Code has GitHub access
- Try updating Claude Code to the latest version

### Plugin installation fails

**Issue**: Plugin fails to install from marketplace

**Solution**:
- Verify the marketplace was added successfully: `/plugin marketplace list`
- Use the exact marketplace name: `@kobozo-plugin`
- Try removing and re-adding the marketplace
- Restart Claude Code after adding the marketplace

### Plugin commands not working

**Issue**: Plugin commands don't appear or don't work

**Solution**:
- Verify plugin is installed: `/plugin list`
- Restart Claude Code after installing plugins
- Check for any MCP server requirements (e.g., `CONTEXT7_API_KEY` for feature-dev)
- Review plugin README for specific setup requirements

### MCP server errors

**Issue**: Plugin fails with MCP server connection errors

**Solution**:
- Check if required environment variables are set
- Example: `export CONTEXT7_API_KEY=your_key` for feature-dev plugin
- Add environment variables to your shell config (`.bashrc`, `.zshrc`)
- Restart Claude Code after setting environment variables

## Support

**Author**: Yannick De Backer
**Email**: yannick@kobozo.eu
**GitHub**: [https://github.com/kobozo/kobozo-plugin](https://github.com/kobozo/kobozo-plugin)

For issues, questions, or feature requests, please open an issue on GitHub or contact the author.

## License

Custom plugin collection for Kobozo development.

## Acknowledgments

- Official Claude Code plugins by Anthropic
- Claude Code platform and team
- All contributors

---

**Total Plugins**: 23 (18 Kobozo + 5 Official Claude)
**Version**: 1.1.0
**Last Updated**: 2025-11-02
