#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

CONTEXT="${K3SPI_CONTEXT:-k3spi}"
kubectl --context "$CONTEXT" apply -f k3s/cokeputer.yaml
