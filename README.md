# ⎈ AgentRun workshop · Incident Commander

**Build your own AI agent, and let a Kubernetes operator govern it.**

Hands-on workshop that follows the talk *Kubernetes Operators for AI Agents* (DevFest Malta 2026 · [Otavio Celestino](https://huncoding.com/en)).

## Start here: one click

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/celestinotavioo/agentrun-workshop?quickstart=1)

1. Click the button above (you only need a GitHub account).
2. On the page that opens, click the green **Create new codespace** button.
   Already did it before? You will see **Resume** instead: click it, so you keep your work.
3. Wait until the editor opens in your browser (1–5 minutes the first time).
4. Click into the terminal at the bottom. If VS Code asks **"Do you trust the authors of the files in this folder?"**, click **Trust Folder & Continue**.
5. In the terminal, type:

   ```bash
   make check
   ```

   Every line should say `[ok]`. If one says `[to do]`, follow the instruction it prints.

Nothing gets installed on your laptop. Go, Docker, Kubernetes (kind) and the project are already inside the codespace. Prefer clicks over typing? Press **Ctrl+Shift+B** (Mac: **Cmd+Shift+B**): it runs the setup check.

> 🚧 The workshop guide and the agent you will build are being written. Today this repo contains the base: the operator from the talk, running on a cluster inside your codespace (`make demo`).

## License

MIT
