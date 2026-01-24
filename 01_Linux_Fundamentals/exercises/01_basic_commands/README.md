# Exercise Module 01: Basic Commands

## 🎯 Objective

Master essential Linux commands through hands-on practice. Complete all exercises to build command-line confidence.

---

## Prerequisites

- Linux environment (Ubuntu/WSL/VM)
- Terminal access
- Basic understanding of files and directories

---

## Exercises

### Exercise 1: Navigation & File Operations

**Task**: Create the following directory structure and files:

```
linux_practice/
├── projects/
│   ├── embedded/
│   └── scripts/
├── docs/
│   └── readme.txt
└── backup/
```

**Commands to practice:**
```bash
mkdir -p linux_practice/projects/embedded
mkdir -p linux_practice/projects/scripts
mkdir -p linux_practice/docs
mkdir -p linux_practice/backup
touch linux_practice/docs/readme.txt
```

**Verify:**
```bash
tree linux_practice/    # or ls -R linux_practice/
```

---

### Exercise 2: File Content Manipulation

**Task**: Create a file with your system information

```bash
# Create the file
cd linux_practice/docs
echo "System Information Report" > sysinfo.txt
echo "========================" >> sysinfo.txt
echo "" >> sysinfo.txt
echo "Date: $(date)" >> sysinfo.txt
echo "User: $(whoami)" >> sysinfo.txt
echo "Hostname: $(hostname)" >> sysinfo.txt
echo "Kernel: $(uname -r)" >> sysinfo.txt
echo "Uptime: $(uptime -p)" >> sysinfo.txt
```

**Verify:**
```bash
cat sysinfo.txt
```

---

### Exercise 3: Find Files

**Task**: Practice using `find` command

```bash
# Find all .txt files
find ~/linux_practice -name "*.txt"

# Find directories only
find ~/linux_practice -type d

# Find files modified in last 10 minutes
find ~/linux_practice -type f -mmin -10

# Find files larger than 0 bytes
find ~/linux_practice -type f -size +0c
```

---

### Exercise 4: Text Processing Pipeline

**Task**: Extract information from /etc/passwd

```bash
# Count total users
wc -l < /etc/passwd

# List users with bash shell
grep "/bin/bash$" /etc/passwd | cut -d: -f1

# Count users by shell type
cat /etc/passwd | cut -d: -f7 | sort | uniq -c | sort -rn
```

---

### Exercise 5: Search with grep

**Task**: Search for patterns in files

```bash
# Create test file
cat > ~/linux_practice/docs/log.txt << 'EOF'
2026-01-24 10:00:00 INFO Application started
2026-01-24 10:01:00 DEBUG Loading configuration
2026-01-24 10:02:00 ERROR Failed to connect
2026-01-24 10:03:00 INFO Retrying connection
2026-01-24 10:04:00 ERROR Connection timeout
2026-01-24 10:05:00 INFO Connected successfully
EOF

# Find all ERROR lines
grep "ERROR" ~/linux_practice/docs/log.txt

# Count ERROR occurrences
grep -c "ERROR" ~/linux_practice/docs/log.txt

# Show line numbers
grep -n "ERROR" ~/linux_practice/docs/log.txt

# Case-insensitive search
grep -i "error\|info" ~/linux_practice/docs/log.txt
```

---

### Exercise 6: Redirection Challenge

**Task**: Practice I/O redirection

```bash
# Separate stdout and stderr
find /etc -name "*.conf" 2>/dev/null | head -5

# Save output and errors to different files
find /etc -name "*.conf" > found.txt 2> errors.txt

# Append to existing file
echo "Additional line" >> ~/linux_practice/docs/sysinfo.txt

# Discard all output
find / -name "impossible" >/dev/null 2>&1
```

---

### Exercise 7: Process Information

**Task**: Explore process commands

```bash
# View your processes
ps aux | grep $USER

# Find process by name
pgrep -l bash

# View process tree
pstree -p $$

# Check resource usage
top -b -n 1 | head -20
```

---

### Exercise 8: Disk and Memory

**Task**: Check system resources

```bash
# Disk usage
df -h
du -sh ~/linux_practice

# Memory info
free -h
cat /proc/meminfo | grep -E "MemTotal|MemFree|MemAvailable"
```

---

### Exercise 9: Network Commands

**Task**: Explore network configuration

```bash
# Show IP addresses
ip addr show

# Show routing table
ip route

# Test connectivity
ping -c 3 8.8.8.8

# Check open ports
ss -tuln
```

---

### Exercise 10: Cleanup Challenge

**Task**: Clean up your practice directory

```bash
# Create some temporary files
touch ~/linux_practice/{file1,file2,file3}.tmp

# List them
ls ~/linux_practice/*.tmp

# Remove them
rm ~/linux_practice/*.tmp

# Verify removal
ls ~/linux_practice/*.tmp 2>/dev/null || echo "All tmp files removed!"
```

---

## ✅ Self-Assessment Checklist

- [ ] Can navigate directories with `cd`, `pwd`
- [ ] Can create files and directories with `touch`, `mkdir`
- [ ] Can view file contents with `cat`, `head`, `tail`, `less`
- [ ] Can search with `find` and `grep`
- [ ] Understand I/O redirection (`>`, `>>`, `2>`, `|`)
- [ ] Can monitor processes with `ps`, `top`
- [ ] Can check system resources with `df`, `free`

---

## 📎 Next Steps

- [02_shell_scripting](../02_shell_scripting/) - Automate these tasks with scripts
