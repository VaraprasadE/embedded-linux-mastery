# Device Drivers

## 📌 Purpose

This folder contains Linux device driver development resources, examples, and documentation. Covers character drivers, bus drivers (I2C, SPI), GPIO subsystem, and platform drivers.

## 📚 Topics Covered

- **Driver Model** — Bus, device, driver framework
- **Character Drivers** — file_operations, major/minor numbers
- **GPIO Subsystem** — gpiolib, GPIO descriptors, interrupts
- **I2C Subsystem** — i2c_driver, i2c_client, SMBus
- **SPI Subsystem** — spi_driver, transfers, modes
- **Platform Drivers** — platform_device, platform_driver, resources
- **Device Tree Binding** — Compatible strings, property parsing
- **Interrupts** — Request, handling, threaded IRQs
- **DMA** — DMA engine API, scatter-gather
- **Power Management** — Runtime PM, suspend/resume

## 📁 Subdirectories

### `gpio/`
GPIO driver examples, LED drivers, button input drivers

### `i2c/`
I2C client drivers, sensor drivers, EEPROM access

### `spi/`
SPI device drivers, flash drivers, display controllers

### `platform/`
Platform device drivers, memory-mapped peripherals

## 🧪 Experiments & Projects

- [ ] Simple character driver (read/write/ioctl)
- [ ] GPIO LED driver with device tree
- [ ] I2C sensor driver (temperature, accelerometer)
- [ ] SPI flash driver
- [ ] Platform driver for custom peripheral
- [ ] Interrupt-driven driver with workqueues

## 📁 Folder Structure

```
04_Device_Drivers/
├── gpio/               # GPIO drivers
├── i2c/                # I2C drivers
├── spi/                # SPI drivers
├── platform/           # Platform drivers
├── common/             # Shared utilities
└── README.md
```

## 🔗 Related Sections

- [03_Kernel](../03_Kernel) — Kernel module basics
- [05_Device_Tree](../05_Device_Tree) — Device bindings
- [07_Debugging](../07_Debugging) — Driver debugging
