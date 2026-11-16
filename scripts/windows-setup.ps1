# Windows one-shot setup for 20 + OpenMausBot
param(
    [switch]$CleanReset
)
$ErrorActionPreference = "Stop"

if ($CleanReset) {
    Write-Host "0. Clean reset: stopping OpenMausBot and wiping old state/cache..." -ForegroundColor Yellow
    Get-Process | Where-Object { $_.ProcessName -match "OpenMausBot|mausbot" } | Stop-Process -Force -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 1

    $pathsToWipe = @(
        (Join-Path $env:USERPROFILE ".openmausbot"),
        (Join-Path $env:APPDATA "OpenMausBot"),
        (Join-Path $env:APPDATA "openmausbot"),
        (Join-Path $env:LOCALAPPDATA "OpenMausBot"),
        (Join-Path $env:LOCALAPPDATA "openmausbot"),
        (Join-Path $env:LOCALAPPDATA "Programs\OpenMausBot"),
        (Join-Path $env:LOCALAPPDATA "openmausbot-updater")
    )
    foreach ($p in $pathsToWipe) {
        if (Test-Path $p) {
            Remove-Item -Path $p -Recurse -Force -ErrorAction SilentlyContinue
            Write-Host "   Removed $p" -ForegroundColor DarkYellow
        }
    }
}

Write-Host "1. Creating C:\dev and cloning repositories..." -ForegroundColor Cyan
New-Item -ItemType Directory -Force -Path "C:\dev" | Out-Null
Set-Location "C:\dev"

if (-not (Test-Path "C:\dev\20")) {
    git clone https://github.com/nirvik607-star/20.git
} else {
    Write-Host "   C:\dev\20 already exists, pulling latest..."
    git -C "C:\dev\20" pull
}

if (-not (Test-Path "C:\dev\t-minus-prototype")) {
    git clone https://github.com/nirvik607-star/t-minus-prototype.git
} else {
    Write-Host "   C:\dev\t-minus-prototype already exists, pulling latest..."
    git -C "C:\dev\t-minus-prototype" pull
}

Write-Host "2. Creating OpenMausBot config template at $env:USERPROFILE\.openmausbot\config.json..." -ForegroundColor Cyan
$ombDir = Join-Path $env:USERPROFILE ".openmausbot"
$ombConfig = Join-Path $ombDir "config.json"
New-Item -ItemType Directory -Force -Path $ombDir | Out-Null

if (-not (Test-Path $ombConfig)) {
    @'
{
  "instances": {
    "nvidia-nim-1": {
      "driver": "openai-compat",
      "displayName": "NVIDIA NIM",
      "environment": { "NVIDIA_NIM_KEY_1": "REPLACE_WITH_NIM_KEY" },
      "config": {
        "url": "https://integrate.api.nvidia.com/v1",
        "apiKeyEnv": "NVIDIA_NIM_KEY_1",
        "model": "meta/llama-3.1-70b-instruct"
      }
    },
    "minimax": {
      "driver": "openai-compat",
      "displayName": "MiniMax",
      "environment": { "MINIMAX_API_KEY": "REPLACE_WITH_MINIMAX_KEY" },
      "config": {
        "url": "https://api.minimax.io/v1",
        "apiKeyEnv": "MINIMAX_API_KEY",
        "model": "MiniMax-M1"
      }
    },
    "gemini": {
      "driver": "openai-compat",
      "displayName": "Gemini",
      "environment": { "GEMINI_API_KEY": "REPLACE_WITH_GEMINI_KEY" },
      "config": {
        "url": "https://generativelanguage.googleapis.com/v1beta/openai/",
        "apiKeyEnv": "GEMINI_API_KEY",
        "model": "gemini-2.5-flash"
      }
    }
  }
}
'@ | Set-Content -Path $ombConfig -Encoding UTF8
    Write-Host "   Created $ombConfig (add your keys there)." -ForegroundColor Green
} else {
    Write-Host "   $ombConfig already exists (skipping overwrite)." -ForegroundColor Yellow
}

Write-Host "3. Downloading and launching OpenMausBot-setup.exe..." -ForegroundColor Cyan
$installerPath = Join-Path $env:TEMP "OpenMausBot-setup.exe"
Invoke-WebRequest -Uri "https://github.com/milind-soni/OpenMausBot/releases/latest/download/OpenMausBot-setup.exe" -OutFile $installerPath
Start-Process -FilePath $installerPath

Write-Host "`nDone! Next inside OpenMausBot:" -ForegroundColor Green
Write-Host "  1. Teams -> Import -> C:\dev\20\openmausbot\chief-of-staff.md"
Write-Host "  2. Settings -> Connections -> add your Grok (xAI) key"
Write-Host "  3. Edit $ombConfig with your NIM / MiniMax / Gemini keys, then restart OpenMausBot"
