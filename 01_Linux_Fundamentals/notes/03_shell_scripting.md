# Learning Notes: Shell Scripting

> **Date**: 2026-01-24  
> **Module**: 01_Linux_Fundamentals  
> **Focus**: Bash Scripting for Embedded Linux Automation

---

## 📚 Topic Overview

Shell scripting is essential for automating tasks in embedded Linux development - from build automation to device configuration and system monitoring. This module covers Bash scripting fundamentals with practical examples.

---

## 🎯 Learning Objectives

- [x] Write properly structured shell scripts
- [x] Use variables, arrays, and command substitution
- [x] Implement control structures (if, case, loops)
- [x] Create and use functions
- [x] Handle command-line arguments
- [x] Apply best practices and error handling

---

## 📝 Notes

### 1. Script Basics

#### Script Structure
```bash
#!/bin/bash
#
# Script: script_name.sh
# Description: What this script does
# Author: Varaprasad
# Date: 2026-01-24
#

set -e          # Exit immediately on error
set -u          # Treat unset variables as errors
set -o pipefail # Catch errors in pipelines

# Your code here
```

#### Making Scripts Executable
```bash
# Add execute permission
chmod +x script.sh

# Run the script
./script.sh

# Or explicitly with bash
bash script.sh
```

### 2. Variables

#### Basic Variables
```bash
# Assignment (no spaces around =)
name="Embedded Linux"
count=42

# Using variables
echo "Project: $name"
echo "Count is: ${count}"

# Curly braces for clarity
file="${name}_project.txt"

# Read-only variables
readonly PI=3.14159

# Unset a variable
unset count
```

#### Special Variables
```bash
$0      # Script name
$1-$9   # Positional parameters
$#      # Number of arguments
$@      # All arguments (as separate words)
$*      # All arguments (as single word)
$?      # Exit status of last command
$$      # Current process ID
$!      # PID of last background command
```

#### Command Substitution
```bash
# Modern syntax (preferred)
current_date=$(date +%Y-%m-%d)
kernel_version=$(uname -r)
file_count=$(ls -1 | wc -l)

# Legacy syntax (backticks)
current_date=`date +%Y-%m-%d`

# Nested substitution
files_size=$(du -sh $(find . -name "*.c") 2>/dev/null)
```

#### Arrays
```bash
# Indexed arrays
fruits=("apple" "banana" "cherry")
echo ${fruits[0]}          # First element
echo ${fruits[@]}          # All elements
echo ${#fruits[@]}         # Array length

# Add elements
fruits+=("date")

# Loop through array
for fruit in "${fruits[@]}"; do
    echo "$fruit"
done

# Associative arrays (Bash 4+)
declare -A config
config[ip]="192.168.1.1"
config[port]="8080"
echo ${config[ip]}
```

### 3. Control Structures

#### If Statements
```bash
# Basic if
if [ condition ]; then
    commands
fi

# If-else
if [ condition ]; then
    commands
else
    other_commands
fi

# If-elif-else
if [ condition1 ]; then
    commands
elif [ condition2 ]; then
    other_commands
else
    default_commands
fi
```

#### Test Conditions
```bash
# String comparisons
[ "$str1" = "$str2" ]    # Equal
[ "$str1" != "$str2" ]   # Not equal
[ -z "$str" ]            # Empty string
[ -n "$str" ]            # Non-empty string

# Numeric comparisons
[ "$a" -eq "$b" ]        # Equal
[ "$a" -ne "$b" ]        # Not equal
[ "$a" -lt "$b" ]        # Less than
[ "$a" -le "$b" ]        # Less than or equal
[ "$a" -gt "$b" ]        # Greater than
[ "$a" -ge "$b" ]        # Greater than or equal

# File tests
[ -e "$file" ]           # Exists
[ -f "$file" ]           # Is regular file
[ -d "$path" ]           # Is directory
[ -r "$file" ]           # Is readable
[ -w "$file" ]           # Is writable
[ -x "$file" ]           # Is executable
[ -s "$file" ]           # Size > 0
[ -L "$file" ]           # Is symbolic link

# Logical operators
[ cond1 ] && [ cond2 ]   # AND
[ cond1 ] || [ cond2 ]   # OR
[ ! condition ]          # NOT

# Modern test syntax [[ ]] (preferred in Bash)
[[ "$str" == pattern* ]] # Pattern matching
[[ "$str" =~ regex ]]    # Regex matching
```

