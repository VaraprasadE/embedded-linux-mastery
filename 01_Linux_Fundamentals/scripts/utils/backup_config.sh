#!/bin/bash
#
# Script: backup_config.sh
# Description: Backup system configuration files
# Author: Varaprasad
# Date: 2026-01-24
#

set -e
set -u
set -o pipefail

BACKUP_DIR="${1:-/tmp/config_backup}"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="${BACKUP_DIR}/config_backup_${TIMESTAMP}.tar.gz"

echo "=== Configuration Backup ==="
echo "Destination: $BACKUP_FILE"
echo ""

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Create temporary list of files to backup
TMPFILE=$(mktemp)
trap 'rm -f $TMPFILE' EXIT

# List of config files/dirs to backup
cat > "$TMPFILE" << 'EOF'
/etc/passwd
/etc/group
/etc/hosts
/etc/hostname
/etc/fstab
/etc/network/
/etc/systemd/network/
/etc/resolv.conf
/etc/ssh/
EOF

echo "Backing up configuration files..."

# Only backup files that exist
real_files=""
while IFS= read -r file; do
    if [ -e "$file" ]; then
        real_files="$real_files $file"
    fi
done < "$TMPFILE"

if [ -n "$real_files" ]; then
    # shellcheck disable=SC2086
    tar -czf "$BACKUP_FILE" $real_files 2>/dev/null || true
    
    BACKUP_SIZE=$(du -h "$BACKUP_FILE" | cut -f1)
    echo ""
    echo "Backup complete!"
    echo "  File: $BACKUP_FILE"
    echo "  Size: $BACKUP_SIZE"
    
    echo ""
    echo "Contents:"
    tar -tzf "$BACKUP_FILE" | head -20
else
    echo "No configuration files found to backup."
fi
