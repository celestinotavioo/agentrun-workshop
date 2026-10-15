#!/usr/bin/env bash
# "Where am I?" — a checklist of everything the workshop needs, with the one action to take next.
cd "$(dirname "$0")/.."
NAME="${KIND_CLUSTER:-agentrun}"
CTX="${KUBE_CONTEXT:-kind-$NAME}"
if [[ -t 1 ]]; then G=$'\033[38;5;35m' Y=$'\033[38;5;214m' R=$'\033[38;5;203m' D=$'\033[2m' B=$'\033[1m' X=$'\033[0m'; else G= Y= R= D= B= X=; fi

missing=0; waiting=0; next=""
ok()   { printf "  ${G}[ok]${X}     %s\n" "$1"; }
wait_() { printf "  ${Y}[wait]${X}   %s\n" "$1"; waiting=1; }
todo() { printf "  ${R}[to do]${X}  %s\n" "$1"; missing=1; [[ -z "$next" ]] && next="$2"; }

printf "\n  ${B}AgentRun workshop · setup check${X}\n\n"

if command -v go >/dev/null; then ok "Go $(go env GOVERSION | sed 's/^go//')"; else todo "Go is not installed" "open this repo in GitHub Codespaces (button in the README)"; fi
if docker info >/dev/null 2>&1; then ok "Docker engine"; else todo "Docker engine is not running" "wait 30 s and run make check again"; fi
if command -v kind >/dev/null && command -v kubectl >/dev/null; then ok "kind $(kind version -q 2>/dev/null) · kubectl"; else todo "kind/kubectl missing" "run: bash hack/setup.sh"; fi

if kubectl --context "$CTX" get --raw /readyz >/dev/null 2>&1; then
  ok "Kubernetes cluster '$NAME' is ready ($CTX)"
elif pgrep -f "kind create cluster|cluster-up.sh" >/dev/null; then
  wait_ "Kubernetes cluster '$NAME' is starting in the background (~2 min) — only needed in block 5"
elif docker info >/dev/null 2>&1 && command -v kind >/dev/null; then
  setsid -f bash hack/cluster-up.sh > /tmp/agentrun-cluster.log 2>&1 < /dev/null
  wait_ "Kubernetes cluster '$NAME' — started it for you in the background (~2 min) — only needed in block 5"
else
  todo "Kubernetes cluster '$NAME' is not running" "run: make cluster"
fi

echo
if [[ $missing -eq 0 && $waiting -eq 0 ]]; then
  printf "  ${G}${B}✔ all set${X}\n\n"
elif [[ $missing -eq 0 ]]; then
  printf "  ${G}${B}✔ ready for blocks 1-4${X} ${D}(the cluster finishes starting in the background)${X}\n\n"
else
  printf "  ${R}${B}next:${X} %s\n\n" "$next"; exit 1
fi
