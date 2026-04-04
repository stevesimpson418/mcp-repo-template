# MCP Server Template

[![CI](https://github.com/GITHUB_USER/mcp-server-template/actions/workflows/ci.yml/badge.svg)](https://github.com/GITHUB_USER/mcp-server-template/actions/workflows/ci.yml)
[![codecov](https://codecov.io/gh/GITHUB_USER/mcp-server-template/graph/badge.svg)](https://codecov.io/gh/GITHUB_USER/mcp-server-template)
[![Python 3.12+](https://img.shields.io/badge/python-3.12+-blue.svg)](https://www.python.org/downloads/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A local [MCP](https://modelcontextprotocol.io/) server template for building Claude integrations. Runs locally via stdio transport — all tokens and credentials stay on your machine.

## Prerequisites

- Python 3.12+
- [uv](https://docs.astral.sh/uv/) for dependency management

## Quick Start

```bash
# Clone the repo
git clone https://github.com/GITHUB_USER/mcp-server-template.git
cd mcp-server-template

# Install dependencies
uv sync

# Configure environment
cp .env.example .env
# Edit .env with your API credentials
```

## Adding to Claude Desktop

Add to your Claude Desktop config (`~/Library/Application Support/Claude/claude_desktop_config.json` on macOS):

```json
{
  "mcpServers": {
    "my-server": {
      "command": "/absolute/path/to/.venv/bin/python",
      "args": ["-m", "mcp_server_template.server"],
      "env": {
        "API_TOKEN": "your_token_here"
      }
    }
  }
}
```

## Adding to Claude Code

Add to your Claude Code settings (`.claude/settings.json` or global):

```json
{
  "mcpServers": {
    "my-server": {
      "command": "/absolute/path/to/.venv/bin/python",
      "args": ["-m", "mcp_server_template.server"],
      "env": {
        "API_TOKEN": "your_token_here"
      }
    }
  }
}
```

## Available Tools

| Tool | Description |
|------|-------------|
| `hello(name?)` | Say hello — placeholder tool to verify the server works |

## Development

```bash
# Install dev dependencies
uv sync --dev

# Run tests
uv run pytest -v

# Run tests with coverage
uv run pytest --cov=mcp_server_template --cov-report=term-missing

# Lint
uv run ruff check src/ tests/

# Format
uv run ruff format src/ tests/

# Install git hooks
lefthook install
```

## Bootstrapping a New Project

Use `bootstrap.sh` to create a new MCP server from this template:

```bash
./bootstrap.sh my-service my_service_package your-github-user "Your Name"
```

This renames all placeholders (package name, badges, LICENSE copyright), updates configs, and gets you ready to code.

## License

MIT
