#!/bin/bash

echo nameserver 127.0.0.53 | sudo tee /etc/resolv.conf > /dev/null
echo nameserver fd00::c:71f9 | sudo tee -a /etc/resolv.conf > /dev/null
sudo ip link delete wg0

