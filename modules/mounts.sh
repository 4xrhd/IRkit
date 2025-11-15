#!/usr/bin/env bash
OUT_DIR="$1"
mount -l > "$OUT_DIR/mounts.txt" 2>/dev/null
lsblk -f > "$OUT_DIR/lsblk.txt" 2>/dev/null || true
log INFO "Saved mount and block device info"
