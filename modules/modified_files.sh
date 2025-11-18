#!/usr/bin/env bash
OUT_DIR="$1"
source ./config.conf || true
for p in $MONITOR_PATH; do
find "$p" -type f -mmin -"$LOOKBACK_MINUTES" -print0 2>/dev/null | xargs -0 ls -lah > "$OUT_DIR/modified_files_${p//\//_}.txt" 2>/dev/null || true
done
log INFO "Scanned for recently modified files"
