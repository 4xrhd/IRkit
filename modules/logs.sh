#!/usr/bin/env bash
OUT_DIR="$1"
# collect last portions of important logs (non-destructive):
if [[ -f /var/log/syslog ]]; then
tail -n 500 /var/log/syslog > "$OUT_DIR/syslog_tail.txt" 2>/dev/null || true
fi
if [[ -f /var/log/messages ]]; then
tail -n 500 /var/log/messages > "$OUT_DIR/messages_tail.txt" 2>/dev/null || true
fi
# auth logs
if [[ -f /var/log/auth.log ]]; then
tail -n 500 /var/log/auth.log > "$OUT_DIR/auth_tail.txt" 2>/dev/null || true
fi
log INFO "Collected system logs (tail excerpts)"
