#!/usr/bin/env bash

set -e
LOAD_BALANCER_IP="172.25.0.10" 

echo "=== Starting iptables firewall configuration ==="
echo "[1/6] Flushing old rules..."
sudo iptables -F
sudo iptables -X

echo "[2/6] Allowing established/related connections..."
sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

echo "[3/6] Allowing loopback traffic..."
sudo iptables -A INPUT -i lo -j ACCEPT

echo "[4/6] Allowing SSH (Port 22)..."
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT

echo "[5/6] Restricting Port 80 to Load Balancer ($LOAD_BALANCER_IP)..."
sudo iptables -A INPUT -p tcp -s "$LOAD_BALANCER_IP" --dport 80 -j ACCEPT

echo "[6/6] Setting default INPUT policy to DROP..."
sudo iptables -P INPUT DROP

echo "=== Firewall configuration applied successfully! ==="
echo "Active rules:"
sudo iptables -L -v -n