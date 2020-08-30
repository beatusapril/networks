#!/bin/sh
#Emty all rules
sudo iptables -t filter -F
sudo iptables -t filter -X
sudo iptables -t nat -F
sudo iptables -t mangle -F

# Add new rules for snat
sudo iptables -t nat -A POSTROUTING -o enp0s3 -j MASQUERADE
sudo iptables -A FORWARD -i enp0s3 -o enp0s8 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i enp0s8 -o enp0s3 -j ACCEPT
sudo iptables -t nat -A POSTROUTING -s 192.168.0.2  -j SNAT --to-source 192.168.43.1
sudo iptables -A FORWARD  -j REJECT
