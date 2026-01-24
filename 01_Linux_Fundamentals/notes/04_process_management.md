# Learning Notes: Process Management

> **Date**: 2026-01-24  
> **Module**: 01_Linux_Fundamentals  
> **Focus**: Processes, Threads, Signals, and Scheduling

---

## 📚 Topic Overview

Understanding process management is critical for embedded Linux development. This covers how Linux creates and manages processes, signals, and scheduling.

---

## 🎯 Learning Objectives

- [x] Understand process creation with fork() and exec()
- [x] Differentiate between processes and threads
- [x] Master signal handling mechanisms
- [x] Explore the /proc filesystem
- [x] Understand Linux scheduling

---

## 📝 Notes

### 1. Process Fundamentals

A process is an instance of a running program with its own:
- Address space, PID, open file descriptors, environment

**Process States:** CREATED → READY → RUNNING → BLOCKED → ZOMBIE

### 2. Process Creation: fork() and exec()

```c
#include <unistd.h>
#include <sys/wait.h>

int main() {
    pid_t pid = fork();
    
    if (pid == 0) {
        // Child process
        execvp("ls", (char *[]){"ls", "-la", NULL});
    } else if (pid > 0) {
        // Parent process
        int status;
        waitpid(pid, &status, 0);
    }
    return 0;
}
```

### 3. Process vs Threads

| Aspect | Process | Thread |
|--------|---------|--------|
| Memory | Separate | Shared |
| Creation | fork() - heavy | pthread_create() - light |
| Crash Impact | Isolated | May crash whole process |

### 4. Signals

| Signal | Description |
|--------|-------------|
| SIGINT (2) | Interrupt (Ctrl+C) |
| SIGKILL (9) | Kill (cannot be caught) |
| SIGTERM (15) | Termination request |
| SIGUSR1/2 | User-defined |

**Signal Handling:**
```c
#include <signal.h>

void handler(int sig) { /* handle */ }

int main() {
    signal(SIGINT, handler);
    // or use sigaction() for more control
}
```

**Shell Commands:**
```bash
kill -SIGTERM <PID>
kill -l              # List signals
```

### 5. The /proc Filesystem

```bash
/proc/<PID>/status    # Process status
/proc/<PID>/cmdline   # Command line
/proc/<PID>/fd/       # Open file descriptors
/proc/<PID>/maps      # Memory mappings

# Useful commands
cat /proc/<PID>/status | grep -E "VmRSS|VmSize"
ls -la /proc/<PID>/fd
```

### 6. Scheduling and Priorities

```bash
# Nice values: -20 (highest) to +19 (lowest)
nice -n 10 ./program
renice -n 5 -p <PID>

# Real-time scheduling
chrt -f 50 ./realtime_app    # SCHED_FIFO
taskset -c 0,1 ./program     # CPU affinity
```

---

## 💻 Hands-On Practice

```bash
# Explore your shell process
cat /proc/$$/status
ls -la /proc/$$/fd

# Monitor processes
ps aux | grep myapp
pstree -p
```

---

## 🔑 Key Takeaways

1. **fork() + exec()** is the pattern for spawning processes
2. **Signals** provide async process notification
3. **/proc** is essential for process debugging
4. **Nice values** control scheduling priority

---

## 📎 References

- `man fork`, `man signal`, `man sched`
- [The Linux Programming Interface](https://man7.org/tlpi/)
