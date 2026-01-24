# Exercise Module 04: Filesystem Exploration

## 🎯 Objective

Explore virtual filesystems (/proc, /sys, /dev) essential for embedded Linux.

---

## Exercises

### Exercise 1: /proc Exploration

```bash
# System information
cat /proc/cpuinfo | grep -E "model name|cpu cores" | head -4
cat /proc/meminfo | head -10
cat /proc/cmdline
cat /proc/version

# Kernel modules
cat /proc/modules | head -10
lsmod | head -10

# Interrupts and I/O
cat /proc/interrupts | head -20
cat /proc/ioports | head -10
```

---

### Exercise 2: /sys Exploration

```bash
# Network interfaces
ls /sys/class/net/
cat /sys/class/net/*/address

# Block devices
ls /sys/block/
cat /sys/block/*/size

# CPU information
ls /sys/devices/system/cpu/
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq 2>/dev/null || echo "No cpufreq"
```

---

### Exercise 3: /dev Exploration

```bash
# List device types
ls -la /dev | head -20

# Character vs Block devices
ls -la /dev | grep "^c" | head -5    # Character
ls -la /dev | grep "^b" | head -5    # Block

# Find serial devices
ls /dev/tty* | head -10
ls /dev/ttyUSB* 2>/dev/null || echo "No USB serial"
ls /dev/ttyACM* 2>/dev/null || echo "No ACM serial"
```

---

### Exercise 4: Mount Points

```bash
# View mounts
cat /proc/mounts | grep -v "^none"
findmnt -t ext4,vfat,tmpfs

# Filesystem info
df -hT

# Check specific filesystem
stat -f /
```

---

### Exercise 5: Create a Monitoring Script

Create `fs_monitor.sh`:

```bash
#!/bin/bash
echo "=== Virtual FS Monitor ==="

echo -e "\n/proc/meminfo (summary):"
grep -E "MemTotal|MemFree|MemAvailable|Buffers|Cached" /proc/meminfo

echo -e "\n/sys/class/net (interfaces):"
for iface in /sys/class/net/*/; do
    name=$(basename "$iface")
    mac=$(cat "$iface/address" 2>/dev/null || echo "N/A")
    state=$(cat "$iface/operstate" 2>/dev/null || echo "unknown")
    echo "  $name: $mac ($state)"
done

echo -e "\n/dev summary:"
echo "  Block devices: $(ls -la /dev | grep -c '^b')"
echo "  Char devices:  $(ls -la /dev | grep -c '^c')"
```

---

## ✅ Self-Assessment

- [ ] Can navigate /proc for system info
- [ ] Can explore /sys for device info
- [ ] Understand /dev device nodes
- [ ] Know difference between block and character devices
