#!/bin/bash
#
# Script: net_config.sh
# Description: Display network configuration
# Author: Varaprasad
# Date: 2026-01-24
#

set -e
set -u
set -o pipefail

echo "=== Network Configuration ==="
echo "Hostname: $(hostname)"
echo ""

echo "--- Interfaces ---"
if command -v ip &>/dev/null; then
    ip -br addr show
else
    ifconfig 2>/dev/null | grep -E "^[a-z]|inet "
fi

echo ""
echo "--- Routing Table ---"
if command -v ip &>/dev/null; then
    ip route show
else
    route -n 2>/dev/null
fi

echo ""
echo "--- DNS Configuration ---"
if [ -f /etc/resolv.conf ]; then
    grep "^nameserver" /etc/resolv.conf
else
    echo "No /etc/resolv.conf found"
fi

echo ""
echo "--- Listening Ports ---"
if command -v ss &>/dev/null; then
    ss -tuln 2>/dev/null | head -15
else
    netstat -tuln 2>/dev/null | head -15
fi

echo ""
echo "--- Interface Statistics ---"
cat /proc/net/dev | tail -n +3 | awk '{printf "%-10s RX: %-12s TX: %-12s\n", $1, $2, $10}'

echo ""
echo "Network configuration complete."
