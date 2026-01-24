# Learning Notes: Linux Architecture

> **Date**: 2026-01-24  
> **Module**: 01_Linux_Fundamentals  
> **Focus**: Embedded Linux Development

---

## 📚 Topic Overview

Understanding Linux architecture is the foundation for embedded Linux development. This module covers how the Linux kernel operates, the distinction between kernel space and user space, and how applications interact with hardware through system calls.

---

## 🎯 Learning Objectives

- [x] Understand the layered architecture of Linux
- [x] Differentiate between kernel space and user space
- [x] Learn how system calls bridge user applications and kernel
- [x] Explore key kernel subsystems relevant to embedded development
- [x] Understand the boot process flow

---

## 📝 Notes

### 1. Linux Architecture Overview

Linux follows a **monolithic kernel** design with loadable module support. The architecture consists of distinct layers:

```
┌─────────────────────────────────────────────────────────────┐
│                     USER APPLICATIONS                        │
│              (shells, editors, custom apps)                  │
├─────────────────────────────────────────────────────────────┤
│                      SYSTEM LIBRARIES                        │
│                    (glibc, musl, uclibc)                    │
├─────────────────────────────────────────────────────────────┤
│                      SYSTEM CALL INTERFACE                   │
│                    (software interrupt)                      │
├─────────────────────────────────────────────────────────────┤
│                         LINUX KERNEL                         │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────────┐   │
│  │ Process  │ │  Memory  │ │   VFS    │ │   Network    │   │
│  │ Scheduler│ │ Manager  │ │          │ │    Stack     │   │
│  └──────────┘ └──────────┘ └──────────┘ └──────────────┘   │
│  ┌──────────────────────────────────────────────────────┐   │
│  │              DEVICE DRIVERS                           │   │
│  │    (GPIO, I2C, SPI, UART, USB, Network, Storage)     │   │
│  └──────────────────────────────────────────────────────┘   │
├─────────────────────────────────────────────────────────────┤
│                         HARDWARE                             │
│         (CPU, Memory, Peripherals, Network, Storage)        │
└─────────────────────────────────────────────────────────────┘
```

### 2. Kernel Space vs User Space

**Memory Protection Rings (x86 Architecture)**
```
Ring 0 ──► Kernel Space (Full hardware access)
Ring 3 ──► User Space (Restricted access)
```

| Aspect | Kernel Space | User Space |
|--------|--------------|------------|
| **Memory Access** | All physical memory | Virtual memory (process isolated) |
| **Hardware Access** | Direct | Via system calls only |
| **Privileges** | Full (Ring 0) | Limited (Ring 3) |
| **Crash Impact** | System crash | Only process crashes |
| **Code Location** | Kernel, modules | Applications, libraries |

**Why This Matters for Embedded:**
- Device drivers run in kernel space
- Your applications run in user space
- Understanding this boundary is crucial for driver development

### 3. System Calls

System calls are the **gateway** between user applications and the kernel.

**Common System Call Categories:**

| Category | System Calls | Embedded Use Case |
|----------|--------------|-------------------|
| **Process** | `fork()`, `exec()`, `wait()`, `exit()` | Spawning worker processes |
| **File I/O** | `open()`, `read()`, `write()`, `close()` | Reading sensor data, config files |
| **Device** | `ioctl()`, `mmap()` | Controlling hardware devices |
| **Memory** | `brk()`, `mmap()`, `munmap()` | DMA buffers, shared memory |
| **Network** | `socket()`, `bind()`, `connect()` | IoT communication |

**System Call Flow:**
```
User App                    Kernel
   │                          │
   ├── write(fd, buf, len) ──►│
   │    (libc wrapper)        │
   │         │                │
   │    syscall instruction   │
   │         │                │
   │         ▼                │
   │    ┌─────────────┐       │
   │    │ sys_write() │◄──────┤
   │    └─────────────┘       │
   │         │                │
   │    Driver interaction    │
   │         │                │
   │◄── return value ─────────┤
```

**Tracing System Calls:**
```bash
# Trace all system calls made by a command
strace ls -la

# Trace only file-related calls
strace -e trace=file ls

# Count system calls
strace -c ./your_program

# Trace a running process
strace -p <PID>
```

### 4. Key Kernel Subsystems

#### Process Management
- **Scheduler**: CFS (Completely Fair Scheduler), RT schedulers
- **Process Creation**: fork(), clone(), exec()
- **Inter-Process Communication**: pipes, signals, shared memory

