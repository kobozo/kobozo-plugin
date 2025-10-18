# Agent SDK Development Plugin

**Official Claude Code Plugin by Anthropic**

A comprehensive plugin for developing applications with the Claude Agent SDK. This plugin streamlines the creation, configuration, and verification of Agent SDK applications in both TypeScript and Python.

## Version & Author

- **Version**: 1.0.0
- **Author**: Ashwin Bhat (ashwin@anthropic.com)
- **Maintainer**: Anthropic
- **Plugin Type**: Official Claude Code Plugin

> **Note**: This is an official plugin from Anthropic, synced from the official Claude Code plugins repository. It is maintained by Anthropic and represents the recommended approach for developing with the Claude Agent SDK.

## Table of Contents

- [Overview](#overview)
- [Key Features](#key-features)
- [Installation](#installation)
- [Commands](#commands)
  - [new-sdk-app](#new-sdk-app)
- [Agents](#agents)
  - [agent-sdk-verifier-ts](#agent-sdk-verifier-ts)
  - [agent-sdk-verifier-py](#agent-sdk-verifier-py)
- [Supported Languages](#supported-languages)
- [SDK Verification Features](#sdk-verification-features)
- [Usage Examples](#usage-examples)
- [Workflow](#workflow)
- [Best Practices](#best-practices)
- [Resources](#resources)

## Overview

The Agent SDK Development Plugin provides an end-to-end workflow for building applications with the Claude Agent SDK. It guides you through project setup, handles dependency installation, creates starter code, and verifies that your application follows SDK best practices.

This plugin is designed to work with both TypeScript and Python implementations of the Claude Agent SDK, providing language-specific guidance and verification.

## Key Features

- **Interactive Project Setup**: Guided questionnaire for gathering project requirements
- **Latest Version Management**: Automatically checks for and installs the latest SDK versions
- **Language Support**: Full support for TypeScript and Python
- **Starter Code Generation**: Creates working examples based on your use case
- **Type Safety**: TypeScript projects include full type checking and verification
- **SDK Verification**: Dedicated agents validate your application against SDK best practices
- **Documentation Integration**: References official Claude documentation throughout
- **Security First**: Proper environment variable handling and API key management
- **Package Manager Flexibility**: Supports npm, yarn, pnpm (TypeScript) and pip, poetry (Python)

## Installation

This plugin is synced from the official Anthropic repository. If you're using the official Claude Code plugins system, it should be automatically available in your `./claude/plugins/agent-sdk-dev/` directory.

To verify the plugin is available:

```bash
# Check if the plugin directory exists
ls -la ./claude/plugins/agent-sdk-dev/
```

The plugin should contain:
- `.claude-plugin/plugin.json` - Plugin metadata
- `commands/new-sdk-app.md` - Project creation command
- `agents/agent-sdk-verifier-ts.md` - TypeScript verification agent
- `agents/agent-sdk-verifier-py.md` - Python verification agent

## Commands

### new-sdk-app

Create and setup a new Claude Agent SDK application with interactive guidance.

**Syntax:**
```
/new-sdk-app [project-name]
```

**Arguments:**
- `[project-name]` (optional): The name of your project. If omitted, you'll be prompted to provide it.

**Interactive Workflow:**

The command asks questions one at a time to gather your requirements:

1. **Language Choice**: TypeScript or Python?
2. **Project Name**: What would you like to name your project?
3. **Agent Type**: What kind of agent are you building?
   - Coding agent (SRE, security review, code review)
   - Business agent (customer support, content creation)
   - Custom agent (describe your use case)
4. **Starting Point**:
   - Minimal "Hello World" example
   - Basic agent with common features
   - Specific example based on your use case
5. **Tooling Choice**: Confirms package manager preferences (npm/yarn/pnpm or pip/poetry)

**What It Does:**

1. **Project Initialization**
   - Creates project directory
   - Initializes package manager
   - Sets up configuration files (tsconfig.json, package.json, etc.)

2. **Version Management**
   - Checks for latest SDK version on npm or PyPI
   - Informs you of the version being installed
   - Installs the latest stable version

3. **SDK Installation**
   - TypeScript: Installs `@anthropic-ai/claude-agent-sdk@latest`
   - Python: Installs `claude-agent-sdk`
   - Verifies installed version

4. **Starter Files**
   - Creates working example code with proper imports
   - Includes error handling and modern syntax
   - Adds helpful comments explaining each part

5. **Environment Setup**
   - Creates `.env.example` with `ANTHROPIC_API_KEY`
   - Adds `.env` to `.gitignore`
   - Provides instructions for getting an API key

6. **Optional Claude Directory**
   - Offers to create `.claude/` structure
   - Can include example subagents and slash commands

7. **Code Verification**
   - TypeScript: Runs `npx tsc --noEmit` to check for type errors
   - Python: Verifies imports and syntax
   - Fixes all errors before completing setup

8. **SDK Verification**
   - Launches appropriate verifier agent (TypeScript or Python)
   - Validates SDK usage and configuration
   - Provides comprehensive verification report

**Example Usage:**

```bash
# With project name
/new-sdk-app my-coding-agent

# Without project name (will prompt)
/new-sdk-app
```

**Reference Documentation:**

The command automatically references:
- [Claude Agent SDK Overview](https://docs.claude.com/en/api/agent-sdk/overview)
- [TypeScript SDK Reference](https://docs.claude.com/en/api/agent-sdk/typescript)
- [Python SDK Reference](https://docs.claude.com/en/api/agent-sdk/python)

And guides on:
- Streaming vs Single Mode
- Permissions
- Custom Tools
- MCP Integration
- Subagents
- Sessions

## Agents

### agent-sdk-verifier-ts

Verifies TypeScript Agent SDK applications for correct SDK usage, adherence to best practices, and readiness for deployment.

**When to Use:**
- After creating a new TypeScript Agent SDK application
- After modifying an existing TypeScript SDK application
- Before deploying to production
- When troubleshooting SDK-related issues

**What It Checks:**

1. **SDK Installation & Configuration**
   - Verifies `@anthropic-ai/claude-agent-sdk` is installed
   - Checks SDK version is current
   - Validates `package.json` has `"type": "module"`
   - Confirms Node.js version requirements

2. **TypeScript Configuration**
   - Verifies `tsconfig.json` exists with appropriate settings
   - Checks module resolution for ES modules support
   - Ensures compilation target is modern enough
   - Validates settings won't break SDK imports

3. **SDK Usage & Patterns**
   - Verifies correct imports from SDK
   - Checks agent initialization follows SDK patterns
   - Validates agent configuration (system prompts, models)
   - Ensures SDK methods called correctly
   - Checks response handling (streaming vs single mode)
   - Verifies permissions configuration
   - Validates MCP server integration

4. **Type Safety & Compilation**
   - Runs `npx tsc --noEmit` for type checking
   - Verifies SDK imports have correct type definitions
   - Ensures code compiles without errors
   - Checks types align with SDK documentation

5. **Scripts & Build Configuration**
   - Verifies package.json has necessary scripts
   - Checks scripts are configured for TypeScript/ES modules
   - Validates application can be built and run

6. **Environment & Security**
   - Checks `.env.example` exists
   - Verifies `.env` is in `.gitignore`
   - Ensures no hardcoded API keys
   - Validates error handling around API calls

7. **SDK Best Practices**
   - Clear system prompts
   - Appropriate model selection
   - Proper permission scoping
   - Correct MCP integration
   - Proper subagent configuration
   - Correct session handling

8. **Functionality Validation**
   - Application structure makes sense
   - Agent initialization flow is correct
   - Error handling covers SDK errors
   - Follows SDK documentation patterns

9. **Documentation**
   - Checks for README
   - Verifies setup instructions
   - Ensures custom configurations documented

**What It Doesn't Check:**

- General code style preferences (formatting, naming)
- TypeScript style choices (type vs interface)
- Unused variable naming conventions
- General best practices unrelated to SDK

**Verification Process:**

1. Reads relevant files (package.json, tsconfig.json, source files)
2. Checks SDK documentation adherence via WebFetch
3. Runs type checking with TypeScript compiler
4. Analyzes SDK usage patterns
5. Generates comprehensive report

**Report Format:**

```
Overall Status: PASS | PASS WITH WARNINGS | FAIL

Summary: Brief overview of findings

Critical Issues:
- Issues preventing app from functioning
- Security problems
- SDK usage errors causing runtime failures
- Type errors or compilation failures

Warnings:
- Suboptimal SDK usage patterns
- Missing SDK features
- Documentation deviations
- Missing documentation

Passed Checks:
- Correctly configured items
- Properly implemented SDK features
- Security measures in place

Recommendations:
- Specific improvement suggestions
- SDK documentation references
- Enhancement next steps
```

**Invocation:**

The verifier is automatically launched by the `new-sdk-app` command for TypeScript projects. You can also invoke it manually:

```
@agent-sdk-verifier-ts
```

### agent-sdk-verifier-py

Verifies Python Agent SDK applications for correct SDK usage, adherence to best practices, and readiness for deployment.

**When to Use:**
- After creating a new Python Agent SDK application
- After modifying an existing Python SDK application
- Before deploying to production
- When troubleshooting SDK-related issues

**What It Checks:**

1. **SDK Installation & Configuration**
   - Verifies `claude-agent-sdk` is installed
   - Checks SDK version is current
   - Validates Python version requirements (3.8+)
   - Confirms virtual environment is documented

2. **Python Environment Setup**
   - Checks for requirements.txt or pyproject.toml
   - Verifies dependencies properly specified
   - Ensures version constraints documented
   - Validates environment reproducibility

3. **SDK Usage & Patterns**
   - Verifies correct imports from SDK
   - Checks agent initialization follows SDK patterns
   - Validates agent configuration
   - Ensures SDK methods called correctly
   - Checks response handling
   - Verifies permissions configuration
   - Validates MCP server integration

4. **Code Quality**
   - Checks for syntax errors
   - Verifies imports are correct and available
   - Ensures proper error handling
   - Validates code structure

5. **Environment & Security**
   - Checks `.env.example` exists
   - Verifies `.env` is in `.gitignore`
   - Ensures no hardcoded API keys
   - Validates error handling around API calls

6. **SDK Best Practices**
   - Clear system prompts
   - Appropriate model selection
   - Proper permission scoping
   - Correct MCP integration
   - Proper subagent configuration
   - Correct session handling

7. **Functionality Validation**
   - Application structure makes sense
   - Agent initialization flow is correct
   - Error handling covers SDK errors
   - Follows SDK documentation patterns

8. **Documentation**
   - Checks for README
   - Verifies setup instructions (including venv)
   - Ensures custom configurations documented
   - Confirms installation instructions clear

**What It Doesn't Check:**

- General code style (PEP 8 formatting)
- Python-specific style choices
- Import ordering preferences
- General best practices unrelated to SDK

**Verification Process:**

1. Reads relevant files (requirements.txt, source files)
2. Checks SDK documentation adherence via WebFetch
3. Validates imports and syntax
4. Analyzes SDK usage patterns
5. Generates comprehensive report

**Report Format:**

Same format as TypeScript verifier with Python-specific issues:

```
Overall Status: PASS | PASS WITH WARNINGS | FAIL

Summary: Brief overview of findings

Critical Issues:
- Issues preventing app from functioning
- Security problems
- SDK usage errors
- Syntax or import problems

Warnings:
- Suboptimal SDK usage
- Missing SDK features
- Documentation deviations
- Missing setup instructions

Passed Checks:
- Correctly configured items
- Properly implemented SDK features
- Security measures

Recommendations:
- Improvement suggestions
- SDK documentation references
- Enhancement next steps
```

**Invocation:**

The verifier is automatically launched by the `new-sdk-app` command for Python projects. You can also invoke it manually:

```
@agent-sdk-verifier-py
```

## Supported Languages

### TypeScript

**Package**: `@anthropic-ai/claude-agent-sdk`

**Requirements:**
- Node.js (version specified by SDK)
- Package manager: npm, yarn, or pnpm
- TypeScript compiler

**Features:**
- Full type safety with TypeScript definitions
- ES modules support
- Type checking integration
- Modern async/await syntax

**Project Structure:**
```
my-project/
├── package.json          # "type": "module"
├── tsconfig.json         # TypeScript configuration
├── .env.example          # Environment template
├── .gitignore           # Includes .env
├── src/
│   └── index.ts         # Main application
└── .claude/             # Optional: agents & commands
```

### Python

**Package**: `claude-agent-sdk`

**Requirements:**
- Python 3.8 or higher
- Package manager: pip or poetry
- Virtual environment (recommended)

**Features:**
- Clean Pythonic API
- Type hints support
- Async/await support
- Easy integration with Python ecosystem

**Project Structure:**
```
my-project/
├── requirements.txt     # or pyproject.toml
├── .env.example         # Environment template
├── .gitignore          # Includes .env
├── main.py             # Main application
└── .claude/            # Optional: agents & commands
```

## SDK Verification Features

The plugin includes comprehensive verification to ensure your Agent SDK application follows best practices:

### Automated Checks

- **Installation Verification**: Confirms SDK is properly installed
- **Version Checking**: Ensures SDK version is reasonably current
- **Configuration Validation**: Verifies all config files are correct
- **Type Safety** (TypeScript): Runs type checker to catch errors
- **Syntax Validation** (Python): Checks for basic syntax issues
- **Security Audit**: Ensures API keys are properly managed
- **Documentation Check**: Validates setup instructions exist

### SDK-Specific Validation

- **Import Correctness**: Verifies SDK imports follow documentation
- **Agent Initialization**: Checks agents are properly configured
- **Permission Configuration**: Validates permission scoping
- **MCP Integration**: Ensures tools are correctly integrated
- **Response Handling**: Verifies streaming/single mode usage
- **Error Handling**: Checks SDK-specific error handling

### Documentation Adherence

The verifiers reference official Claude documentation to ensure your application:
- Follows recommended patterns
- Uses SDK features correctly
- Implements best practices
- Matches official examples

## Usage Examples

### Creating a Coding Agent

```bash
/new-sdk-app code-reviewer
```

**Interactive Flow:**
1. Choose "TypeScript"
2. Project name: "code-reviewer" (pre-filled)
3. Agent type: "Coding agent - code review"
4. Starting point: "Basic agent with common features"
5. Tooling: Confirm npm (or choose pnpm)

**Result:**
- TypeScript project with SDK installed
- Example code review agent implementation
- Type-safe configuration
- Verified and ready to run

### Creating a Support Agent

```bash
/new-sdk-app support-bot
```

**Interactive Flow:**
1. Choose "Python"
2. Project name: "support-bot" (pre-filled)
3. Agent type: "Business agent - customer support"
4. Starting point: "Basic agent with common features"
5. Tooling: Confirm pip

**Result:**
- Python project with SDK installed
- Example support agent implementation
- Environment properly configured
- Verified and ready to run

### Minimal Hello World

```bash
/new-sdk-app
```

**Interactive Flow:**
1. Choose "TypeScript"
2. Project name: "my-first-agent"
3. Agent type: "Custom agent - just learning"
4. Starting point: "Minimal 'Hello World' example"
5. Tooling: Confirm npm

**Result:**
- Minimal TypeScript project
- Simple agent that responds to queries
- Perfect for learning SDK basics
- Verified and ready to experiment

## Workflow

The typical workflow when using this plugin:

### 1. Project Creation

```bash
/new-sdk-app my-agent
```

- Answer interactive questions
- Plugin creates project structure
- Installs latest SDK version
- Generates starter code

### 2. Automatic Verification

Plugin automatically runs verifier agent:
- TypeScript projects: `agent-sdk-verifier-ts`
- Python projects: `agent-sdk-verifier-py`

### 3. Review Verification Report

Check the report for:
- Critical issues (must fix)
- Warnings (should fix)
- Passed checks (working correctly)
- Recommendations (nice to have)

### 4. Fix Issues

Address any critical issues or warnings:
- SDK usage errors
- Configuration problems
- Security concerns
- Missing documentation

### 5. Run Your Agent

Follow the getting started guide:

**TypeScript:**
```bash
# Set API key
cp .env.example .env
# Edit .env with your API key

# Run the agent
npm start
```

**Python:**
```bash
# Create virtual environment
python -m venv venv
source venv/bin/activate  # or venv\Scripts\activate on Windows

# Set API key
cp .env.example .env
# Edit .env with your API key

# Run the agent
python main.py
```

### 6. Iterate & Verify

As you modify your agent:
- Make changes to your code
- Run verifier again if needed
- Keep SDK usage aligned with documentation

## Best Practices

### Version Management

- **Always use latest versions**: The plugin checks for latest SDK versions before installation
- **Stay updated**: Periodically update your SDK to get new features and fixes
- **Check compatibility**: Verify Node.js/Python version requirements

### Security

- **Never commit .env**: The plugin ensures `.env` is in `.gitignore`
- **Use .env.example**: Template for other developers without exposing keys
- **Get API keys**: From [Anthropic Console](https://console.anthropic.com/)
- **Rotate keys**: Change API keys periodically

### Code Organization

- **Use TypeScript for type safety**: Catch errors before runtime
- **Follow SDK patterns**: Reference official documentation
- **Handle errors properly**: Use try/catch around SDK calls
- **Document custom configurations**: Help future maintainers

### Development Workflow

- **Start with Hello World**: Learn basics before building complex agents
- **Use verifier agents**: Catch issues early
- **Test incrementally**: Add features one at a time
- **Reference documentation**: Link to official guides in comments

### TypeScript-Specific

- **Enable strict mode**: Catch more potential issues
- **Use proper module system**: Set `"type": "module"` in package.json
- **Run type checking**: Use `npm run typecheck` regularly
- **Fix all type errors**: Don't deploy with type issues

### Python-Specific

- **Use virtual environments**: Isolate dependencies
- **Pin dependencies**: Specify versions in requirements.txt
- **Type hints**: Use type hints for better code clarity
- **Follow SDK imports**: Use correct module names

## Resources

### Official Documentation

- **Agent SDK Overview**: [https://docs.claude.com/en/api/agent-sdk/overview](https://docs.claude.com/en/api/agent-sdk/overview)
- **TypeScript SDK**: [https://docs.claude.com/en/api/agent-sdk/typescript](https://docs.claude.com/en/api/agent-sdk/typescript)
- **Python SDK**: [https://docs.claude.com/en/api/agent-sdk/python](https://docs.claude.com/en/api/agent-sdk/python)

### Package Repositories

- **TypeScript Package**: [https://www.npmjs.com/package/@anthropic-ai/claude-agent-sdk](https://www.npmjs.com/package/@anthropic-ai/claude-agent-sdk)
- **Python Package**: [https://pypi.org/project/claude-agent-sdk/](https://pypi.org/project/claude-agent-sdk/)

### API Keys

- **Anthropic Console**: [https://console.anthropic.com/](https://console.anthropic.com/)

### Key Concepts

- **System Prompts**: Instructions defining agent behavior
- **Permissions**: Granular access control for agent capabilities
- **MCP (Model Context Protocol)**: Standard for custom tool integration
- **Subagents**: Specialized agents for specific tasks
- **Sessions**: Maintaining conversation context
- **Streaming vs Single Mode**: Response delivery patterns

### Common Next Steps

After creating your first agent, explore:

1. **Custom Tools**: Add domain-specific capabilities via MCP
2. **Subagents**: Break complex tasks into specialized agents
3. **Permissions**: Fine-tune what your agent can access
4. **Sessions**: Implement conversation memory
5. **Error Handling**: Robust handling of API errors
6. **Testing**: Add tests for your agent's behavior
7. **Deployment**: Move from development to production

---

**Questions or Issues?**

This is an official Anthropic plugin. For issues related to:
- **The plugin**: Check the official Claude Code plugins repository
- **The Agent SDK**: Refer to the official documentation
- **API access**: Contact Anthropic support

**Happy building with the Claude Agent SDK!**
