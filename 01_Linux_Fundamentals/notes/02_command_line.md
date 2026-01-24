# Learning Notes: Command Line Mastery

> **Date**: 2026-01-24  
> **Module**: 01_Linux_Fundamentals  
> **Focus**: Essential Commands for Embedded Linux Development

---

## 📚 Topic Overview

Mastering the command line is essential for embedded Linux development where GUI tools are often unavailable. This module covers essential commands, pipes, redirection, and powerful text processing tools.

---

## 🎯 Learning Objectives

- [x] Master essential file and directory commands
- [x] Understand I/O redirection and pipes
- [x] Use powerful text processing tools (grep, sed, awk)
- [x] Work efficiently with find and xargs
- [x] Learn essential networking and system commands

---

## 📝 Notes

### 1. Essential Navigation & File Commands

#### Directory Navigation
```bash
# Change directory
cd /path/to/dir
cd ..          # Parent directory
cd ~           # Home directory
cd -           # Previous directory

# Print working directory
pwd

# List files
ls -la         # Long format with hidden files
ls -lh         # Human-readable sizes
ls -ltr        # Sort by time, reverse
ls -R          # Recursive listing
```

#### File Operations
```bash
# Create files and directories
touch file.txt
mkdir -p parent/child/grandchild  # Create nested dirs

# Copy, move, remove
cp source dest
cp -r source_dir dest_dir         # Recursive copy
mv source dest
rm file
rm -rf directory                  # Force recursive delete (DANGEROUS!)

# View file contents
cat file.txt                      # Entire file
head -n 20 file.txt              # First 20 lines
tail -n 20 file.txt              # Last 20 lines
tail -f /var/log/syslog          # Follow file (live updates)
less file.txt                    # Paginated view

# File information
file myprogram                   # File type detection
stat file.txt                    # Detailed file stats
wc -l file.txt                   # Line count
```

### 2. I/O Redirection

Understanding standard streams:
```
stdin  (0) ──► Process ──► stdout (1)
                    └────► stderr (2)
```

#### Output Redirection
```bash
# Redirect stdout to file (overwrite)
command > output.txt

# Redirect stdout to file (append)
command >> output.txt

# Redirect stderr to file
command 2> errors.txt

# Redirect both stdout and stderr
command > output.txt 2>&1
command &> output.txt            # Bash shorthand

# Discard output
command > /dev/null 2>&1
```

#### Input Redirection
```bash
# Read from file
command < input.txt

# Here document (inline input)
cat << EOF
This is line 1
This is line 2
EOF

# Here string
grep "pattern" <<< "search in this string"
```

### 3. Pipes and Command Chaining

#### Pipes
```bash
# Connect stdout of one command to stdin of another
command1 | command2 | command3

# Examples
ls -la | grep "^d"               # List only directories
cat /proc/cpuinfo | grep "model name"
dmesg | tail -50                 # Last 50 kernel messages
ps aux | grep myprocess          # Find a process
```

#### Command Chaining
```bash
# Sequential execution (run regardless of previous result)
command1 ; command2

# AND - run second only if first succeeds
command1 && command2

# OR - run second only if first fails
command1 || command2

# Example: Compile and run if successful
gcc -o program main.c && ./program

# Example: Try command, show error if fails
mount /dev/sda1 /mnt || echo "Mount failed!"
```

### 4. Text Processing Power Tools

#### grep - Pattern Searching
```bash
# Basic search
grep "pattern" file.txt

# Recursive search in directory
grep -r "pattern" /path/to/dir

# Case-insensitive search
grep -i "pattern" file.txt

# Show line numbers
grep -n "pattern" file.txt

# Invert match (lines NOT containing pattern)
grep -v "pattern" file.txt

# Count matches
grep -c "pattern" file.txt

# Extended regex
grep -E "pattern1|pattern2" file.txt

# Show context (3 lines before and after)
grep -B3 -A3 "pattern" file.txt

# Useful for embedded development
grep -r "CONFIG_GPIO" /path/to/kernel/
dmesg | grep -i "error\|fail"
grep -E "^\s*(#define|struct)" driver.c
```

#### sed - Stream Editor
```bash
# Substitute first occurrence per line
sed 's/old/new/' file.txt

# Substitute all occurrences
sed 's/old/new/g' file.txt

# Edit file in-place
sed -i 's/old/new/g' file.txt

# Delete lines matching pattern
sed '/pattern/d' file.txt

# Print only matching lines
sed -n '/pattern/p' file.txt

# Delete empty lines
sed '/^$/d' file.txt

# Useful examples
# Change IP address in config
sed -i 's/192.168.1.1/10.0.0.1/g' config.txt

# Remove comments from file
sed '/^#/d' config.txt

# Add prefix to each line
sed 's/^/PREFIX: /' file.txt
```

#### awk - Pattern Processing
```bash
# Print specific columns
awk '{print $1, $3}' file.txt

# Use custom delimiter
awk -F':' '{print $1}' /etc/passwd

# Print lines matching pattern
awk '/pattern/ {print}' file.txt

# Print line numbers
awk '{print NR, $0}' file.txt

# Sum a column
awk '{sum += $1} END {print sum}' numbers.txt

# Useful examples
# Parse /proc/meminfo
awk '/MemTotal|MemFree/ {print $1, $2}' /proc/meminfo

# Get process PIDs
ps aux | awk '/myprocess/ {print $2}'

# Parse log files
awk '/ERROR/ {print $1, $2, $NF}' app.log
```

