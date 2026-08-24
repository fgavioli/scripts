#!/usr/bin/env bash
set -euo pipefail

echo "setenv serverip 192.168.188.132" > /dev/ttyUSB2
sleep 0.5
echo "setenv ipaddr 192.168.188.110" > /dev/ttyUSB2
sleep 0.5
echo "setenv gatewayip 192.168.188.132" > /dev/ttyUSB2
sleep 0.5
echo "setenv autostart no" > /dev/ttyUSB2
sleep 0.5
echo "tftpboot 0x88100000 boot.scr" > /dev/ttyUSB2
sleep 4
echo "source 0x88100000" > /dev/ttyUSB2
