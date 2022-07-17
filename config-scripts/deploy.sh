#!/bin/bash
sudo apt install git -y
cd /opt
sudo git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
#puma -d
