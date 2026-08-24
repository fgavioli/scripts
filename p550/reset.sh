#!/usr/bin/env bash
set -euo pipefail

echo "sompower-s 0" > /dev/ttyUSB3
sleep 5
echo "sompower-s 1" > /dev/ttyUSB3
sleep 10
echo "" > /dev/ttyUSB2