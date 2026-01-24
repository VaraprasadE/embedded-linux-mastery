#!/bin/bash
#
# Script: log_parser.sh
# Description: Parse and analyze log files
# Author: Varaprasad
# Date: 2026-01-24
#

set -e
set -u
set -o pipefail

usage() {
    echo "Usage: $0 <logfile> [options]"
    echo "Options:"
    echo "  --errors      Show only errors"
    echo "  --warnings    Show only warnings"
    echo "  --today       Show only today's entries"
    echo "  --summary     Show summary statistics"
    exit 1
}

if [ $# -lt 1 ]; then
    usage
fi

LOGFILE="$1"
shift

if [ ! -f "$LOGFILE" ]; then
    echo "Error: File '$LOGFILE' not found" >&2
    exit 1
fi

FILTER=""
SUMMARY=0

while [ $# -gt 0 ]; do
    case "$1" in
        --errors)   FILTER="ERROR" ;;
        --warnings) FILTER="WARN" ;;
        --today)    FILTER=$(date +%Y-%m-%d) ;;
        --summary)  SUMMARY=1 ;;
        *) echo "Unknown option: $1" >&2; usage ;;
    esac
    shift
done

echo "=== Log Parser ==="
echo "File: $LOGFILE"
echo ""

if [ $SUMMARY -eq 1 ]; then
    echo "--- Statistics ---"
    echo "Total lines:  $(wc -l < "$LOGFILE")"
    echo "ERRORS:       $(grep -c "ERROR" "$LOGFILE" 2>/dev/null || echo 0)"
    echo "WARNINGS:     $(grep -c "WARN" "$LOGFILE" 2>/dev/null || echo 0)"
    echo "INFO:         $(grep -c "INFO" "$LOGFILE" 2>/dev/null || echo 0)"
    echo "DEBUG:        $(grep -c "DEBUG" "$LOGFILE" 2>/dev/null || echo 0)"
elif [ -n "$FILTER" ]; then
    echo "--- Filtered: $FILTER ---"
    grep "$FILTER" "$LOGFILE" | tail -50
else
    echo "--- Last 20 lines ---"
    tail -20 "$LOGFILE"
fi

echo ""
echo "Parsing complete."
