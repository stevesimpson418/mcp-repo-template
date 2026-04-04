#!/usr/bin/env bash
set -euo pipefail

# bootstrap.sh — Initialise a new MCP server from this template
#
# Usage: ./bootstrap.sh <project-name> <package-name> <github-user> <author-name>
#
# Example: ./bootstrap.sh gmail-mcp-server gmail_mcp your-github-user "Your Name"
#
# Arguments:
#   project-name   Hyphenated repo/project name (e.g. gmail-mcp-server)
#   package-name   Python package name with underscores (e.g. gmail_mcp)
#   github-user    GitHub username for badges/URLs
#   author-name    Full name for LICENSE copyright

if [[ $# -lt 4 ]]; then
  echo "Usage: $0 <project-name> <package-name> <github-user> <author-name>"
  echo "Example: $0 gmail-mcp-server gmail_mcp your-github-user \"Your Name\""
  exit 1
fi

PROJECT_NAME="$1"
PACKAGE_NAME="$2"
GITHUB_USER="$3"
AUTHOR_NAME="$4"

# Derive the CLI entry point name (strip -server suffix if present for cleaner CLI name)
CLI_NAME="${PROJECT_NAME}"

echo "Bootstrapping MCP server:"
echo "  Project:  ${PROJECT_NAME}"
echo "  Package:  ${PACKAGE_NAME}"
echo "  CLI:      ${CLI_NAME}"
echo "  GitHub:   ${GITHUB_USER}/${PROJECT_NAME}"
echo "  Author:   ${AUTHOR_NAME}"
echo ""

# --- Rename source directory ---
if [[ -d "src/mcp_server_template" ]]; then
  mv "src/mcp_server_template" "src/${PACKAGE_NAME}"
  echo "Renamed src/mcp_server_template -> src/${PACKAGE_NAME}"
fi

# --- Find and replace in all text files ---
# Using portable sed syntax (macOS + Linux compatible)
find_and_replace() {
  local old="$1"
  local new="$2"

  # Find text files, skip .git and binary files
  find . -type f \
    -not -path './.git/*' \
    -not -path './.venv/*' \
    -not -path './node_modules/*' \
    -not -name '*.pyc' \
    -not -name 'uv.lock' \
    -not -name 'bootstrap.sh' \
    -print0 \
    | while IFS= read -r -d '' file; do
      if file --mime-type "$file" | grep -q 'text/'; then
        if grep -q "$old" "$file" 2>/dev/null; then
          if [[ "$(uname)" == "Darwin" ]]; then
            sed -i '' "s|${old}|${new}|g" "$file"
          else
            sed -i "s|${old}|${new}|g" "$file"
          fi
        fi
      fi
    done
}

echo "Replacing placeholders..."
# Order matters: replace compound patterns before their substrings
find_and_replace "GITHUB_USER/mcp-server-template" "${GITHUB_USER}/${PROJECT_NAME}"
find_and_replace "AUTHOR_NAME" "${AUTHOR_NAME}"
find_and_replace "mcp-server-template" "${PROJECT_NAME}"
find_and_replace "mcp_server_template" "${PACKAGE_NAME}"

echo ""
echo "Done! Next steps:"
echo "  1. Update .env.example with your required env vars"
echo "  2. Update README.md description, tools table, and setup instructions"
echo "  3. Update CLAUDE.md with project-specific details"
echo "  4. Update pyproject.toml description and add your dependencies"
echo "  5. Replace src/${PACKAGE_NAME}/tools.py with your actual tools"
echo "  6. git init && git add -A && git commit -m 'feat: initial project scaffold'"
echo "  7. lefthook install"
echo "  8. uv sync --dev && uv run pytest -v"
