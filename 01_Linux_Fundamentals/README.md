# Linux Fundamentals

## 📌 Purpose

This folder contains foundational Linux knowledge essential for embedded Linux development. Understanding these concepts is critical before diving into kernel, drivers, or BSP development.

## 📚 Topics Covered

- **Linux Architecture** — Kernel, user space, system calls
- **Command Line Mastery** — Essential commands, pipes, redirection
- **Shell Scripting** — Bash scripting for automation
- **Process Management** — Processes, threads, signals, scheduling
- **Filesystem Hierarchy** — FHS, virtual filesystems (/proc, /sys, /dev)
- **Permissions & Users** — File permissions, user management
- **Package Management** — apt, dpkg, building from source
- **Networking Basics** — IP configuration, sockets, network tools
- **Build Systems** — Make, CMake, cross-compilation basics

## 🧪 Experiments & Projects

- [x] Complete learning notes for all 9 topics
- [x] Hands-on exercises with solutions
- [x] Shell script collection for embedded development
- [ ] Practice on real Linux environment (your task!)

## 📁 Folder Structure

```
01_Linux_Fundamentals/
├── notes/                          # Learning notes (9 topics)
│   ├── 01_linux_architecture.md
│   ├── 02_command_line.md
│   ├── 03_shell_scripting.md
│   ├── 04_process_management.md
│   ├── 05_filesystem_hierarchy.md
│   ├── 06_permissions_users.md
│   ├── 07_package_management.md
│   ├── 08_networking_basics.md
│   └── 09_build_systems.md
├── exercises/                      # Practice exercises
│   ├── 01_basic_commands/
│   ├── 02_shell_scripting/
│   ├── 03_process_signals/
│   ├── 04_filesystem_exploration/
│   └── 05_cross_compilation/
├── scripts/                        # Utility scripts
│   ├── system/
│   ├── filesystem/
│   ├── network/
│   └── utils/
└── README.md
```

## 🚀 Getting Started

1. **Start with notes** — Read through `notes/01_linux_architecture.md`
2. **Do exercises** — Practice in `exercises/01_basic_commands/`
3. **Try scripts** — Run scripts from `scripts/` on your Linux system
4. **Progress sequentially** — Follow numbered order

## 📖 Recommended Learning Path

```
Week 1: Architecture, Command Line, Shell Scripting
Week 2: Process Management, Filesystem Hierarchy
Week 3: Permissions, Package Management
Week 4: Networking, Build Systems + Cross-compilation
```

## 🔗 Related Sections

- [03_Kernel](../03_Kernel) — Deeper kernel understanding
- [08_RootFS_Customization](../08_RootFS_Customization) — Filesystem customization
- [04_Device_Drivers](../04_Device_Drivers) — Apply Linux knowledge to drivers
