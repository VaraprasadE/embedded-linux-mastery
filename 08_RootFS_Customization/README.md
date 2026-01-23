# Root Filesystem Customization

## 📌 Purpose

This folder covers root filesystem (rootfs) creation, customization, and optimization for embedded Linux systems.

## 📚 Topics Covered

- **Filesystem Basics** — FHS, essential directories, permissions
- **BusyBox** — Minimal userspace, configuration
- **Init Systems** — SysVinit, systemd, BusyBox init
- **Filesystem Types** — ext4, squashfs, ubifs, JFFS2
- **Minimal Rootfs** — Building minimal filesystems from scratch
- **System Configuration** — network, users, services
- **Security Hardening** — Permissions, capabilities, SELinux
- **Size Optimization** — Stripping, compression, minimal configs
- **Overlay Filesystem** — Read-only root with overlay

## 🔧 Rootfs Creation Methods

| Method | Use Case | Notes |
|--------|----------|-------|
| Buildroot | Minimal systems | Simple, fast builds |
| Yocto | Production systems | Full customization |
| Debootstrap | Debian-based | Full-featured |
| Manual | Learning | From scratch |

## 🧪 Experiments & Projects

- [ ] Minimal BusyBox rootfs from scratch
- [ ] systemd-based rootfs configuration
- [ ] Read-only root with overlay
- [ ] Rootfs size optimization
- [ ] Custom init scripts
- [ ] Security hardening

## 📁 Folder Structure

```
08_RootFS_Customization/
├── notes/              # Learning notes
├── configs/            # Configuration files
├── scripts/            # Build scripts
├── rootfs-examples/    # Example rootfs structures
└── README.md
```

## 🔗 Related Sections

- [06_Yocto](../06_Yocto) — Yocto image creation
- [01_Linux_Fundamentals](../01_Linux_Fundamentals) — Linux basics
