# Learning Notes: Networking Basics

> **Date**: 2026-01-24  
> **Module**: 01_Linux_Fundamentals  
> **Focus**: IP Configuration, Sockets, and Network Tools

---

## 📚 Topic Overview

Networking knowledge is essential for embedded Linux - from configuring network interfaces to debugging communication issues in IoT devices.

---

## 🎯 Learning Objectives

- [x] Configure network interfaces with ip command
- [x] Understand socket basics
- [x] Master network debugging tools

---

## 📝 Notes

### 1. Network Configuration

```bash
# Show IP addresses
ip addr show
ip a                    # Short form

# Show specific interface
ip addr show eth0

# Assign IP address
sudo ip addr add 192.168.1.100/24 dev eth0
sudo ip addr del 192.168.1.100/24 dev eth0

# Bring interface up/down
sudo ip link set eth0 up
sudo ip link set eth0 down

# Show routing table
ip route show
ip r

# Add default gateway
sudo ip route add default via 192.168.1.1

# DNS configuration
cat /etc/resolv.conf
```

### 2. Legacy Commands Reference

```bash
# ifconfig (older, but still useful)
ifconfig
ifconfig eth0

# netstat (use 'ss' instead)
netstat -tuln          # Listening ports
netstat -an            # All connections

# route (use 'ip route' instead)
route -n
```

### 3. Modern Tools

```bash
# ss - socket statistics (faster than netstat)
ss -tuln               # TCP/UDP listening ports
ss -tp                 # TCP connections with process info
ss -s                  # Summary statistics

# NetworkManager CLI
nmcli device status
nmcli connection show
nmcli device wifi list
```

### 4. Debugging Tools

```bash
# Connectivity testing
ping -c 4 8.8.8.8
ping -c 4 google.com

# Trace route
traceroute google.com
mtr google.com         # Interactive

# DNS lookup
nslookup google.com
dig google.com
host google.com

# Port connectivity
nc -zv host 80         # Check port
telnet host 80         # Interactive

# HTTP testing
curl -I https://google.com
wget --spider https://google.com
```

### 5. Packet Analysis

```bash
# tcpdump - packet capture
sudo tcpdump -i eth0
sudo tcpdump -i eth0 port 80
sudo tcpdump -i eth0 -w capture.pcap
sudo tcpdump -i any icmp

# View ARP cache
ip neigh show
arp -a
```

### 6. Socket Programming Basics

```c
// Simple TCP client
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

int sock = socket(AF_INET, SOCK_STREAM, 0);

struct sockaddr_in addr;
addr.sin_family = AF_INET;
addr.sin_port = htons(80);
inet_pton(AF_INET, "1.2.3.4", &addr.sin_addr);

connect(sock, (struct sockaddr*)&addr, sizeof(addr));
send(sock, "GET / HTTP/1.0\r\n\r\n", 18, 0);
```

### 7. Embedded Networking

```bash
# Serial port for console
picocom -b 115200 /dev/ttyUSB0
screen /dev/ttyUSB0 115200

# USB Ethernet gadget configuration
# /etc/network/interfaces
# auto usb0
# iface usb0 inet static
#     address 192.168.7.2
#     netmask 255.255.255.0

# Static IP for embedded device
# /etc/systemd/network/eth0.network
# [Match]
# Name=eth0
# [Network]
# Address=192.168.1.100/24
# Gateway=192.168.1.1
```

---

## 💻 Hands-On Practice

```bash
# Check your network configuration
ip addr
ip route
cat /etc/resolv.conf

# Test connectivity
ping -c 4 8.8.8.8

# Check open ports
ss -tuln

# Capture packets (briefly)
sudo tcpdump -i any -c 10
```

---

## 🔑 Key Takeaways

1. **ip** command replaces ifconfig, route
2. **ss** is the modern replacement for netstat
3. **tcpdump** essential for embedded debug
4. Know both static config and DHCP

---

## 📎 References

- `man ip`, `man ss`, `man tcpdump`
- [Beej's Guide to Network Programming](https://beej.us/guide/bgnet/)