```bash
# View process tree
pstree -p

# View process details
cat /proc/<PID>/status

# View scheduler info
cat /proc/<PID>/sched
```

#### Memory Management
- **Virtual Memory**: Each process has its own address space
- **Physical Memory**: Managed by kernel, allocated to processes
- **Memory Zones**: DMA, Normal, HighMem

```bash
# View memory info
cat /proc/meminfo

# View process memory maps
cat /proc/<PID>/maps

# View memory zones
cat /proc/zoneinfo
```

#### Virtual File System (VFS)
- Abstraction layer for different filesystems
- Provides uniform interface: open, read, write, close
- Critical for embedded: flash filesystems (JFFS2, UBIFS, ext4)

```bash
# View mounted filesystems
cat /proc/mounts

# View filesystem types supported
cat /proc/filesystems
```

#### Network Stack
- Socket interface for network communication
- Protocol implementation (TCP/IP, UDP)
- Network device drivers

### 5. The Boot Process

Understanding boot is essential for embedded Linux bring-up:

```
┌──────────────────────────────────────────────────────────────┐
│                      BOOT SEQUENCE                            │
└──────────────────────────────────────────────────────────────┘

1. POWER ON
      │
      ▼
2. BOOTROM / BIOS / UEFI
   └── Hardware initialization, load bootloader
      │
      ▼
3. BOOTLOADER (U-Boot / GRUB)
   └── Initialize RAM, load kernel + DTB to memory
      │
      ▼
4. KERNEL INITIALIZATION
   ├── Decompress kernel
   ├── Initialize memory management
   ├── Initialize scheduler
   ├── Initialize device drivers
   └── Mount root filesystem
      │
      ▼
5. INIT PROCESS (PID 1)
   ├── systemd / SysVinit / BusyBox init
   └── Start system services
      │
      ▼
6. USER SPACE READY
   └── Login prompt / Application
```

**Key Files in Boot:**
```bash
# Kernel image
/boot/vmlinuz-*

# Device Tree Blob (embedded)
/boot/dtbs/*.dtb

# Initial RAM disk
/boot/initrd.img-* or /boot/initramfs-*

# Bootloader config
/boot/grub/grub.cfg  # GRUB
# or U-Boot environment for embedded
```

---

## 💻 Hands-On Practice

### Exercise 1: Explore Kernel Information

**Goal**: Understand your running kernel

```bash
# Kernel version
uname -a

# Kernel release
uname -r

# Kernel configuration (if available)
cat /boot/config-$(uname -r) | head -50

# Or from /proc
zcat /proc/config.gz | head -50  # If enabled on your system
```

### Exercise 2: Explore /proc Filesystem

**Goal**: Understand kernel-exposed information

```bash
# CPU information
cat /proc/cpuinfo

# Kernel command line (boot parameters)
cat /proc/cmdline

# Loaded kernel modules
cat /proc/modules

# System uptime
cat /proc/uptime

# Interrupts
cat /proc/interrupts
```

### Exercise 3: Trace a Simple Program

**Goal**: See system calls in action

```bash
# Create a simple program
echo 'int main() { return 0; }' > test.c
gcc test.c -o test

# Trace its execution
strace ./test

# Count calls
strace -c ./test
```

---

## 🔑 Key Takeaways

1. **Linux has a monolithic kernel** with loadable modules - drivers and core functionality share the same address space

2. **User space and kernel space separation** provides stability and security - crashes in user apps don't crash the system

3. **System calls are the only way** for user applications to request kernel services - 
understanding them is crucial for debugging

4. **The /proc filesystem** is your window into the kernel - essential for embedded development and debugging

5. **Boot sequence knowledge** is critical for embedded bring-up - hardware → bootloader → kernel → userspace

---

## ❓ Questions / To Explore

- How does the kernel handle real-time requirements? (See PREEMPT_RT)
- What's the difference between monolithic and microkernel architectures?
- How do kernel modules differ from built-in kernel features?

---

## 📎 References

- [Linux Kernel Documentation](https://www.kernel.org/doc/html/latest/)
- [The Linux Programming Interface](https://man7.org/tlpi/) - Michael Kerrisk
- [Anatomy of the Linux Kernel](https://developer.ibm.com/articles/l-linux-kernel/)
- `man 2 syscalls` - System calls manual page

---

## 🔗 Related Notes

- [04_process_management.md](04_process_management.md) - Deep dive into processes
- [05_filesystem_hierarchy.md](05_filesystem_hierarchy.md) - Virtual filesystems
- [../../03_Kernel/](../../03_Kernel/) - Kernel configuration and compilation
