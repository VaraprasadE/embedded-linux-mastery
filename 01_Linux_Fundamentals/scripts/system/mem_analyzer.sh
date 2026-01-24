#!/bin/bash
#
# Script: mem_analyzer.sh
# Description: Analyze memory usage
# Author: Varaprasad
# Date: 2026-01-24
#

set -e
set -u
set -o pipefail

echo "=== Memory Analysis ==="
echo "Date: $(date '+%Y-%m-%d %H:%M:%S')"
echo ""

# Parse /proc/meminfo
echo "--- Memory Overview ---"
awk '
/MemTotal/     { total=$2 }
/MemFree/      { free=$2 }
/MemAvailable/ { available=$2 }
/Buffers/      { buffers=$2 }
/^Cached/      { cached=$2 }
/SwapTotal/    { swap_total=$2 }
/SwapFree/     { swap_free=$2 }
END {
    used = total - available
    printf "Total:         %8.1f MB\n", total/1024
    printf "Used:          %8.1f MB (%d%%)\n", used/1024, (used*100/total)
    printf "Available:     %8.1f MB\n", available/1024
    printf "Free:          %8.1f MB\n", free/1024
    printf "Buffers:       %8.1f MB\n", buffers/1024
    printf "Cached:        %8.1f MB\n", cached/1024
    if (swap_total > 0) {
        swap_used = swap_total - swap_free
        printf "\nSwap Total:    %8.1f MB\n", swap_total/1024
        printf "Swap Used:     %8.1f MB (%d%%)\n", swap_used/1024, (swap_used*100/swap_total)
    }
}' /proc/meminfo

echo ""
echo "--- Top Memory Consumers ---"
ps aux --sort=-%mem | awk '
NR==1 { printf "%-8s %-6s %-6s %s\n", "USER", "%MEM", "RSS(MB)", "COMMAND" }
NR>1 && NR<=11 { printf "%-8s %-6s %-6.1f %s\n", $1, $4, $6/1024, $11 }
'

echo ""
echo "--- Memory by Process (Aggregated) ---"
ps aux | awk 'NR>1 {mem[$11]+=$6} END {for(p in mem) printf "%8.1f MB  %s\n", mem[p]/1024, p}' | sort -rn | head -10

echo ""
echo "Analysis complete."
