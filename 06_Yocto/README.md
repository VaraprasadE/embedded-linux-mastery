# Yocto Project

## 📌 Purpose

This folder contains Yocto Project and OpenEmbedded resources for building custom embedded Linux distributions. Covers layer creation, recipe development, and BSP customization.

## 📚 Topics Covered

- **Yocto Fundamentals** — Layers, recipes, classes, configuration
- **BitBake** — Build system, tasks, dependencies
- **Layer Management** — Creating and managing layers
- **Recipe Development** — Writing and customizing recipes
- **Image Customization** — Custom images, packagegroups
- **BSP Layer** — Board support package development
- **SDK Generation** — Cross-compilation SDK
- **Distro Configuration** — Custom distribution settings
- **Package Management** — IPK, DEB, RPM packages
- **Debugging Builds** — devshell, build logs, debugging

## 🔧 Target BSPs

| Platform | BSP Layer | Yocto Version |
|----------|-----------|---------------|
| i.MX93 | meta-imx | Scarthgap/Kirkstone |
| Raspberry Pi | meta-raspberrypi | Scarthgap |

## 📁 Subdirectories

### `custom-layer/`
Custom meta-layer development with recipes and configurations

### `recipes/`
Individual recipe examples and modifications

### `build-notes/`
Build configuration notes and troubleshooting

## 🧪 Experiments & Projects

- [ ] Create custom meta-layer from scratch
- [ ] Write application recipe
- [ ] Customize kernel recipe (bbappend)
- [ ] Create custom image recipe
- [ ] SDK generation and usage
- [ ] Distro customization
- [ ] Package feed server setup

## 📁 Folder Structure

```
06_Yocto/
├── custom-layer/       # Custom meta-layer
├── recipes/            # Recipe examples
├── build-notes/        # Build documentation
├── configs/            # local.conf, bblayers.conf examples
└── README.md
```

## 🔗 Related Sections

- [12_Projects/yocto-custom-linux](../12_Projects/yocto-custom-linux) — Complete Yocto project
- [08_RootFS_Customization](../08_RootFS_Customization) — Filesystem customization
