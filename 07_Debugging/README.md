# Debugging

## 📌 Purpose

This folder contains debugging techniques, tools, and methodologies for embedded Linux and firmware development. Covers both Linux kernel/userspace and RTOS debugging.

## 📚 Topics Covered

- **GDB Debugging** — Remote debugging, GDB scripts, multi-target
- **JTAG/SWD** — Hardware debugging with OpenOCD, J-Link
- **Kernel Debugging** — kgdb, printk, dynamic debug
- **Tracing** — ftrace, trace-cmd, LTTng
- **Performance** — perf, oprofile, flame graphs
- **Memory Debugging** — valgrind, KASAN, memory leak detection
- **Crash Analysis** — kdump, crash utility, core dumps
- **Logging** — syslog, journald, kernel ring buffer
- **RTOS Debugging** — Segger SystemView, trace hooks
- **Serial Console** — UART debugging, minicom, picocom

## 🔧 Debugging Tools

| Tool | Use Case | Platform |
|------|----------|----------|
| GDB + gdbserver | Remote debugging | All Linux |
| OpenOCD | JTAG/SWD debugging | ARM targets |
| J-Link | Hardware debugging | ARM MCUs |
| ftrace | Kernel tracing | Linux |
| Segger SystemView | RTOS tracing | Zephyr/FreeRTOS |

## 🧪 Experiments & Projects

- [ ] Remote GDB debugging setup
- [ ] Kernel debugging with kgdb
- [ ] ftrace function tracing
- [ ] Performance profiling with perf
- [ ] Memory leak detection
- [ ] JTAG debugging with OpenOCD
- [ ] Crash dump analysis

## 📁 Folder Structure

```
07_Debugging/
├── notes/              # Learning notes
├── scripts/            # Debug scripts
├── configs/            # Tool configurations
├── logs/               # Debug session logs
└── README.md
```

## 🔗 Related Sections

- [03_Kernel](../03_Kernel) — Kernel internals
- [04_Device_Drivers](../04_Device_Drivers) — Driver debugging
- [09_RTOS](../09_RTOS) — RTOS debugging
