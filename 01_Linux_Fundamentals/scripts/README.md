# Scripts

Shell scripts for embedded Linux development.

## Structure

```
scripts/
├── system/          # System info and monitoring
├── filesystem/      # Filesystem exploration
├── network/         # Network configuration
└── utils/           # General utilities
```

## Naming Convention

- Use lowercase with underscores: `system_info.sh`
- Start with descriptive prefix: `net_`, `fs_`, `proc_`
- Include `.sh` extension

## Template

```bash
#!/bin/bash
#
# Script: script_name.sh
# Description: Brief description of what this script does
# Author: Varaprasad
# Date: YYYY-MM-DD
#

set -e  # Exit on error

# Your code here
```
