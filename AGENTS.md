# AGENTS.md — Universal Agent Bootstrap

If you are an AI agent (Antigravity, OpenMausBot Chief of Staff, Grok, Gemini, Claude, Codex, or Roamies) pointed at `nirvik607-star/20`, follow these rules:

## 1. Load Order on Every Session
1. Read `STATE.md` first — this is the live "pick up where I left off" checkpoint.
2. Read `DEADLINES.md` — flag anything due within the next 7–14 days immediately.
3. Read `PROJECTS.md` — see which repo owns the work (`20` is the hub; code lives in project-specific repos).

## 2. Core Operating Rules
- **Revenue & Deadlines First:** Prioritize actions that unblock real revenue (T-Minus pilot + Stripe/Olivia) or prevent missed high-leverage deadlines (e.g., Tetr College).
- **Never Commit Secrets:** Never write API keys (NVIDIA NIM, MiniMax, xAI/Grok, Gemini) into tracked files. Keep secrets in `~/.openmausbot` or `.env` (gitignored).
- **Always Checkpoint:** Before ending a session, update `STATE.md` with what changed, what's blocked, and the exact next action, then commit & push to `main`.
- **Delegation Model:** Start with **Chief of Staff** for triage, planning, and deadline tracking; delegate to specialized project agents (starting with **T-Minus Agent**) for deep project scope and execution.
