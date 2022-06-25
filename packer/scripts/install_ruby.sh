#!/bin/bash
sudo apt update
echo "wait 1m install updates"; sleep 1m; echo "now install ruby"
sudo apt install -y ruby-full ruby-bundler build-essential
