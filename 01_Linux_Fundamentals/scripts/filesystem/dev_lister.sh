#!/bin/bash
#
# Script: dev_lister.sh
# Description: List and categorize /dev devices
# Author: Varaprasad
# Date: 2026-01-24
#

set -e
set -u
set -o pipefail

echo "=== Device Node Lister ==="
echo "Date: $(date '+%Y-%m-%d %H:%M:%S')"
echo ""

echo "--- Summary ---"
total=$(ls -1 /dev 2>/dev/null | wc -l)
block=$(ls -la /dev 2>/dev/null | grep -c "^b" || echo 0)
char=$(ls -la /dev 2>/dev/null | grep -c "^c" || echo 0)
echo "Total devices: $total"
echo "Block devices: $block"
echo "Char devices:  $char"

echo ""
echo "--- Block Devices (Storage) ---"
ls -la /dev/sd* /dev/hd* /dev/mmcblk* /dev/nvme* 2>/dev/null | head -10 || echo "None found"

echo ""
echo "--- Serial Devices ---"
ls -la /dev/ttyUSB* /dev/ttyACM* /dev/ttyS* 2>/dev/null | head -10 || echo "None found"

echo ""
echo "--- I2C Devices ---"
ls -la /dev/i2c-* 2>/dev/null || echo "None found"

echo ""
echo "--- SPI Devices ---"
ls -la /dev/spidev* 2>/dev/null || echo "None found"

echo ""
echo "--- GPIO ---"
ls -la /dev/gpiochip* 2>/dev/null || echo "None found"

echo ""
echo "--- Input Devices ---"
ls -la /dev/input/ 2>/dev/null | head -10 || echo "None found"

echo ""
echo "Device listing complete."
