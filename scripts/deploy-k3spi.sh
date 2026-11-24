#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

REMOTE_HOST="${K3SPI_HOST:-k3spi}"
CONTEXT="${K3SPI_CONTEXT:-k3spi}"
IMAGE="docker.io/library/cokeputer-static:latest"
TAR="${COKEPUTER_ARM64_TAR:-/tmp/cokeputer-static-arm64.tar}"

./scripts/build.sh

scp "$TAR" "$REMOTE_HOST:/tmp/cokeputer-static-arm64.tar"
ssh "$REMOTE_HOST" "sudo k3s ctr images import /tmp/cokeputer-static-arm64.tar"

kubectl --context "$CONTEXT" -n cokeputer rollout restart \
  deployment/cokeputer

kubectl --context "$CONTEXT" -n cokeputer rollout status \
  deployment/cokeputer --timeout=120s

./scripts/smoke-test.sh
