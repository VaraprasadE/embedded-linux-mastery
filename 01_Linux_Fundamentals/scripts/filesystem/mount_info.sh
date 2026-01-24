#!/bin/bash
#
# Script: mount_info.sh
# Description: Display mount point information
# Author: Varaprasad
# Date: 2026-01-24
#

set -e
set -u
set -o pipefail

echo "=== Mount Point Information ==="
echo ""

echo "--- Mounted Filesystems ---"
echo "TYPE       SIZE   USED  AVAIL USE%  MOUNT"
df -hT 2>/dev/null | tail -n +2 | awk '{printf "%-10s %5s  %5s  %5s %4s  %s\n", $2, $3, $4, $5, $6, $7}'

echo ""
echo "--- Virtual Filesystems ---"
mount | grep -E "^proc|^sysfs|^devtmpfs|^tmpfs|^cgroup" | head -10

echo ""
echo "--- Block Device Mounts ---"
mount | grep "^/dev" | head -10

echo ""
echo "Mount information complete."
