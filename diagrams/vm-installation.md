# VirtualBox VM Installation Guide

## Part 1: VirtualBox VM Settings
When creating a new VM, use these exact specs for the best experience:

- System: 8 Cores, 8 GB RAM, Enable EFI.
- Storage: 30 GB (Dynamically Allocated).
- Display: Graphics Controller = VMSVGA, Video Memory = 128 MB, Enable 3D Acceleration.
- Network: Adapter 1 = NAT. Go to Port Forwarding:
  - Name: ssh, Protocol: TCP, Host Port: 2222, Guest Port: 22.
- Shared Folders: Add your Windows path. Name it shared. Check Auto-mount and Make Permanent.

## Part 2: The "First Boot" Ubuntu Commands
Once you log into the Ubuntu Server console for the first time, run this single block to install everything:

```bash
# 1. Update and install the core toolchain
sudo apt update && sudo apt upgrade -y
sudo apt install -y build-essential linux-headers-$(uname -r) kmod git tmux openssh-server virtualbox-guest-utils

# 2. Give your user permission to see the Shared Folder
sudo usermod -aG vboxsf $USER

# 3. Create a shortcut to your Windows files in your home directory
ln -s /media/sf_shared ~/win_files

# 4. Reboot to apply all group and driver changes
sudo reboot
```

## Part 3: The Daily Workflow (The "Pro" Way)
Don't use the VirtualBox window to type. Use your Windows PowerShell/Terminal:

Connect via SSH:

```powershell
ssh -p 2222 your_username@127.0.0.1
```

Use code with caution.

Open Multiple Windows: Just run the SSH command again in a new tab for each window you need (Logs, Editor, Compiler).

Transfer Files: Use scp for quick moves:

```powershell
scp -P 2222 your_file.c your_username@127.0.0.1:~/
```

## Part 4: Your First "Driver Check"
To make sure you are 100% ready to code, run these three checks:

- Compiler: gcc --version (Should be 15.x)
- Headers: ls /lib/modules/$(uname -r)/build (Should show files, not be empty)
- Shared Folder: ls ~/win_files (Should show your Windows files)

You're officially ready to start writing code!
