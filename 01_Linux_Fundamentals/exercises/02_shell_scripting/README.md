# Exercise Module 02: Shell Scripting

## 🎯 Objective

Write practical shell scripts for embedded Linux development. Each exercise builds on previous skills.

---

## Exercises

### Exercise 1: System Health Check Script

**Task**: Create a script that displays system health information.

**Requirements:**
- Display date/time, hostname, uptime
- Show memory usage (with percentage)
- Show disk usage for root partition
- Show number of running processes
- Use colors for better readability

**Starter:** `starter_scripts/system_health.sh`

---

### Exercise 2: Backup Script

**Task**: Create a script that backs up a directory.

**Requirements:**
- Accept source and destination as arguments
- Create timestamped backup archive (.tar.gz)
- Validate inputs before backup
- Show backup size after completion

---

### Exercise 3: Log Analyzer

**Task**: Create a script that analyzes log files.

**Requirements:**
- Accept log file path as argument
- Count occurrences of ERROR, WARNING, INFO
- Display summary statistics
- Optionally filter by date range

---

### Exercise 4: Device Monitor

**Task**: Create a script for monitoring devices (embedded focus).

**Requirements:**
- Check if specific devices exist in /dev
- Monitor USB device connections
- Log status changes to file
- Support running in background

---

### Exercise 5: Build Automation

**Task**: Create a build script for a C project.

**Requirements:**
- Accept target (debug/release) as argument
- Support clean, build, and install targets
- Handle cross-compilation option
- Display colored status messages

---

## 📁 Starter Scripts

Check `starter_scripts/` for templates to get started.

---

## ✅ Self-Assessment

- [ ] Can write properly structured scripts with `set -e`
- [ ] Can parse command-line arguments
- [ ] Can use functions for code organization
- [ ] Can implement proper error handling
- [ ] Can use colors and formatting

---

## 📎 Solutions

See `solutions/` directory for complete implementations.
