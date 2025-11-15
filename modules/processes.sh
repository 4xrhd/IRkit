#!/usr/bin/env bash
OUT_DIR="$1"
ps aux --sort=-%mem > "$OUT_DIR/running_processes.txt"
log INFO "Saved running processes"
