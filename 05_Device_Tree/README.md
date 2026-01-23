# Device Tree

## 📌 Purpose

This folder covers Device Tree (DT) concepts, syntax, and usage in embedded Linux systems. Device Tree is the standard way to describe hardware to the Linux kernel on ARM and other architectures.

## 📚 Topics Covered

- **Device Tree Basics** — DTS, DTSI, DTB, DTC compiler
- **Syntax & Structure** — Nodes, properties, phandles, labels
- **Bindings** — Standard bindings documentation
- **Overlays** — Runtime device tree modifications
- **Platform Integration** — U-Boot DTB passing, kernel DTB loading
- **Debugging** — /proc/device-tree, dtc decompilation
- **Common Subsystems** — clocks, pinctrl, regulators, GPIO, interrupts

## 🔧 Device Tree for Target Platforms

| Platform | Device Tree Location | Notes |
|----------|---------------------|-------|
| i.MX93 | arch/arm64/boot/dts/freescale/ | imx93-*.dts |
| Raspberry Pi | arch/arm/boot/dts/ | bcm2837-*.dts |

## 🧪 Experiments & Projects

- [ ] Custom device tree overlay for GPIO expansion
- [ ] Adding new I2C/SPI device nodes
- [ ] Clock and pinctrl configuration
- [ ] Display/panel device tree setup
- [ ] Custom board device tree
- [ ] Device tree overlay loading at runtime

## 📁 Folder Structure

```
05_Device_Tree/
├── notes/              # Learning notes
├── dts/                # Device tree source files
├── overlays/           # Device tree overlays
├── examples/           # Example configurations
└── README.md
```

## 🔗 Related Sections

- [04_Device_Drivers](../04_Device_Drivers) — Driver bindings
- [06_Yocto](../06_Yocto) — BSP device tree integration
