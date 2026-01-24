# Learning Notes: Filesystem Hierarchy

> **Date**: 2026-01-24  
> **Module**: 01_Linux_Fundamentals  
> **Focus**: FHS, Virtual Filesystems for Embedded Linux

---

## 📚 Topic Overview

Understanding the Linux filesystem hierarchy is essential for embedded development, especially when creating custom root filesystems or debugging system issues.

---

## 🎯 Learning Objectives

- [x] Understand the Filesystem Hierarchy Standard (FHS)
- [x] Master virtual filesystems (/proc, /sys, /dev)
- [x] Learn about embedded-specific filesystem considerations

---

## 📝 Notes

### 1. Filesystem Hierarchy Standard (FHS)

```
/
├── bin/       # Essential user binaries (ls, cp, mount)
├── sbin/      # Essential system binaries (init, fdisk)
├── boot/      # Bootloader, kernel, DTBs
├── dev/       # Device files
├── etc/       # System configuration
├── home/      # User home directories
├── lib/       # Essential shared libraries
├── media/     # Removable media mount points
├── mnt/       # Temporary mount points
├── opt/       # Optional application packages
├── proc/      # Virtual: process and kernel info
├── root/      # Root user home
├── run/       # Runtime variable data
├── sys/       # Virtual: kernel objects
├── tmp/       # Temporary files
├── usr/       # Secondary hierarchy
│   ├── bin/   # User binaries
│   ├── lib/   # Libraries
│   └── share/ # Architecture-independent data
└── var/       # Variable data (logs, spool)
```

### 2. Virtual Filesystems

#### /proc - Process and Kernel Information
```bash
/proc/cpuinfo       # CPU details
/proc/meminfo       # Memory statistics
/proc/cmdline       # Kernel boot parameters
/proc/interrupts    # Interrupt statistics
/proc/modules       # Loaded kernel modules
/proc/<PID>/        # Per-process information

# Useful commands
cat /proc/cpuinfo | grep -E "model name|cpu cores"
cat /proc/meminfo | grep -E "MemTotal|MemFree|MemAvailable"
cat /proc/cmdline
```

#### /sys - Kernel Objects (sysfs)
```bash
/sys/class/         # Device classes
/sys/bus/           # Bus types
/sys/devices/       # Device hierarchy
/sys/block/         # Block devices

# Examples
# List GPIO chips
ls /sys/class/gpio/

# Control GPIO (if exported)
echo 17 > /sys/class/gpio/export
echo out > /sys/class/gpio/gpio17/direction
echo 1 > /sys/class/gpio/gpio17/value

# LED control
echo 1 > /sys/class/leds/led0/brightness

# View I2C devices
ls /sys/bus/i2c/devices/
```

#### /dev - Device Files
```bash
/dev/null        # Null device (discard output)
/dev/zero        # Zero source
/dev/random      # Random number generator
/dev/ttyUSB0     # USB serial
/dev/ttyS0       # Serial port
/dev/i2c-*       # I2C devices
/dev/spidev*     # SPI devices
/dev/gpiochip*   # GPIO character devices
/dev/mem         # Physical memory access
/dev/mmcblk*     # SD/eMMC storage

# Device types (ls -la /dev/)
# c = character device, b = block device
```

### 3. Embedded Filesystem Considerations

**Common Embedded Filesystems:**
| Filesystem | Use Case |
|------------|----------|
| ext4 | SD cards, eMMC |
| UBIFS | Raw NAND flash |
| SquashFS | Read-only rootfs |
| tmpfs | RAM-based /tmp, /run |
| overlayfs | Writable layer over read-only |

**Minimal Rootfs Structure:**
```bash
/bin       # BusyBox symlinks
/sbin
/lib       # Minimal libraries (musl-libc or uClibc)
/etc       # Minimal config (inittab, passwd)
/dev       # Device nodes (devtmpfs)
/proc
/sys
/tmp
```

---

## 💻 Hands-On Practice

```bash
# Explore virtual filesystems
cat /proc/cpuinfo
cat /proc/meminfo | head
cat /sys/class/net/eth0/address

# Find device major/minor numbers
ls -la /dev/tty*

# Mount information
cat /proc/mounts
findmnt
```

---

## 🔑 Key Takeaways

1. **/proc** exposes kernel and process info as files
2. **/sys** provides structured access to kernel objects
3. **/dev** contains device nodes for hardware access
4. Embedded systems use minimal rootfs with selected components

---

## 📎 References

- [Filesystem Hierarchy Standard](https://refspecs.linuxfoundation.org/FHS_3.0/fhs/index.html)
- `man hier` - filesystem hierarchy description
