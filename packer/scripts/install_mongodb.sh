#!/bin/bash
echo 'Acquire::http::Proxy "http://de_squid:QNJDTdgFWRslsl7YxOdN5lUI@157.90.14.165:3128/";' | tee -a /etc/apt/apt.conf.d/proxy.conf
echo 'Acquire::https::Proxy "http://de_squid:QNJDTdgFWRslsl7YxOdN5lUI@157.90.14.165:3128/";' | tee -a /etc/apt/apt.conf.d/proxy.conf

wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.2.list
sleep 10
apt-get update
sleep 45
apt-get install -y mongodb-org
sleep 120
systemctl start mongod
systemctl enable mongod
