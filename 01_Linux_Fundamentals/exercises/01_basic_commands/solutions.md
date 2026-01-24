# Exercise 01: Solutions & Explanation

## Exercise 1: Navigation & File Operations

```bash
# Create complete structure in one command
mkdir -p linux_practice/{projects/{embedded,scripts},docs,backup}
touch linux_practice/docs/readme.txt

# Verify with tree (if installed) or ls
tree linux_practice/
# Output:
# linux_practice/
# ├── backup
# ├── docs
# │   └── readme.txt
# └── projects
#     ├── embedded
#     └── scripts
```

**Key Concepts:**
- `mkdir -p` creates parent directories as needed
- Brace expansion `{a,b,c}` creates multiple directories

---

## Exercise 2: File Content Manipulation

```bash
# Multi-line with heredoc (cleaner approach)
cat > sysinfo.txt << EOF
System Information Report
========================

Date: $(date)
User: $(whoami)
Hostname: $(hostname)
Kernel: $(uname -r)
Uptime: $(uptime -p)
EOF
```

**Key Concepts:**
- `>` overwrites, `>>` appends
- `$()` for command substitution
- heredoc for multi-line content

---

## Exercise 3-4: Expected Outputs

Find commands and pipelines are self-explanatory. Key learnings:
- `find` searches directory trees
- Pipes (`|`) connect command output to input
- `cut`, `sort`, `uniq` for text processing

---

## Exercise 5: grep patterns

**Pattern Matching Tips:**
- `-E` enables extended regex
- `\|` for OR in basic grep, `|` in extended
- `-c` counts, `-n` shows line numbers

---

## Common Mistakes to Avoid

1. **Forgetting quotes around variables:**
   ```bash
   # Wrong (breaks on spaces)
   file=my file.txt
   cat $file
   
   # Correct
   file="my file.txt"
   cat "$file"
   ```

2. **Using `>` when you mean `>>`:**
   ```bash
   # Overwrites!
   echo "new" > file.txt
   
   # Appends
   echo "new" >> file.txt
   ```

3. **Not handling errors:**
   ```bash
   # Hides errors but not recommended for debugging
   command 2>/dev/null
   ```
