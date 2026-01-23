# Yocto Custom Linux Project

## 📌 Overview

A production-ready custom embedded Linux distribution built with Yocto Project, demonstrating complete BSP customization.

## 🎯 Goals

- Custom meta-layer with application recipes
- Optimized kernel configuration
- Custom systemd services
- Minimal rootfs footprint
- SDK generation for development
- Reproducible builds

## 🔧 Target Platform

- **Primary**: NXP i.MX93 EVK
- **Secondary**: Raspberry Pi 3B+
- **Yocto Release**: Scarthgap (4.1)

## 📁 Project Structure

```
yocto-custom-linux/
├── docs/               # Documentation
├── meta-custom/        # Custom meta-layer
│   ├── conf/
│   ├── recipes-apps/
│   ├── recipes-bsp/
│   ├── recipes-core/
│   └── recipes-kernel/
├── configs/            # Build configurations
├── scripts/            # Build scripts
└── README.md
```

## 📊 Status

- [ ] Project specification
- [ ] Base Yocto setup
- [ ] Custom meta-layer creation
- [ ] Kernel customization
- [ ] Image recipe
- [ ] Application recipes
- [ ] SDK generation
- [ ] Documentation
