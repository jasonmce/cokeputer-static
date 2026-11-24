#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

IMAGE="docker.io/library/cokeputer-static:latest"
TAR="${COKEPUTER_ARM64_TAR:-/tmp/cokeputer-static-arm64.tar}"

docker buildx build --pull --platform linux/arm64 \
  --provenance=false \
  -t "$IMAGE" \
  --output "type=docker,dest=${TAR}" \
  .

printf 'Built %s\nArchive: %s\n' "$IMAGE" "$TAR"
