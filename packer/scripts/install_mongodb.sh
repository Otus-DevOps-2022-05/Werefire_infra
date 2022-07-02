#!/bin/bash
sudo apt-get update
while pgrep -a apt; do echo 'w8 apt-get update'; sleep 1m; done
sudo apt-get install -y mongodb
sudo systemctl start mongodb
sudo systemctl enable mongodb