#### Case Statement
```bash
case "$variable" in
    pattern1)
        commands
        ;;
    pattern2|pattern3)
        commands
        ;;
    *)
        default_commands
        ;;
esac

# Example: Command handler
case "$1" in
    start)
        echo "Starting service..."
        ;;
    stop)
        echo "Stopping service..."
        ;;
    restart)
        echo "Restarting service..."
        ;;
    status)
        echo "Service status..."
        ;;
    *)
        echo "Usage: $0 {start|stop|restart|status}"
        exit 1
        ;;
esac
```

#### Loops

**For Loops:**
```bash
# Iterate over list
for item in apple banana cherry; do
    echo "$item"
done

# Iterate over array
for item in "${array[@]}"; do
    echo "$item"
done

# Iterate over files
for file in *.c; do
    echo "Processing: $file"
done

# C-style for loop
for ((i=0; i<10; i++)); do
    echo "Iteration: $i"
done

# Iterate over command output
for user in $(cat /etc/passwd | cut -d: -f1); do
    echo "User: $user"
done
```

**While Loops:**
```bash
# Basic while
count=0
while [ $count -lt 5 ]; do
    echo "Count: $count"
    ((count++))
done

# Read file line by line
while IFS= read -r line; do
    echo "$line"
done < input.txt

# Infinite loop with break
while true; do
    read -p "Enter command (quit to exit): " cmd
    if [ "$cmd" = "quit" ]; then
        break
    fi
    echo "Executing: $cmd"
done
```

**Until Loops:**
```bash
# Run until condition is true
count=0
until [ $count -ge 5 ]; do
    echo "Count: $count"
    ((count++))
done
```

### 4. Functions

#### Function Definition
```bash
# Method 1
function my_function {
    echo "Hello from function"
}

# Method 2 (POSIX compatible)
my_function() {
    echo "Hello from function"
}

# Call function
my_function
```

#### Function Arguments and Return Values
```bash
# Function with arguments
greet() {
    local name="$1"    # Local variable
    local age="$2"
    echo "Hello, $name! You are $age years old."
}

greet "Varaprasad" 30

# Return values (exit status: 0-255)
check_file() {
    if [ -f "$1" ]; then
        return 0   # Success
    else
        return 1   # Failure
    fi
}

if check_file "/etc/passwd"; then
    echo "File exists"
fi

# Return string values via stdout
get_uptime() {
    cat /proc/uptime | cut -d' ' -f1
}

uptime_seconds=$(get_uptime)
echo "Uptime: $uptime_seconds seconds"
```

#### Practical Function Example
```bash
#!/bin/bash
# Logging functions for embedded scripts

LOG_FILE="/var/log/myapp.log"

log_info() {
    local message="$1"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [INFO] $message" | tee -a "$LOG_FILE"
}

log_error() {
    local message="$1"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [ERROR] $message" | tee -a "$LOG_FILE" >&2
}

log_debug() {
    if [ "${DEBUG:-0}" -eq 1 ]; then
        local message="$1"
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] [DEBUG] $message" | tee -a "$LOG_FILE"
    fi
}

# Usage
log_info "Application started"
log_error "Failed to connect to device"
DEBUG=1 log_debug "Variable value: $var"
```

### 5. Command-Line Arguments

#### Parsing Arguments
```bash
#!/bin/bash
# Script with argument handling

# Simple positional arguments
echo "Script name: $0"
echo "First argument: $1"
echo "All arguments: $@"

# Shift through arguments
while [ $# -gt 0 ]; do
    echo "Processing: $1"
    shift
done
```

