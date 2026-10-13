# ⎈ AgentRun workshop · Incident Commander

**Build your own AI agent, and let a Kubernetes operator govern it.**

Hands-on workshop that follows the talk *Kubernetes Operators for AI Agents* (DevFest Malta 2026 · [Otavio Celestino](https://huncoding.com/en)).

## Start here: one click

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/celestinotavioo/agentrun-workshop?quickstart=1)

1. Click the button above (you only need a GitHub account).
2. Wait until the editor opens in your browser.
3. In the terminal at the bottom, type:

   ```bash
   make check
   ```

   Every line should say `[ok]`. If one says `[to do]`, follow the instruction it prints.

Nothing gets installed on your laptop. Go, Docker, Kubernetes (kind) and the project are already inside the codespace. If you prefer clicks over typing: **Terminal → Run Task… → ✅ Check my setup**.

> 🚧 The workshop guide and the agent you will build are being written. Today this repo contains the base: the operator from the talk, running on a cluster inside your codespace (`make demo`).

## License

MIT
