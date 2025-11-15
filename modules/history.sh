#!/usr/bin/env bash
OUT_DIR="$1"
for user_home in /home/*; do
user=$(basename "$user_home")
if [[ -f "$user_home/.bash_history" ]]; then
cp "$user_home/.bash_history" "$OUT_DIR/history_${user}.txt"
fi
done
# root history
if [[ -f /root/.bash_history ]]; then
cp /root/.bash_history "$OUT_DIR/history_root.txt"
fi
log INFO "Collected shell histories"
