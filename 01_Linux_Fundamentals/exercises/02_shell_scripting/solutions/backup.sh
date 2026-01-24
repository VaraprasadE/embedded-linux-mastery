#!/bin/bash
#
# Solution: Backup Script
# Author: Varaprasad
#

set -e
set -u
set -o pipefail

usage() {
    echo "Usage: $0 <source_dir> <dest_dir>"
    echo "Creates a timestamped backup of source_dir in dest_dir"
    exit 1
}

# Validate arguments
if [ $# -ne 2 ]; then
    usage
fi

SOURCE="$1"
DEST="$2"

# Validate source
if [ ! -d "$SOURCE" ]; then
    echo "Error: Source directory '$SOURCE' does not exist" >&2
    exit 1
fi

# Create destination if needed
if [ ! -d "$DEST" ]; then
    echo "Creating destination directory: $DEST"
    mkdir -p "$DEST"
fi

# Generate backup filename
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BASENAME=$(basename "$SOURCE")
BACKUP_FILE="${DEST}/${BASENAME}_backup_${TIMESTAMP}.tar.gz"

# Create backup
echo "Creating backup..."
echo "  Source: $SOURCE"
echo "  Destination: $BACKUP_FILE"

tar -czf "$BACKUP_FILE" -C "$(dirname "$SOURCE")" "$(basename "$SOURCE")"

# Show result
BACKUP_SIZE=$(du -h "$BACKUP_FILE" | cut -f1)
echo ""
echo "Backup complete!"
echo "  File: $BACKUP_FILE"
echo "  Size: $BACKUP_SIZE"
