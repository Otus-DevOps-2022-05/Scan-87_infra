#!/bin/bash
sudo apt install git -y
sudo mkdir /app && cd /app
sudo git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
