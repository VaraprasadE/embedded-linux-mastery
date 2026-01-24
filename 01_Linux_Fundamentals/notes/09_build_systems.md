# Learning Notes: Build Systems

> **Date**: 2026-01-24  
> **Module**: 01_Linux_Fundamentals  
> **Focus**: Make, CMake, and Cross-Compilation

---

## 📚 Topic Overview

Build systems automate the compilation process. Understanding Make, CMake, and cross-compilation is essential for embedded Linux development.

---

## 🎯 Learning Objectives

- [x] Write and understand Makefiles
- [x] Use CMake for modern projects
- [x] Perform cross-compilation for ARM targets

---

## 📝 Notes

### 1. GNU Make Basics

```makefile
# Basic Makefile structure
CC = gcc
CFLAGS = -Wall -g
TARGET = myapp
SRCS = main.c utils.c
OBJS = $(SRCS:.c=.o)

# Default target
all: $(TARGET)

# Link
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^

# Compile
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Clean
clean:
	rm -f $(OBJS) $(TARGET)

.PHONY: all clean
```

**Make Variables:**
- `$@` - Target name
- `$^` - All dependencies
- `$<` - First dependency
- `$(VAR)` - Variable expansion

```bash
# Running make
make                    # Build default target
make clean              # Run clean target
make -j$(nproc)         # Parallel build
make V=1                # Verbose
```

### 2. CMake

```cmake
# CMakeLists.txt
cmake_minimum_required(VERSION 3.10)
project(MyApp VERSION 1.0)

set(CMAKE_C_STANDARD 11)

add_executable(myapp
    src/main.c
    src/utils.c
)

target_include_directories(myapp PRIVATE include)
target_link_libraries(myapp pthread)
```

**CMake Build:**
```bash
mkdir build && cd build
cmake ..
make -j$(nproc)

# Or with Ninja
cmake -G Ninja ..
ninja
```

**Common CMake Commands:**
```cmake
find_package(Threads REQUIRED)
add_library(mylib STATIC src/lib.c)
target_compile_options(myapp PRIVATE -Wall -Wextra)
install(TARGETS myapp DESTINATION bin)
```

### 3. Cross-Compilation

**Toolchain Setup:**
```bash
# Install ARM toolchain
sudo apt install gcc-arm-linux-gnueabihf

# Toolchain components
arm-linux-gnueabihf-gcc      # C compiler
arm-linux-gnueabihf-g++      # C++ compiler
arm-linux-gnueabihf-ld       # Linker
arm-linux-gnueabihf-objdump  # Object dump
arm-linux-gnueabihf-strip    # Strip symbols
```

**Cross-Compile with Make:**
```makefile
# Cross-compilation Makefile
CROSS_COMPILE ?= arm-linux-gnueabihf-
CC = $(CROSS_COMPILE)gcc
STRIP = $(CROSS_COMPILE)strip

TARGET = myapp
SRCS = main.c

all: $(TARGET)

$(TARGET): $(SRCS)
	$(CC) -o $@ $^
	$(STRIP) $@
```

**Cross-Compile with CMake:**
```cmake
# toolchain-arm.cmake
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR arm)

set(CMAKE_C_COMPILER arm-linux-gnueabihf-gcc)
set(CMAKE_CXX_COMPILER arm-linux-gnueabihf-g++)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
```

```bash
# Build with toolchain file
cmake -DCMAKE_TOOLCHAIN_FILE=toolchain-arm.cmake ..
make
```

### 4. Autotools (Legacy)

```bash
# Typical autotools build
./configure --prefix=/usr
make -j$(nproc)
sudo make install

# Cross-compilation
./configure --host=arm-linux-gnueabihf \
            --prefix=/opt/target
make
make install DESTDIR=/staging
```

### 5. Embedded Build Tips

```bash
# Verify binary architecture
file myapp
# myapp: ELF 32-bit LSB executable, ARM, ...

# Check dependencies
arm-linux-gnueabihf-readelf -d myapp
arm-linux-gnueabihf-ldd myapp

# Static linking (avoid shared lib issues)
$(CC) -static -o myapp main.c

# Optimize for size
CFLAGS = -Os -s     # Optimize size, strip symbols
```

---

## 💻 Hands-On Practice

```bash
# Create simple project
mkdir test_build && cd test_build
cat > main.c << 'EOF'
#include <stdio.h>
int main() { printf("Hello!\n"); return 0; }
EOF

# Create Makefile
cat > Makefile << 'EOF'
CC = gcc
TARGET = hello
all: $(TARGET)
$(TARGET): main.c
	$(CC) -o $@ $<
clean:
	rm -f $(TARGET)
EOF

# Build and run
make
./hello
make clean
```

---

## 🔑 Key Takeaways

1. **Make** uses dependencies and rules for incremental builds
2. **CMake** generates build files for various systems
3. **Cross-compilation** requires proper toolchain prefix
4. Always verify binary architecture with `file` command

---

## 📎 References

- [GNU Make Manual](https://www.gnu.org/software/make/manual/)
- [CMake Documentation](https://cmake.org/documentation/)
- [Cross-Compilation Wiki](https://wiki.osdev.org/Cross-Compilation)
