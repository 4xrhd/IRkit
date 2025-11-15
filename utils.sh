#!/usr/bin/env bash
# Utility functions: logging, color, hashing


log() {
local level="$1"; shift
local msg="$*"
local ts
ts=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
if [[ "$COLOR_OUTPUT" == "true" ]]; then
case "$level" in
ERROR) prefix="\e[31m[ERROR]\e[0m";;
WARN) prefix="\e[33m[WARN]\e[0m";;
INFO) prefix="\e[32m[INFO]\e[0m";;
DEBUG) prefix="\e[34m[DEBUG]\e[0m";;
*) prefix="[LOG]";;
esac
printf "%s %b %s\n" "$ts" "$prefix" "$msg"
else
printf "%s [%s] %s\n" "$ts" "$level" "$msg"
fi
}


ensure_dir() {
local d="$1"
mkdir -p "$d"
}


hash_file() {
local file="$1"
if command -v sha256sum >/dev/null 2>&1; then
sha256sum "$file" | awk '{print $1}'
else
shasum -a 256 "$file" | awk '{print $1}'
fi
}
