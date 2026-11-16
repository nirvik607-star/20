# Harness Setup — Phone + Windows + Inference Providers

## 1. Windows Install (OpenMausBot)
1. Download `OpenMausBot-setup.exe` from [OpenMausBot Releases](https://github.com/milind-soni/OpenMausBot/releases/latest).
   - If Windows SmartScreen warns "unknown publisher", click **More info → Run anyway**.
2. Clone your hub and project repos locally (e.g. in PowerShell):
   ```powershell
   mkdir C:\dev; cd C:\dev
   git clone https://github.com/nirvik607-star/20.git
   git clone https://github.com/nirvik607-star/t-minus-prototype.git
   ```
3. Open **OpenMausBot → Teams → Import** and select `C:\dev\20\openmausbot\chief-of-staff.md` (or paste its GitHub URL).
4. Point the **Chief of Staff** channel's working folder to `C:\dev\20`.

---

## 2. Link Your Inference Providers (`~/.openmausbot/config.json`)
On Windows, OpenMausBot's config lives at `%USERPROFILE%\.openmausbot\config.json` (never commit keys to git). Restart OpenMausBot after editing `config.json`.

### A. Grok (xAI)
- In OpenMausBot **Settings → Connections**, paste your **xAI API key** (also enables Grok voice replies), or sign in to the `grok` CLI for **Settings → Engines**.

### B. NVIDIA NIM (7 keys), MiniMax, and Gemini (`openai-compat`)
OpenMausBot supports any OpenAI-compatible endpoint via the built-in `openai-compat` driver in `%USERPROFILE%\.openmausbot\config.json`:

```json
{
  "instances": {
    "nvidia-nim-1": {
      "driver": "openai-compat",
      "displayName": "NVIDIA NIM",
      "environment": { "NVIDIA_NIM_KEY_1": "nvapi-YOUR_KEY_HERE" },
      "config": {
        "url": "https://integrate.api.nvidia.com/v1",
        "apiKeyEnv": "NVIDIA_NIM_KEY_1",
        "model": "meta/llama-3.1-70b-instruct"
      }
    },
    "minimax": {
      "driver": "openai-compat",
      "displayName": "MiniMax",
      "environment": { "MINIMAX_API_KEY": "YOUR_MINIMAX_KEY" },
      "config": {
        "url": "https://api.minimax.io/v1",
        "apiKeyEnv": "MINIMAX_API_KEY",
        "model": "MiniMax-M1"
      }
    },
    "gemini": {
      "driver": "openai-compat",
      "displayName": "Gemini",
      "environment": { "GEMINI_API_KEY": "YOUR_GEMINI_KEY" },
      "config": {
        "url": "https://generativelanguage.googleapis.com/v1beta/openai/",
        "apiKeyEnv": "GEMINI_API_KEY",
        "model": "gemini-2.5-flash"
      }
    }
  }
}
```
- You can add your extra NVIDIA NIM keys as `"nvidia-nim-2"`, `"nvidia-nim-3"`, etc., with their own `apiKeyEnv` so keys never collide.
- After restarting OpenMausBot, open your **Chief of Staff** bot's model picker and click **Refresh models**.

---

## 3. Connect From Your Phone (Anywhere)
OpenMausBot supports phone access natively in two ways (your Windows PC must be awake and running OpenMausBot):
1. **MausBot Phone App + E2E Encrypted Relay (Anywhere):**
   - Start the server with `openmausbot serve --relay` and pair your phone.
2. **Phone Web App (Home Screen PWA):**
   - Expose your workspace over **Tailscale HTTPS** (or `http://<your-PC-LAN-IP>:8799` on home Wi-Fi).
   - Open the URL in **Safari (iOS)** → **Share → Add to Home Screen** (or Chrome on Android → **Install app**) and pair.
3. **Cloud Fallback (When your Windows PC is asleep):**
   - Open **this Antigravity cloud project** in your phone's browser—it reads and pushes to the exact same `nirvik607-star/20` repo.
