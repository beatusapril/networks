#!/bin/sh
#Emty all rules
sudo iptables -t filter -F
sudo iptables -t filter -X

# Add new rules
sudo iptables -A FORWARD  -p icmp -s 192.168.0.1 -d 192.168.1.1 -j ACCEPT
sudo iptables -A FORWARD  -p tcp  -s 192.168.1.1 -d 192.168.0.1 --dport 8080  -j ACCEPT
sudo iptables -A FORWARD  -p icmp -s 192.168.1.1 -d 192.168.0.1 -j ACCEPT
sudo iptables -A FORWARD  -j REJECT
