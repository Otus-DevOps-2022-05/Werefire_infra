#!/bin/bash
sudo apt update
while pgrep -a apt; do echo 'w8 apt-get update'; sleep 1m; done
sudo apt install -y ruby-full ruby-bundler build-essential
