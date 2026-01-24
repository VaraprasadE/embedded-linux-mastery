#!/bin/bash
#
# Script: system_info.sh
# Description: Display comprehensive system information
# Author: Varaprasad
# Date: 2026-01-24
#

set -e
set -u
set -o pipefail

# Colors
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

header() {
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

# System
header "SYSTEM INFORMATION"
echo "Hostname:    $(hostname)"
echo "Date:        $(date '+%Y-%m-%d %H:%M:%S')"
echo "Uptime:      $(uptime -p 2>/dev/null || uptime)"
echo "Kernel:      $(uname -r)"
echo "Arch:        $(uname -m)"

# CPU
header "CPU INFORMATION"
if [ -f /proc/cpuinfo ]; then
    model=$(grep -m1 "model name" /proc/cpuinfo | cut -d: -f2 | xargs)
    cores=$(grep -c "^processor" /proc/cpuinfo)
    echo "Model:       ${model:-Unknown}"
    echo "Cores:       $cores"
fi

# Memory
header "MEMORY INFORMATION"
if [ -f /proc/meminfo ]; then
    total=$(awk '/MemTotal/ {printf "%.0f", $2/1024}' /proc/meminfo)
    free=$(awk '/MemAvailable/ {printf "%.0f", $2/1024}' /proc/meminfo)
    used=$((total - free))
    percent=$((used * 100 / total))
    echo "Total:       ${total} MB"
    echo "Used:        ${used} MB (${percent}%)"
    echo "Available:   ${free} MB"
fi

# Disk
header "DISK INFORMATION"
df -h / | tail -1 | awk '{printf "Root (/):    %s used of %s (%s)\n", $3, $2, $5}'

# Network
header "NETWORK INTERFACES"
if command -v ip &>/dev/null; then
    ip -br addr show | grep -v "^lo" | while read -r line; do
        echo "  $line"
    done
else
    ifconfig | grep -E "^[a-z]|inet " | head -10
fi

echo ""
echo -e "${GREEN}System info complete.${NC}"