### 5. find and xargs

#### find - Locate Files
```bash
# Find by name
find /path -name "*.c"

# Find by name (case-insensitive)
find /path -iname "*.C"

# Find by type (f=file, d=directory, l=symlink)
find /path -type f -name "*.sh"

# Find by size
find /path -size +10M          # Files larger than 10MB
find /path -size -1k           # Files smaller than 1KB

# Find by modification time
find /path -mtime -7           # Modified in last 7 days
find /path -mmin -30           # Modified in last 30 minutes

# Find and execute command
find /path -name "*.o" -exec rm {} \;
find /path -name "*.c" -exec grep -l "main" {} \;

# Find with multiple conditions
find /path -name "*.c" -o -name "*.h"  # OR
find /path -name "*.c" -a -size +1k    # AND
```

#### xargs - Build Commands from Input
```bash
# Basic usage
find . -name "*.txt" | xargs grep "pattern"

# Handle filenames with spaces
find . -name "*.txt" -print0 | xargs -0 grep "pattern"

# Limit arguments per command
echo "a b c d" | xargs -n 2 echo

# Prompt before execution
echo "file1 file2" | xargs -p rm

# Parallel execution
find . -name "*.c" | xargs -P 4 -I {} gcc -c {}

# Useful embedded examples
# Compile all C files
find . -name "*.c" | xargs gcc -o program

# Check all shell scripts
find . -name "*.sh" | xargs shellcheck

# Remove all object files
find . -name "*.o" | xargs rm -f
```

### 6. System and Process Commands

```bash
# System information
uname -a                  # All system info
hostname                  # Machine name
uptime                    # System uptime
free -h                   # Memory usage
df -h                     # Disk usage
lsblk                     # Block devices
lscpu                     # CPU info
lsusb                     # USB devices
lspci                     # PCI devices

# Process management
ps aux                    # All processes
ps -ef                    # Full format
top                       # Interactive process viewer
htop                      # Better top (if installed)
kill <PID>               # Terminate process
kill -9 <PID>            # Force kill
killall process_name     # Kill by name
pgrep process_name       # Find PID by name
pkill process_name       # Kill by name (pattern)

# Background jobs
command &                 # Run in background
jobs                      # List background jobs
fg %1                     # Bring job 1 to foreground
bg %1                     # Continue job 1 in background
nohup command &          # Run immune to hangups
```

### 7. Essential Networking Commands

```bash
# Network configuration
ip addr                   # Show IP addresses
ip link                   # Show network interfaces
ip route                  # Show routing table

# Legacy commands (still useful)
ifconfig                  # Network interfaces
netstat -tuln            # Listening ports
netstat -an              # All connections

# Modern alternatives
ss -tuln                 # Listening ports (faster)

# Testing connectivity
ping -c 4 host           # Ping 4 times
traceroute host          # Trace packet route
curl -I http://example.com  # HTTP headers
wget http://example.com/file  # Download file

# DNS
nslookup domain.com
dig domain.com
host domain.com

# File transfer
scp file user@host:/path
rsync -avz src/ dest/
```

---

## 💻 Hands-On Practice

### Exercise 1: Log Analysis
```bash
# Find all error messages in system log
grep -i "error" /var/log/syslog | tail -20

# Count occurrences of each error type
grep -i "error" /var/log/syslog | awk '{print $5}' | sort | uniq -c | sort -rn
```

### Exercise 2: Find and Process Files
```bash
# Find all C source files larger than 10KB, modified in last 30 days
find /usr/src -name "*.c" -size +10k -mtime -30 2>/dev/null | head -10

# Count lines in all C files in a directory
find . -name "*.c" -exec wc -l {} + | tail -1
```

### Exercise 3: Text Processing Pipeline
```bash
# Extract usernames from /etc/passwd who have bash shell
grep "/bin/bash$" /etc/passwd | cut -d: -f1

# Using awk
awk -F: '/\/bin\/bash$/ {print $1}' /etc/passwd
```

---

## 🔑 Key Takeaways

1. **Pipes are your best friend** - Combine simple commands for powerful data processing

2. **Master grep, sed, awk** - These three tools can handle almost any text processing task

3. **find + xargs = powerful automation** - Search and process files efficiently

4. **Redirect wisely** - Know the difference between `>` (overwrite) and `>>` (append)

5. **Use command chaining** - `&&` and `||` for conditional execution

---

## 📎 References

- [GNU Coreutils Manual](https://www.gnu.org/software/coreutils/manual/)
- [Bash Reference Manual](https://www.gnu.org/software/bash/manual/)
- [The Linux Command Line](https://linuxcommand.org/tlcl.php) - William Shotts
- `man bash` - Comprehensive bash documentation

---

## 🔗 Related Notes

- [03_shell_scripting.md](03_shell_scripting.md) - Automate with shell scripts
- [08_networking_basics.md](08_networking_basics.md) - Deeper networking coverage
