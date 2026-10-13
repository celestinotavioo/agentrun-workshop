#!/usr/bin/env bash
# Runs once when the codespace is created (and in prebuilds): everything slow happens here.
set -euo pipefail
cd "$(dirname "$0")/.."
KIND_VERSION=v0.33.0

echo "▸ Go modules"
go mod download

echo "▸ kind $KIND_VERSION"
command -v kind >/dev/null || go install "sigs.k8s.io/kind@$KIND_VERSION"

echo "▸ workshop binaries"
make --no-print-directory agentctl

echo "✔ setup done — run: make check"
