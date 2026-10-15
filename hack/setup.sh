#!/usr/bin/env bash
# Runs once when the codespace is created (and in prebuilds): everything slow happens here.
set -euo pipefail
cd "$(dirname "$0")/.."
KIND_VERSION=v0.33.0

echo "▸ Go modules"
go mod download

echo "▸ kind $KIND_VERSION"
command -v kind >/dev/null || go install "sigs.k8s.io/kind@$KIND_VERSION"

echo "▸ workshop binaries (also warms the Go build cache, so later image builds take seconds)"
make --no-print-directory agentctl linux-binaries tools
docker pull -q gcr.io/distroless/static:nonroot >/dev/null 2>&1 || true

echo "✔ setup done — run: make check"
