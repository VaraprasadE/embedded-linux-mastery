#!/bin/bash
#
# Script: proc_monitor.sh
# Description: Monitor process resource usage
# Author: Varaprasad
# Date: 2026-01-24
#

set -e
set -u
set -o pipefail

usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -p PID     Monitor specific process"
    echo "  -n NAME    Monitor process by name"
    echo "  -t SEC     Update interval (default: 2)"
    echo "  -c COUNT   Number of iterations (default: infinite)"
    exit 1
}

PID=""
NAME=""
INTERVAL=2
COUNT=0

while getopts "p:n:t:c:h" opt; do
    case $opt in
        p) PID="$OPTARG" ;;
        n) NAME="$OPTARG" ;;
        t) INTERVAL="$OPTARG" ;;
        c) COUNT="$OPTARG" ;;
        h) usage ;;
        ?) usage ;;
    esac
done

if [ -n "$NAME" ] && [ -z "$PID" ]; then
    PID=$(pgrep -x "$NAME" 2>/dev/null | head -1)
    if [ -z "$PID" ]; then
        echo "Error: Process '$NAME' not found" >&2
        exit 1
    fi
fi

iteration=0
while true; do
    clear
    echo "=== Process Monitor ==="
    echo "Time: $(date '+%H:%M:%S')"
    echo ""

    if [ -n "$PID" ]; then
        if [ -d "/proc/$PID" ]; then
            echo "Monitoring PID: $PID"
            echo ""
            ps -p "$PID" -o pid,ppid,%cpu,%mem,stat,etime,cmd --no-headers
            echo ""
            echo "Memory (KB):"
            grep -E "VmSize|VmRSS|VmPeak" /proc/$PID/status 2>/dev/null || echo "N/A"
        else
            echo "Process $PID no longer exists"
            break
        fi
    else
        echo "Top 10 CPU consumers:"
        ps aux --sort=-%cpu | head -11
    fi

    ((iteration++)) || true
    if [ "$COUNT" -gt 0 ] && [ "$iteration" -ge "$COUNT" ]; then
        break
    fi

    sleep "$INTERVAL"
done
