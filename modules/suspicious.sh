#!/usr/bin/env bash
OUT_DIR="$1"
find / -type f -perm -4000 -print 2>/dev/null > "$OUT_DIR/suid_binaries.txt" || true
find /tmp -maxdepth 2 -type f -executable -print 2>/dev/null > "$OUT_DIR/tmp_executables.txt" || true
log INFO "Searched for suspicious binaries"
