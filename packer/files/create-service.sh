#!/bin/bash
sudo cp -f /tmp/reddit.service /etc/systemd/system/reddit.service
sleep 30
sudo systemctl daemon-reload
sleep 15
sudo systemctl enable reddit.service
sudo systemctl start reddit.service
