# Scripts

Shell scripts for embedded Linux development.

## 📚 Available Scripts

### System (`system/`)
| Script | Description |
|--------|-------------|
| `system_info.sh` | Comprehensive system information display |
| `proc_monitor.sh` | Process monitoring with PID/name options |
| `mem_analyzer.sh` | Memory usage analysis |

### Filesystem (`filesystem/`)
| Script | Description |
|--------|-------------|
| `fs_explorer.sh` | Explore filesystem hierarchy |
| `dev_lister.sh` | List and categorize /dev devices |
| `mount_info.sh` | Display mount point information |

### Network (`network/`)
| Script | Description |
|--------|-------------|
| `net_config.sh` | Display network configuration |
| `port_scanner.sh` | Simple port scanner |

### Utilities (`utils/`)
| Script | Description |
|--------|-------------|
| `log_parser.sh` | Parse and analyze log files |
| `backup_config.sh` | Backup system configuration |

## 🚀 Usage

```bash
# Make executable
chmod +x system/system_info.sh

# Run
./system/system_info.sh

# Or with bash
bash system/system_info.sh
```

## 📝 Script Template

All scripts follow this structure:
```bash
#!/bin/bash
#
# Script: script_name.sh
# Description: What this script does
# Author: Varaprasad
# Date: YYYY-MM-DD
#

set -e          # Exit on error
set -u          # Error on undefined vars
set -o pipefail # Catch pipe errors

# Your code here
```

## 🎯 Best Practices

- Always use `set -e -u -o pipefail`
- Quote your variables: `"$var"`
- Use functions for organization
- Include usage/help messages
- Handle errors gracefully
