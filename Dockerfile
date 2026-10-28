FROM python:3.12-slim

LABEL org.opencontainers.image.title="TP-Link Router MCP Server"
LABEL org.opencontainers.image.description="Agent-Safe Model Context Protocol (MCP) Server for TP-Link Routers"
LABEL org.opencontainers.image.authors="Dulith Divisekara <dulithdivisekara@gmail.com>"
LABEL org.opencontainers.image.source="https://github.com/dulithdivisekara/tplink-mcp"
LABEL org.opencontainers.image.licenses="MIT"

WORKDIR /app

COPY pyproject.toml .
COPY tplink_mcp ./tplink_mcp

RUN pip install --no-cache-dir requests cryptography pycryptodome tplinkrouterc6u mcp

ENV PYTHONPATH=/app
ENV PYTHONUNBUFFERED=1

ENTRYPOINT ["python", "-m", "tplink_mcp.server"]
