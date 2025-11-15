#!/usr/bin/env bash
OUT_DIR="$1"


ss -tulpn > "$OUT_DIR/network_connections.txt" 2>/dev/null || netstat -tulpn > "$OUT_DIR/network_connections.txt" 2>/dev/null
ip -br a > "$OUT_DIR/ip_brief.txt" 2>/dev/null || ip a > "$OUT_DIR/ip_info.txt"
if command -v iptables >/dev/null 2>&1; then
iptables -L -n -v > "$OUT_DIR/firewall_rules.txt" 2>/dev/null || true
fi
log INFO "Saved network information"
