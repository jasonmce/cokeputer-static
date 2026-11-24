#!/usr/bin/env bash
set -euo pipefail

URL="${COKEPUTER_URL:-https://cokeputer.bso.io}"

curl --fail --show-error --silent --output /dev/null "$URL/healthz"
curl --fail --show-error --head --silent --show-error "$URL/" >/dev/null

printf 'Smoke test passed: %s\n' "$URL"
