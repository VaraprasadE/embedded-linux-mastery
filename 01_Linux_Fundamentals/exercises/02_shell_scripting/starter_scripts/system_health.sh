#!/bin/bash
#
# Starter template for system health check script
# Complete the TODO sections
#

# TODO: Add set -e and other safety options

# Colors (optional enhancement)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo "=== System Health Check ==="
echo ""

# TODO: Display current date/time
echo "Date: "

# TODO: Display hostname
echo "Hostname: "

# TODO: Display kernel version
echo "Kernel: "

# TODO: Display uptime
echo "Uptime: "

echo ""
echo "=== Memory ==="
# TODO: Show memory usage
# Hint: Use 'free -h' or parse /proc/meminfo

echo ""
echo "=== Disk ==="
# TODO: Show disk usage for / partition
# Hint: Use 'df -h /'

echo ""
echo "=== Processes ==="
# TODO: Count running processes
# Hint: Use 'ps aux | wc -l'

echo ""
echo "=== Done ==="
