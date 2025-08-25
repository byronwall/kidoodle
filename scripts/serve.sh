#!/usr/bin/env bash
set -euo pipefail

# Quick local static server for testing the app
# - Prefers node toolchain via npx (no package.json needed)
# - Uses http-server with caching disabled
#
# Usage:
#   PORT=8080 HOST=127.0.0.1 scripts/serve.sh
#   scripts/serve.sh            # defaults: HOST=127.0.0.1, PORT=8080
#   scripts/serve.sh --open     # open browser automatically

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

PORT="${PORT:-8080}"
HOST="${HOST:-127.0.0.1}"
OPEN_FLAG=""

if [[ "${1:-}" == "--open" ]]; then
  OPEN_FLAG="-o"
fi

echo "Serving ${ROOT_DIR} at http://${HOST}:${PORT} (no-cache)"
cd "${ROOT_DIR}"

# http-server flags:
#  -p: port
#  -a: address/host
#  -c-1: disable caching (good for SW/dev)
#  -o: open default browser (optional)
exec npx --yes http-server -p "${PORT}" -a "${HOST}" -c-1 ${OPEN_FLAG} .


