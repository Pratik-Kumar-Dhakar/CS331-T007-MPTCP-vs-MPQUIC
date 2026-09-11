#!/bin/bash

echo "--------------------------------"
echo "Checking MPTCP setup..."
echo "--------------------------------"

echo "Checking Kernel version"
uname -r

echo
echo "Checking MPTCP support"
if [ -f /proc/sys/net/mptcp/enabled ]; then
    echo "net.mptcp.enabled = $(cat /proc/sys/net/mptcp/enabled)"
else
    echo "MPTCP sysctl not found"
fi

echo 
echo "Checking iproute2 version"
ip -V

echo
echo "MPTCP commands"
ip mptcp

echo 
echo "MPTCP limits"
sudo ip mptcp limits

echo
echo "MPTCP endpoints"
sudo ip mptcp endpoint show

echo 
echo "MPTCP sockets"
sudo ss -M

echo
echo "--------------------------------"
echo "Check completed"
echo "--------------------------------"