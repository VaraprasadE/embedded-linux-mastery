#!/bin/bash
#
# Solution: Log Analyzer
# Author: Varaprasad
#

set -e
set -u
set -o pipefail

usage() {
    echo "Usage: $0 <logfile> [--errors-only]"
    exit 1
}

if [ $# -lt 1 ]; then
    usage
fi

LOGFILE="$1"
ERRORS_ONLY=0

if [ "${2:-}" = "--errors-only" ]; then
    ERRORS_ONLY=1
fi

if [ ! -f "$LOGFILE" ]; then
    echo "Error: Log file '$LOGFILE' not found" >&2
    exit 1
fi

echo "=== Log Analysis: $(basename "$LOGFILE") ==="
echo ""

# Count by level
ERROR_COUNT=$(grep -c "ERROR" "$LOGFILE" 2>/dev/null || echo 0)
WARN_COUNT=$(grep -c "WARN" "$LOGFILE" 2>/dev/null || echo 0)
INFO_COUNT=$(grep -c "INFO" "$LOGFILE" 2>/dev/null || echo 0)
DEBUG_COUNT=$(grep -c "DEBUG" "$LOGFILE" 2>/dev/null || echo 0)
TOTAL_LINES=$(wc -l < "$LOGFILE")

echo "Statistics:"
echo "  Total lines: $TOTAL_LINES"
echo "  ERROR:       $ERROR_COUNT"
echo "  WARNING:     $WARN_COUNT"
echo "  INFO:        $INFO_COUNT"
echo "  DEBUG:       $DEBUG_COUNT"
echo ""

if [ $ERRORS_ONLY -eq 1 ] && [ "$ERROR_COUNT" -gt 0 ]; then
    echo "=== Error Messages ==="
    grep "ERROR" "$LOGFILE"
fi

echo ""
echo "Analysis complete."
