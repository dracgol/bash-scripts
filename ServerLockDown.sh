#!/bin/bash
#
# iptables config script
#
# Flush all current rules from iptables
#
echo "Clearing old rules"
 iptables -F
#
echo "Adding new rules"
# Example rules
# Allow SSH connections on tcp port 22
 iptables -A INPUT -p tcp --dport 22 -j ACCEPT -m comment --comment "SSH"

# Set default policies for INPUT, FORWARD and OUTPUT chains
#
 iptables -P INPUT DROP
 iptables -P FORWARD DROP
 iptables -P OUTPUT ACCEPT
#
# Set access for localhost
#
 iptables -A INPUT -i lo -j ACCEPT
#
# Accept packets belonging to established and related connections
#
 iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
#
# Save settings
#
 /sbin/service iptables save
#
# List rules
#
 iptables -L -v
