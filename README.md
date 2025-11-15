# IR-Kit — Incident Response Forensic Kit


University: UITS (Bangladesh)


A Bash-based automated forensic evidence collection toolkit designed for university coursework and introductory DFIR exercises.


## Features
- Running processes, network connections, ip info
- User command histories and shell configs
- Recently modified files search
- Cron jobs and scheduled tasks
- SUID & suspicious binaries, /tmp executables
- Additional modules: users, mounts, system logs
- Logging, evidence hashing, colorized console output


## Contributors
- Azhar — Project lead; main orchestrator, packaging, and testing.
- **Sadia Akter Liza** — Documentation; scripting for networking & extra modules; research & design; README and UI/UX improvements.


### Sadia's contributions (detail)
- Authored `network.sh` and `mounts.sh` modules (collection + parsing).
- Led research on evidence collection best-practices and lookback strategies.
- Wrote and polished README, `docs/report-template.md` and in-repo guidance for report submission.
- Improved user-facing output (colorized, clearer prompts) and reviewed scripts for clarity and comments.


## Quick start
1. Clone repo
2. `chmod +x irkit.sh utils.sh modules/*.sh`
3. `./irkit.sh`


Outputs are saved to `outputs/IRKIT_YYYYMMDD_HHMMSS/` and a compressed archive is produced.


License: MIT
