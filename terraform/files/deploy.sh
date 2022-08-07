#!/bin/bash
set -e
APP_DIR=${1:-$HOME}
sleep 30
echo '' | sudo tee /etc/apt/apt.conf.d/proxy.conf
sudo apt update && apt install git --fix-missing
git clone -b monolith https://github.com/express42/reddit.git $APP_DIR/reddit
cd $APP_DIR/reddit
bundle install
sudo mv /tmp/puma.service /etc/systemd/system/puma.service
sudo systemctl start puma
sudo systemctl enable puma
