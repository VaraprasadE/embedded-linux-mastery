# Exercise Module 05: Cross-Compilation

## 🎯 Objective

Set up cross-compilation environment for ARM targets.

---

## Prerequisites

```bash
# Install ARM toolchains (Ubuntu/Debian)
sudo apt update
sudo apt install gcc-arm-linux-gnueabihf    # ARMv7 (32-bit)
sudo apt install gcc-aarch64-linux-gnu       # ARM64 (64-bit)

# Verify installation
arm-linux-gnueabihf-gcc --version
aarch64-linux-gnu-gcc --version
```

---

## Exercises

### Exercise 1: Simple Cross-Compile

Create `hello.c`:
```c
#include <stdio.h>
int main() {
    printf("Hello from ARM!\n");
    return 0;
}
```

```bash
# Native compile
gcc hello.c -o hello_native
file hello_native

# Cross-compile for ARM32
arm-linux-gnueabihf-gcc hello.c -o hello_arm32
file hello_arm32

# Cross-compile for ARM64
aarch64-linux-gnu-gcc hello.c -o hello_arm64
file hello_arm64
```

---

### Exercise 2: Cross-Compile Makefile

Create `Makefile`:
```makefile
# Cross-compilation Makefile
CROSS_COMPILE ?= arm-linux-gnueabihf-
CC = $(CROSS_COMPILE)gcc
STRIP = $(CROSS_COMPILE)strip

TARGET = hello
SRC = hello.c

.PHONY: all clean native

all: $(TARGET)

$(TARGET): $(SRC)
	$(CC) -o $@ $<
	$(STRIP) $@

native:
	gcc -o $(TARGET)_native $(SRC)

clean:
	rm -f $(TARGET) $(TARGET)_native
```

```bash
# Build for ARM
make CROSS_COMPILE=arm-linux-gnueabihf-

# Build native
make native

# Check binaries
file hello hello_native
```

---

### Exercise 3: CMake Cross-Compilation

Create `toolchain-arm.cmake`:
```cmake
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR arm)

set(CMAKE_C_COMPILER arm-linux-gnueabihf-gcc)
set(CMAKE_CXX_COMPILER arm-linux-gnueabihf-g++)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
```

Create `CMakeLists.txt`:
```cmake
cmake_minimum_required(VERSION 3.10)
project(HelloCross)
add_executable(hello hello.c)
```

```bash
mkdir build-arm && cd build-arm
cmake -DCMAKE_TOOLCHAIN_FILE=../toolchain-arm.cmake ..
make
file hello
```

---

### Exercise 4: Check Binary Dependencies

```bash
# Check native binary
ldd hello_native

# Check ARM binary (won't work directly, use readelf)
arm-linux-gnueabihf-readelf -d hello_arm32 | grep NEEDED

# Static linking (no shared lib dependencies)
arm-linux-gnueabihf-gcc -static hello.c -o hello_static
file hello_static
arm-linux-gnueabihf-readelf -d hello_static | grep NEEDED
```

---

### Exercise 5: Build Script

Create `build.sh`:
```bash
#!/bin/bash
set -e

TARGET="${1:-arm}"
case "$TARGET" in
    arm)   CC=arm-linux-gnueabihf-gcc ;;
    arm64) CC=aarch64-linux-gnu-gcc ;;
    native) CC=gcc ;;
    *) echo "Usage: $0 {arm|arm64|native}"; exit 1 ;;
esac

echo "Building with: $CC"
$CC -o hello_${TARGET} hello.c
file hello_${TARGET}
echo "Done!"
```

---

## ✅ Self-Assessment

- [ ] Cross-compilation toolchain installed
- [ ] Can compile for ARM targets
- [ ] Understand Makefile CROSS_COMPILE variable
- [ ] Can verify binary architecture with `file`
- [ ] Know how to check binary dependencies
