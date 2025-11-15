#!/usr/bin/env bash
set -euo pipefail

# IR-Kit main orchestrator
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/config.conf" || true
source "$SCRIPT_DIR/utils.sh" || true

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
OUT_DIR="$SCRIPT_DIR/outputs/IRKIT_$TIMESTAMP"
archive_name="$SCRIPT_DIR/outputs/IRKIT_${TIMESTAMP}.tar.gz"

ensure_dir "$OUT_DIR"
log INFO "Starting IR-Kit — output: $OUT_DIR"

MODULES=(
processes
network
users
mounts
history
modified_files
cron
logs
suspicious
)

for m in "${MODULES[@]}"; do
    log INFO "Running module: $m"
    if [[ -x "$SCRIPT_DIR/modules/${m}.sh" ]]; then
        source "$SCRIPT_DIR/modules/${m}.sh" "$OUT_DIR" || log WARN "Module $m failed"
    else
        log WARN "Module $m missing or not executable"
    fi
done

# Record checksums of collected files
log INFO "Hashing collected evidence"
find "$OUT_DIR" -type f -not -name '*.sha256' -print0 | while IFS= read -r -d '' f; do
    h=$(hash_file "$f")
    echo "$h $(realpath --relative-to="$OUT_DIR" "$f")" >> "$OUT_DIR/EVIDENCE_SHA256.txt"
done

# Generate HTML Report
log INFO "Generating HTML report"
source "$SCRIPT_DIR/generate_report.sh" "$OUT_DIR" "$TIMESTAMP"

# Archive
log INFO "Compressing evidence to $archive_name"
tar -C "$OUT_DIR/.." -czf "$archive_name" "$(basename "$OUT_DIR")"
log INFO "IR-Kit completed. Archive: $archive_name"
log INFO "HTML Report: $OUT_DIR/report.html"