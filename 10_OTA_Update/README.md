# OTA Updates

## 📌 Purpose

This folder covers Over-The-Air (OTA) update systems for embedded Linux devices. Covers design, implementation, and security considerations for production update systems.

## 📚 Topics Covered

- **OTA Architecture** — A/B partitioning, recovery, rollback
- **Update Frameworks** — SWUpdate, Mender, RAUC, hawkBit
- **Image Formats** — Full image, delta updates, compressed images
- **Update Security** — Signing, verification, encryption
- **Boot Integration** — Bootloader support for A/B
- **Update Orchestration** — Server infrastructure, fleet management
- **Reliability** — Power-fail safety, atomic updates
- **Testing** — Update testing strategies

## 🔧 OTA Solutions

| Solution | Type | Integration |
|----------|------|-------------|
| SWUpdate | Image-based | Yocto (meta-swupdate) |
| Mender | Image/artifact | Yocto (meta-mender) |
| RAUC | Image-based | Yocto (meta-rauc) |
| hawkBit | Server | Eclipse IoT |

## 🧪 Experiments & Projects

- [ ] SWUpdate integration with Yocto
- [ ] A/B partition scheme design
- [ ] Signed update image creation
- [ ] Update server deployment
- [ ] Rollback mechanism implementation
- [ ] Delta update evaluation

## 📁 Folder Structure

```
10_OTA_Update/
├── notes/              # Learning notes
├── configs/            # OTA configuration
├── scripts/            # Update scripts
├── server/             # Update server setup
└── README.md
```

## 🔗 Related Sections

- [11_Secure_Boot](../11_Secure_Boot) — Secure update chain
- [06_Yocto](../06_Yocto) — Yocto OTA integration
- [12_Projects/ota-firmware-system](../12_Projects/ota-firmware-system)
