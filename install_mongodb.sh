#!/bin/bash

echo 'Acquire::http::Proxy "http://200.137.134.131:3128/";' | sudo tee -a /etc/apt/apt.conf.d/proxy.conf
echo 'Acquire::https::Proxy "http://200.137.134.131:3128/";' | sudo tee -a /etc/apt/apt.conf.d/proxy.conf

wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
sudo apt update
sudo apt-get install -y mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod
