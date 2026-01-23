# Bootloader & U-Boot

## 📌 Purpose

This folder documents bootloader concepts with a focus on Das U-Boot, the most widely used bootloader in embedded Linux systems. Covers configuration, customization, and debugging for various hardware platforms.

## 📚 Topics Covered

- **Boot Process** — Power-on to kernel handoff
- **U-Boot Architecture** — SPL, TPL, proper U-Boot stages
- **Configuration** — Kconfig, defconfig, environment variables
- **Device Tree in U-Boot** — DTB loading and configuration
- **Boot Commands** — bootm, bootz, booti, boot scripts
- **Network Boot** — TFTP, NFS, PXE boot
- **Storage Boot** — eMMC, SD card, NAND, NOR flash
- **Secure Boot** — HAB, verified boot chain
- **U-Boot Customization** — Board ports, driver additions

## 🔧 Target Platforms

| Platform | Bootloader | Notes |
|----------|------------|-------|
| i.MX93 | U-Boot | HAB secure boot, container image |
| Raspberry Pi | U-Boot | Can replace default bootloader |
| ESP32 | ESP-IDF bootloader | First/second stage boot |
| LPC54628 | MCUXpresso bootloader | ROM bootloader + application |

## 🧪 Experiments & Projects

- [ ] Custom U-Boot build for i.MX93
- [ ] Boot script automation
- [ ] Network boot (TFTP + NFS) setup
- [ ] Secure boot chain implementation
- [ ] U-Boot driver development
- [ ] Boot time optimization

## 📁 Folder Structure

```
02_Bootloader_U-Boot/
├── notes/              # Learning notes
├── configs/            # Board configurations
├── patches/            # Custom patches
├── scripts/            # Boot scripts
└── README.md
```

## 🔗 Related Sections

- [11_Secure_Boot](../11_Secure_Boot) — Security implementation
- [03_Kernel](../03_Kernel) — Kernel loading and handoff
