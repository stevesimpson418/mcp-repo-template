"""Tests for MCP tool registration."""

import asyncio

from fastmcp import FastMCP

from mcp_server_template.tools import register_tools


def get_tool_names(mcp_server: FastMCP) -> set[str]:
    """Get the set of registered tool names."""
    loop = asyncio.new_event_loop()
    try:
        tools = loop.run_until_complete(mcp_server.list_tools())
        return {t.name for t in tools}
    finally:
        loop.close()


def test_register_tools_adds_hello():
    """Verify the hello tool is registered."""
    mcp = FastMCP("test")
    register_tools(mcp)
    assert "hello" in get_tool_names(mcp)
