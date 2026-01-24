#!/bin/bash
#
# Script: fs_explorer.sh
# Description: Explore filesystem hierarchy
# Author: Varaprasad
# Date: 2026-01-24
#

set -e
set -u
set -o pipefail

show_dir() {
    local path="$1"
    local desc="$2"
    echo ""
    echo "=== $path - $desc ==="
    if [ -d "$path" ]; then
        ls -la "$path" 2>/dev/null | head -15
        count=$(ls -1 "$path" 2>/dev/null | wc -l)
        echo "... ($count items total)"
    else
        echo "[Directory not found]"
    fi
}

echo "╔══════════════════════════════════════════╗"
echo "║      LINUX FILESYSTEM EXPLORER           ║"
echo "╚══════════════════════════════════════════╝"

show_dir "/" "Root directory"
show_dir "/bin" "Essential user binaries"
show_dir "/etc" "System configuration"
show_dir "/dev" "Device files"
show_dir "/proc" "Process information (virtual)"
show_dir "/sys" "Kernel objects (virtual)"

echo ""
echo "=== Filesystem Types ==="
echo "Mounted filesystems:"
df -hT | head -10

echo ""
echo "=== Special Filesystems ==="
mount | grep -E "proc|sysfs|devtmpfs|tmpfs" | head -5

echo ""
echo "Exploration complete."
