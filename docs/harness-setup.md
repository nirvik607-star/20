# Harness Setup — Phone + Windows + Inference Providers

## 1. Phone Access (Anywhere)
- **Antigravity Cloud Workspace:** Open this project's web chat in **Safari (iOS)** or **Chrome (Android)** and use **Add to Home Screen**. Every message runs in the cloud VM with direct access to `nirvik607-star/20` and `t-minus-prototype`.
- **Golden Rule:** Always end a phone session by having the agent update `STATE.md` and `git push`.

## 2. Windows Setup (OpenMausBot — GrokBot Clone)
1. Download the Windows installer from [OpenMausBot Releases](https://github.com/milind-soni/OpenMausBot/releases/latest) (`OpenMausBot-setup.exe`).
   - If Windows SmartScreen warns "unknown publisher", click **More info → Run anyway**.
2. Clone your hub repo locally:
   ```powershell
   git clone https://github.com/nirvik607-star/20.git
   git clone https://github.com/nirvik607-star/t-minus-prototype.git
   ```
3. In OpenMausBot, go to **Teams → Import** and select `20/openmausbot/chief-of-staff.md` (or paste its GitHub raw URL).

## 3. Linking Your Inference Providers
OpenMausBot stores all keys locally in `~/.openmausbot` (never in git):
- **Grok (xAI):** Install/sign in to the `grok` CLI for **Settings → Engines**, and add your xAI API key in **Settings → Connections** (also enables Grok voice replies).
- **Gemini:** Add your Google AI Studio / Gemini key or use via an OpenAI-compatible/OpenRouter endpoint in **Settings → Connections**.
- **MiniMax & NVIDIA NIM (7 keys):** OpenMausBot's native agent engines are `claude`, `codex`, and `grok` CLIs, plus **OpenRouter / Cloudflare Workers AI / custom CLI wrappers** in **Settings → Engines**.
  - To use **NVIDIA NIM** (OpenAI-compatible `https://integrate.api.nvidia.com/v1`) or **MiniMax** inside OpenMausBot, configure them via a custom CLI wrapper in **Settings → Engines** (or route through an OpenAI-compatible proxy/OpenRouter).
  - Tip: Rotate across your 7 NVIDIA NIM keys in a local `.env` / wrapper script rather than hardcoding them anywhere in this repo.
