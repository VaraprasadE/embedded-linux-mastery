# RTOS Development

## 📌 Purpose

This folder contains Real-Time Operating System (RTOS) development resources for various microcontroller platforms. Covers Zephyr RTOS, FreeRTOS, and bare-metal firmware development.

## 📚 Topics Covered

- **RTOS Fundamentals** — Tasks, scheduling, priorities
- **Inter-Task Communication** — Queues, semaphores, mutexes, events
- **Memory Management** — Static/dynamic allocation, memory pools
- **Interrupt Handling** — ISR design, deferred processing
- **Device Drivers** — RTOS driver models
- **Power Management** — Low-power modes, tickless idle
- **Debugging** — Trace tools, timing analysis
- **Mixed Systems** — Linux + RTOS (AMP, heterogeneous)

## 🔧 RTOS Platforms

| RTOS | Target MCU | Notes |
|------|------------|-------|
| Zephyr | MCX947 | Modern RTOS, device tree |
| FreeRTOS | LPC54628 | Industry standard |
| ESP-IDF (FreeRTOS) | ESP32 | WiFi/BLE support |
| Bare-metal | All MCUs | No OS, direct hardware |

## 📁 Subdirectories

### `zephyr/`
Zephyr RTOS projects and samples for MCX947

### `freertos/`
FreeRTOS projects for LPC54628

### `esp32/`
ESP32 firmware with ESP-IDF

### `lpc54628/`
LPC54628 specific projects

### `mcx947/`
MCX947 specific projects

## 🧪 Experiments & Projects

- [ ] Zephyr getting started on MCX947
- [ ] FreeRTOS task management on LPC54628
- [ ] ESP32 WiFi/BLE firmware
- [ ] RTOS-Linux communication (RPMsg, shared memory)
- [ ] Real-time sensor data acquisition
- [ ] Low-power firmware design

## 📁 Folder Structure

```
09_RTOS/
├── zephyr/             # Zephyr RTOS projects
├── freertos/           # FreeRTOS projects
├── esp32/              # ESP32 firmware
├── lpc54628/           # LPC54628 projects
├── mcx947/             # MCX947 projects
├── common/             # Shared code
└── README.md
```

## 🔗 Related Sections

- [07_Debugging](../07_Debugging) — RTOS debugging
- [12_Projects](../12_Projects) — Complete projects
