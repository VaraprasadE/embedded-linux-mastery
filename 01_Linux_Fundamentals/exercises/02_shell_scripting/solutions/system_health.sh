#!/bin/bash
#
# Solution: System Health Check Script
# Author: Varaprasad
#

set -e
set -u
set -o pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() {
    echo -e "${BLUE}=== $1 ===${NC}"
}

print_ok() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warn() {
    echo -e "${YELLOW}!${NC} $1"
}

# Header
echo ""
print_header "System Health Check"
echo ""

# System Info
print_header "System Information"
echo "Date:     $(date '+%Y-%m-%d %H:%M:%S')"
echo "Hostname: $(hostname)"
echo "Kernel:   $(uname -r)"
echo "Uptime:   $(uptime -p)"
echo ""

# Memory
print_header "Memory Status"
mem_total=$(grep MemTotal /proc/meminfo | awk '{print $2}')
mem_free=$(grep MemAvailable /proc/meminfo | awk '{print $2}')
mem_used=$((mem_total - mem_free))
mem_percent=$((mem_used * 100 / mem_total))

echo "Total:     $((mem_total / 1024)) MB"
echo "Used:      $((mem_used / 1024)) MB (${mem_percent}%)"
echo "Available: $((mem_free / 1024)) MB"

if [ $mem_percent -gt 90 ]; then
    print_warn "Memory usage is HIGH!"
else
    print_ok "Memory usage is normal"
fi
echo ""

# Disk
print_header "Disk Status"
disk_info=$(df -h / | tail -1)
disk_used=$(echo "$disk_info" | awk '{print $3}')
disk_avail=$(echo "$disk_info" | awk '{print $4}')
disk_percent=$(echo "$disk_info" | awk '{print $5}' | tr -d '%')

echo "Used:      $disk_used"
echo "Available: $disk_avail"
echo "Usage:     ${disk_percent}%"

if [ "$disk_percent" -gt 90 ]; then
    print_warn "Disk usage is HIGH!"
else
    print_ok "Disk usage is normal"
fi
echo ""

# Processes
print_header "Process Status"
proc_count=$(ps aux | wc -l)
echo "Running processes: $proc_count"
echo ""

# Top 5 CPU consumers
echo "Top 5 CPU consumers:"
ps aux --sort=-%cpu | head -6 | tail -5 | awk '{printf "  %-20s %s%%\n", $11, $3}'
echo ""

print_header "Health Check Complete"
echo ""
