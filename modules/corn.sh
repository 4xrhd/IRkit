#!/usr/bin/env bash
OUT_DIR="$1"
crontab -l > "$OUT_DIR/user_cron.txt" 2>/dev/null || true
ls -la /etc/cron* > "$OUT_DIR/system_cron_listing.txt" 2>/dev/null || true
log INFO "Collected cron jobs"
