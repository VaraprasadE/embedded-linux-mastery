# Platform Drivers

## 📌 Purpose

Platform device driver development for memory-mapped peripherals and SoC-integrated devices.

## 📚 Topics Covered

- Platform device model
- Platform driver registration
- Resource handling (IORESOURCE_MEM, IORESOURCE_IRQ)
- Device tree integration
- Probe and remove functions
- devm_* managed resources
- Clock and regulator handling
- Reset controller integration

## 🧪 Experiments

- [ ] Simple platform driver skeleton
- [ ] Memory-mapped register access
- [ ] Platform driver with multiple resources
- [ ] Platform driver with clocks and resets
- [ ] Custom peripheral driver

## 📁 Contents

```
platform/
├── basic-driver/       # Simple platform driver
├── peripheral-driver/  # Custom peripheral
├── examples/           # Code examples
└── templates/          # Driver templates
```
