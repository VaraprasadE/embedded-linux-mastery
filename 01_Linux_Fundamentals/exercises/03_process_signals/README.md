# Exercise Module 03: Process & Signals

## 🎯 Objective

Understand process management and signal handling through hands-on practice.

---

## Exercises

### Exercise 1: Process Exploration

Explore your current shell process:

```bash
# Your shell PID
echo "Shell PID: $$"

# Explore /proc
cat /proc/$$/status | grep -E "Name|Pid|PPid|State"
ls -la /proc/$$/fd
cat /proc/$$/cmdline
```

**Task:** Find your shell's parent process and trace back to PID 1.

---

### Exercise 2: Background Processes

```bash
# Start background job
sleep 300 &
echo "Background PID: $!"

# List jobs
jobs -l

# Bring to foreground
fg %1

# Send to background (Ctrl+Z first)
bg %1
```

---

### Exercise 3: Signal Sending

```bash
# Start a process
sleep 1000 &
PID=$!

# Send signals
kill -SIGSTOP $PID    # Pause
ps -p $PID -o state   # Check state (T = stopped)

kill -SIGCONT $PID    # Resume
ps -p $PID -o state   # Check state (S = sleeping)

kill -SIGTERM $PID    # Terminate
```

---

### Exercise 4: Process Monitoring

```bash
# Real-time monitoring
top -d 1

# Specific process
watch -n 1 'ps -p $$ -o pid,ppid,%cpu,%mem,state,cmd'

# Process tree
pstree -p $$
```

---

### Exercise 5: Simple C Program (Signal Handler)

Create and compile:

```c
// signal_demo.c
#include <stdio.h>
#include <signal.h>
#include <unistd.h>

volatile int running = 1;

void handler(int sig) {
    printf("\nReceived signal %d\n", sig);
    running = 0;
}

int main() {
    signal(SIGINT, handler);
    printf("PID: %d - Press Ctrl+C to stop\n", getpid());
    while(running) { sleep(1); printf("."); fflush(stdout); }
    printf("Exiting cleanly.\n");
    return 0;
}
```

```bash
gcc signal_demo.c -o signal_demo
./signal_demo
# Press Ctrl+C
```

---

## ✅ Self-Assessment

- [ ] Can find process information in /proc
- [ ] Understand foreground/background jobs
- [ ] Can send signals to processes
- [ ] Know common signals (SIGINT, SIGTERM, SIGKILL)
