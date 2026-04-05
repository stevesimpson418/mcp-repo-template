# MCP Server Template

[![CI](https://github.com/stevesimpson418/mcp-repo-template/actions/workflows/ci.yml/badge.svg)](https://github.com/stevesimpson418/mcp-repo-template/actions/workflows/ci.yml)
[![codecov](https://codecov.io/gh/stevesimpson418/mcp-repo-template/graph/badge.svg)](https://codecov.io/gh/stevesimpson418/mcp-repo-template)
[![Python 3.12+](https://img.shields.io/badge/python-3.12+-blue.svg)](https://www.python.org/downloads/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A local [MCP](https://modelcontextprotocol.io/) server template for building Claude integrations. Runs locally via stdio
transport — all tokens and credentials stay on your machine.

## Prerequisites

- Python 3.12+
- [uv](https://docs.astral.sh/uv/) for dependency management

## Quick Start

```bash
# Clone the repo
git clone https://github.com/stevesimpson418/mcp-repo-template.git
cd mcp-server-template

# Install dependencies (creates .venv/ in the project directory)
uv sync

# Configure environment
cp .env.example .env
# Edit .env with your API credentials
```

> **New to uv?** `uv sync` reads `pyproject.toml`, creates a `.venv/` virtualenv inside the
> project folder, and installs all dependencies into it. You don't need to activate it —
> `uv run <command>` handles that automatically.

## Adding to Claude Desktop

Add to your Claude Desktop config (`~/Library/Application Support/Claude/claude_desktop_config.json` on macOS):

> **Tip:** Run `uv run which python` from the project directory to get the exact path for `command`.

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

### Usage Examples

**Verify the server is working:**

```text
hello()              → "Hello, World!"
hello(name="Alice")  → "Hello, Alice!"
```

Once you add your own tools, replace these examples with 2–3 realistic workflows
showing how the tools compose together. See the
[gmail-mcp-server README](https://github.com/stevesimpson418/gmail-mcp-server#usage-examples)
for a good model.

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

### Local `.env` file

When running the server manually outside Claude Desktop/Code (e.g., for development or
debugging), you can create a `.env` file in the project root so the server picks up
config without passing environment variables:

```text
API_TOKEN=your_token_here
```

This is only needed for local development. The Claude Desktop and Claude Code configs
pass these values directly via the `env` block.

## Bootstrapping a New Project

Use `bootstrap.sh` to create a new MCP server from this template:

```bash
./bootstrap.sh my-service my_service_package your-github-user "Your Name"
```

This renames all placeholders (package name, badges, LICENSE copyright), updates configs, and gets you ready to code.

## Packaging & Distribution

This server is currently distributed as source via git. To install:

```bash
git clone https://github.com/stevesimpson418/mcp-repo-template.git
cd mcp-server-template
uv sync
```

This is the standard distribution model for local-stdio MCP servers today. The project is
already configured for wheel builds via hatchling, so future distribution options include:

- **PyPI** — publish to PyPI, then install with `uv tool install <your-package>` or
  `pip install <your-package>`. Would require adding a publish workflow to CI.
- **uvx** — once on PyPI, `uvx <your-package>` runs the server without cloning the repo.
  Claude Desktop/Code config would point to the uvx-managed binary instead of a local `.venv`.

## License

MIT
