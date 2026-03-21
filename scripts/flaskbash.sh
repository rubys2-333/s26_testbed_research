#!/bin/bash
# FLASK MACHINE

sudo apt update
sudo apt install -y curl

# configure netplan stuff
curl https://raw.githubusercontent.com/rubys2-333/s26_testbed_research/refs/heads/main/flask-00-installer-config.yaml -o 00-installer-config.yaml
sudo mv 00-installer-config.yaml /etc/netplan/
sudo netplan apply

# install app.py dependencies
sudo apt install -y python3-pip
pip install flask
pip install mysql-connector-python 

# install app.py and run
curl https://raw.githubusercontent.com/rubys2-333/s26_testbed_research/refs/heads/main/app.py -o app.py
python3 -m flask run
