#!/usr/bin/env bash
set -euo pipefail

# build-install.sh — Build and install oracle CLI
# Requires: Node 22+, pnpm

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

BIN_DIR="$HOME/prj/util/bin"
mkdir -p "$BIN_DIR"

echo "=== Installing dependencies ==="
pnpm install --frozen-lockfile

echo ""
echo "=== Building ==="
pnpm run build

echo ""
echo "=== Installing binaries ==="
# Link oracle binary
ln -sf "$SCRIPT_DIR/dist/bin/oracle-cli.js" "$BIN_DIR/oracle"
chmod +x "$BIN_DIR/oracle"

# Link oracle-mcp binary
ln -sf "$SCRIPT_DIR/dist/bin/oracle-mcp.js" "$BIN_DIR/oracle-mcp"
chmod +x "$BIN_DIR/oracle-mcp"

echo ""
echo "=== Verifying ==="
"$BIN_DIR/oracle" --version

echo ""
echo "=== Done ==="
echo "Binaries: $BIN_DIR/oracle, $BIN_DIR/oracle-mcp"
echo ""
echo "=== SETUP STEPS ==="
echo "1. For API mode, set environment variables in ~/.zshrc:"
echo "   export OPENAI_API_KEY=\"your-key\"       # GPT-5.x models"
echo "   export GEMINI_API_KEY=\"your-key\"        # Gemini models"
echo "   export ANTHROPIC_API_KEY=\"your-key\"     # Claude models"
echo "2. For browser mode, no API key needed — just be logged into ChatGPT/Gemini in Chrome."
echo "3. Optional config: ~/.oracle/config.json (JSON5 format)"
echo "4. MCP server: oracle-mcp (stdio mode)"
