# Learning Notes: Package Management

> **Date**: 2026-01-24  
> **Module**: 01_Linux_Fundamentals  
> **Focus**: apt, dpkg, and Building from Source

---

## 📚 Topic Overview

Package management on development hosts differs from embedded targets. This covers Debian/Ubuntu tools for development and building software from source for cross-compilation.

---

## 🎯 Learning Objectives

- [x] Master apt and dpkg package management
- [x] Build software from source
- [x] Understand cross-compilation packages

---

## 📝 Notes

### 1. APT (Advanced Package Tool)

```bash
# Update package lists
sudo apt update

# Upgrade installed packages
sudo apt upgrade

# Install packages
sudo apt install package-name
sudo apt install gcc make cmake

# Remove packages
sudo apt remove package-name
sudo apt purge package-name    # Also remove config

# Search packages
apt search keyword
apt-cache search keyword

# Show package info
apt show package-name

# List installed
apt list --installed

# Clean cache
sudo apt autoremove
sudo apt clean
```

### 2. DPKG (Low-level)

```bash
# Install .deb file
sudo dpkg -i package.deb

# Remove package
sudo dpkg -r package-name

# List installed packages
dpkg -l
dpkg -l | grep linux-image

# List files in package
dpkg -L package-name

# Find which package owns a file
dpkg -S /usr/bin/gcc

# Query package status
dpkg -s package-name
```

### 3. Essential Development Packages

```bash
# Basic build tools
sudo apt install build-essential   # gcc, g++, make

# Common development tools
sudo apt install git cmake ninja-build
sudo apt install pkg-config autoconf automake

# Cross-compilation toolchains
sudo apt install gcc-arm-linux-gnueabihf    # ARMv7
sudo apt install gcc-aarch64-linux-gnu       # ARM64

# Libraries for development
sudo apt install libssl-dev libcurl4-openssl-dev
```

### 4. Building from Source

```bash
# Typical build process
wget https://example.com/software-1.0.tar.gz
tar xzf software-1.0.tar.gz
cd software-1.0

# Configure, build, install
./configure --prefix=/usr/local
make -j$(nproc)
sudo make install

# CMake-based projects
mkdir build && cd build
cmake ..
make -j$(nproc)
sudo make install

# Cross-compilation example
./configure --host=arm-linux-gnueabihf \
            --prefix=/opt/arm-rootfs/usr
make -j$(nproc)
make install DESTDIR=/opt/arm-rootfs
```

### 5. Managing Dependencies

```bash
# Install build dependencies for a package
sudo apt build-dep package-name

# Check missing dependencies
ldd /path/to/binary

# Find package providing a file
apt-file search header.h
# (requires: sudo apt install apt-file && apt-file update)
```

---

## 💻 Hands-On Practice

```bash
# Install development essentials
sudo apt update
sudo apt install build-essential git cmake

# Check GCC version
gcc --version

# Build a simple project
git clone https://github.com/example/small-project.git
cd small-project && mkdir build && cd build
cmake .. && make
```

---

## 🔑 Key Takeaways

1. **apt** for high-level package management, **dpkg** for low-level
2. **build-essential** provides gcc, g++, make
3. **Cross toolchains** available via apt for ARM targets
4. Know the **configure/make/install** workflow

---

## 📎 References

- `man apt`, `man dpkg`
- [GNU Make Manual](https://www.gnu.org/software/make/manual/)
