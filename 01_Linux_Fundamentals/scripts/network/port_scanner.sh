#!/bin/bash
#
# Script: port_scanner.sh
# Description: Simple port scanner for embedded development
# Author: Varaprasad
# Date: 2026-01-24
#

set -e
set -u
set -o pipefail

usage() {
    echo "Usage: $0 <host> [start_port] [end_port]"
    echo "Example: $0 192.168.1.100 1 1024"
    exit 1
}

if [ $# -lt 1 ]; then
    usage
fi

HOST="$1"
START_PORT="${2:-1}"
END_PORT="${3:-1024}"

echo "=== Port Scanner ==="
echo "Host: $HOST"
echo "Range: $START_PORT - $END_PORT"
echo ""
echo "Scanning... (this may take a while)"
echo ""

open_ports=0
for port in $(seq "$START_PORT" "$END_PORT"); do
    # Use timeout with /dev/tcp (bash built-in) or nc
    if command -v nc &>/dev/null; then
        if nc -z -w1 "$HOST" "$port" 2>/dev/null; then
            echo "  Port $port: OPEN"
            ((open_ports++)) || true
        fi
    else
        if (echo >/dev/tcp/"$HOST"/"$port") 2>/dev/null; then
            echo "  Port $port: OPEN"
            ((open_ports++)) || true
        fi
    fi
done

echo ""
echo "Scan complete. Open ports found: $open_ports"
