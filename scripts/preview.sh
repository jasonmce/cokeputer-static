#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

docker rm -f cokeputer-preview >/dev/null 2>&1 || true
docker build --pull -t cokeputer-static:local .

echo "Preview: http://127.0.0.1:8088/"
docker run --rm --name cokeputer-preview \
  -p 127.0.0.1:8088:8080 \
  cokeputer-static:local
