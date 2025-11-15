#!/usr/bin/env bash
OUT_DIR="$1"
getent passwd > "$OUT_DIR/passwd_entries.txt"
getent group > "$OUT_DIR/group_entries.txt"
last -n 50 > "$OUT_DIR/last_logins.txt" 2>/dev/null || true
log INFO "Saved user account information"
