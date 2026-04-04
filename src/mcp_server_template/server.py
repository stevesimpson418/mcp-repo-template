"""MCP Server — entry point."""

from dotenv import load_dotenv
from fastmcp import FastMCP

from mcp_server_template.tools import register_tools

load_dotenv()

mcp = FastMCP("mcp-server-template")
register_tools(mcp)


def main() -> None:
    mcp.run()


if __name__ == "__main__":
    main()
