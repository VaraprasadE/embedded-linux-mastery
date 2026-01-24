# Learning Notes: Permissions & Users

> **Date**: 2026-01-24  
> **Module**: 01_Linux_Fundamentals  
> **Focus**: File Permissions and User Management

---

## 📚 Topic Overview

Linux security model is based on users, groups, and file permissions. Understanding this is essential for embedded systems where proper access control protects hardware interfaces.

---

## 🎯 Learning Objectives

- [x] Understand permission model (owner, group, others)
- [x] Master chmod, chown, chgrp commands
- [x] Learn user and group management
- [x] Understand special permissions

---

## 📝 Notes

### 1. Permission Basics

```
-rwxr-xr-- 1 user group 4096 Jan 24 10:00 file.txt
│├─┤├─┤├─┤
│ │  │  └── Others permissions
│ │  └───── Group permissions  
│ └──────── Owner permissions
└────────── File type (- = file, d = directory, l = symlink)
```

| Symbol | Value | Meaning |
|--------|-------|---------|
| r | 4 | Read |
| w | 2 | Write |
| x | 1 | Execute |

### 2. Changing Permissions

```bash
# Symbolic mode
chmod u+x file          # Add execute for owner
chmod g-w file          # Remove write for group
chmod o=r file          # Set others to read only
chmod a+r file          # Add read for all
chmod u=rwx,g=rx,o= file  # Full specification

# Numeric mode
chmod 755 file          # rwxr-xr-x
chmod 644 file          # rw-r--r--
chmod 700 file          # rwx------

# Recursive
chmod -R 750 directory/
```

### 3. Ownership

```bash
# Change owner
chown user file
chown user:group file

# Change group
chgrp group file

# Recursive
chown -R user:group directory/
```

### 4. Special Permissions

| Permission | Symbol | Effect |
|------------|--------|--------|
| SUID | s (4xxx) | Execute as file owner |
| SGID | s (2xxx) | Execute as file group |
| Sticky | t (1xxx) | Only owner can delete |

```bash
chmod 4755 file         # SUID
chmod 2755 dir          # SGID
chmod 1777 /tmp         # Sticky bit
```

### 5. User Management

```bash
# User operations
useradd username
useradd -m -s /bin/bash username  # With home and shell
userdel username
passwd username

# Group operations
groupadd groupname
groupdel groupname
usermod -aG group username

# View info
id username
groups username
cat /etc/passwd
cat /etc/group
```

### 6. Embedded Device Permissions

```bash
# Give user access to serial port
usermod -aG dialout $USER

# GPIO access
usermod -aG gpio $USER

# I2C access
usermod -aG i2c $USER

# Create udev rule for device permissions
# /etc/udev/rules.d/99-gpio.rules
# SUBSYSTEM=="gpio", GROUP="gpio", MODE="0660"
```

---

## 💻 Hands-On Practice

```bash
# Check current permissions
ls -la /etc/passwd

# Create test file and experiment
touch testfile
chmod 640 testfile
ls -l testfile

# View your groups
id
groups
```

---

## 🔑 Key Takeaways

1. **Three permission sets**: owner, group, others
2. **Numeric mode** (755, 644) is concise for scripting
3. **Device access** typically requires group membership
4. **SUID/SGID** should be used sparingly for security

---

## 📎 References

- `man chmod`, `man chown`, `man useradd`
