#!/usr/bin/env bash
# Creates the workshop's kind cluster if it is not there or not healthy. Safe to run any number of times.
set -euo pipefail
NAME="${KIND_CLUSTER:-agentrun}"
CTX="kind-$NAME"

echo "$(date +%T) waiting for docker"
for _ in $(seq 1 90); do docker info >/dev/null 2>&1 && break; sleep 2; done
docker info >/dev/null 2>&1 || { echo "docker never came up"; exit 1; }

if kind get clusters 2>/dev/null | grep -qx "$NAME"; then
  if kubectl --context "$CTX" get --raw /readyz >/dev/null 2>&1; then
    echo "$(date +%T) cluster $NAME already healthy"; exit 0
  fi
  echo "$(date +%T) cluster $NAME exists but is unhealthy (codespace restart?) — recreating"
  kind delete cluster --name "$NAME"
fi

echo "$(date +%T) creating cluster $NAME"
kind create cluster --name "$NAME" --wait 180s
echo "$(date +%T) cluster $NAME ready"
