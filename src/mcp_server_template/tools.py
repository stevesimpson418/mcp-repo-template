"""MCP tool definitions."""

from fastmcp import FastMCP


def register_tools(mcp: FastMCP) -> None:
    """Register all MCP tools with the server."""

    @mcp.tool()
    def hello(name: str = "world") -> str:
        """Say hello — a placeholder tool to verify the server works."""
        return f"Hello, {name}!"