#### Using getopts
```bash
#!/bin/bash
# Parse options with getopts

usage() {
    echo "Usage: $0 [-h] [-v] [-f file] [-n count]"
    echo "  -h        Show help"
    echo "  -v        Verbose mode"
    echo "  -f file   Input file"
    echo "  -n count  Number of iterations"
    exit 1
}

# Default values
verbose=0
input_file=""
count=1

while getopts "hvf:n:" opt; do
    case $opt in
        h) usage ;;
        v) verbose=1 ;;
        f) input_file="$OPTARG" ;;
        n) count="$OPTARG" ;;
        ?) usage ;;
    esac
done

# Shift past processed options
shift $((OPTIND - 1))

# Remaining arguments
echo "Verbose: $verbose"
echo "Input file: $input_file"
echo "Count: $count"
echo "Remaining args: $@"
```

### 6. Error Handling and Best Practices

#### Error Handling
```bash
#!/bin/bash
set -e          # Exit on error
set -u          # Error on undefined variables
set -o pipefail # Catch pipe errors

# Trap for cleanup
cleanup() {
    echo "Cleaning up..."
    rm -f "$temp_file"
}
trap cleanup EXIT

# Check command success
if ! command -v gcc &> /dev/null; then
    echo "Error: gcc not found" >&2
    exit 1
fi

# Handle errors gracefully
do_something() {
    command_that_might_fail || {
        echo "Error: command failed" >&2
        return 1
    }
}
```

#### Best Practices
```bash
#!/bin/bash
#
# Best practices example
#

# 1. Always quote variables
file="my file.txt"
cat "$file"                    # Correct
# cat $file                    # Wrong - breaks on spaces

# 2. Use [[ ]] instead of [ ] in Bash
if [[ "$string" == pattern* ]]; then
    echo "Match"
fi

# 3. Use local variables in functions
my_func() {
    local var="value"          # Won't pollute global scope
}

# 4. Check if running as root when needed
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" >&2
    exit 1
fi

# 5. Validate inputs
if [[ -z "${1:-}" ]]; then
    echo "Usage: $0 <argument>" >&2
    exit 1
fi

# 6. Use meaningful exit codes
EXIT_SUCCESS=0
EXIT_ERROR=1
EXIT_USAGE=2

# 7. Use printf for complex output
printf "%-20s %10d\n" "Total files" "$count"
```

---

## 💻 Hands-On Practice

### Exercise 1: System Info Script
```bash
#!/bin/bash
# Create a script that displays formatted system information

echo "=== System Information ==="
echo "Hostname: $(hostname)"
echo "Kernel: $(uname -r)"
echo "Uptime: $(uptime -p)"
echo "Memory: $(free -h | awk '/Mem:/ {print $3 "/" $2}')"
echo "Disk: $(df -h / | awk 'NR==2 {print $3 "/" $2}')"
```

### Exercise 2: File Counter
```bash
#!/bin/bash
# Count files by extension in a directory

dir="${1:-.}"
echo "File counts in: $dir"
echo "===================="

for ext in c h sh txt md; do
    count=$(find "$dir" -name "*.$ext" 2>/dev/null | wc -l)
    printf ".%-5s : %d\n" "$ext" "$count"
done
```

---

## 🔑 Key Takeaways

1. **Always use `set -e -u -o pipefail`** at script start for robust error handling

2. **Quote your variables** - `"$var"` prevents word splitting and glob expansion

3. **Use functions** to organize code and enable reuse

4. **Validate inputs** - check arguments exist before using them

5. **Use `local`** for function variables to avoid polluting global scope

6. **Prefer `[[ ]]`** over `[ ]` for more powerful conditions in Bash

---

## 📎 References

- [Bash Reference Manual](https://www.gnu.org/software/bash/manual/)
- [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html)
- [ShellCheck](https://www.shellcheck.net/) - Script analyzer
- [Advanced Bash Scripting Guide](https://tldp.org/LDP/abs/html/)

---

## 🔗 Related Notes

- [02_command_line.md](02_command_line.md) - Command line fundamentals
- [../scripts/](../scripts/) - Practice scripts
