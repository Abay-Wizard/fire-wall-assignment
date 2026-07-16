# Backend Firewall Script (iptables)

This script hardens the backend web server by dropping all incoming traffic except for SSH (Port 22) and HTTP (Port 80) traffic originating exclusively from the Load Balancer.

## Configuration
Before running, open `setup_firewall.sh` and set your load balancer's IP:
```bash
LOAD_BALANCER_IP="172.25.0.10"
