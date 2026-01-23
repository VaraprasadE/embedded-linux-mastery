# Linux Kernel

## 📌 Purpose

This folder covers Linux kernel internals, configuration, compilation, and customization for embedded systems. Understanding the kernel is essential for driver development and system optimization.

## 📚 Topics Covered

- **Kernel Architecture** — Monolithic design, subsystems
- **Kernel Configuration** — menuconfig, Kconfig system
- **Kernel Compilation** — Native and cross-compilation
- **Kernel Modules** — Loading, building, dependencies
- **Memory Management** — Virtual memory, page tables, slab allocator
- **Process Scheduling** — CFS, real-time scheduling classes
- **Interrupt Handling** — Top/bottom halves, softirqs, tasklets
- **Kernel Debugging** — printk, dynamic debug, kgdb
- **Kernel Customization** — Patches, configuration for embedded

## 🔧 Kernel Versions & Platforms

| Platform | Kernel Source | Notes |
|----------|---------------|-------|
| i.MX93 | NXP linux-imx | Vendor BSP kernel |
| Raspberry Pi | raspberrypi/linux | Downstream kernel |
| Mainline | kernel.org | Reference/upstream |

## 🧪 Experiments & Projects

- [ ] Custom kernel configuration for minimal footprint
- [ ] Kernel module development (Hello World to advanced)
- [ ] Kernel boot time optimization
- [ ] PREEMPT_RT patch integration
- [ ] Custom kernel patches for hardware
- [ ] Kernel debugging sessions (kgdb, ftrace)

## 📁 Folder Structure

```
03_Kernel/
├── notes/              # Learning notes
├── configs/            # Kernel configurations
├── modules/            # Custom kernel modules
├── patches/            # Kernel patches
└── README.md
```

## 🔗 Related Sections

- [04_Device_Drivers](../04_Device_Drivers) — Driver development
- [05_Device_Tree](../05_Device_Tree) — Hardware description
- [07_Debugging](../07_Debugging) — Debugging techniques
