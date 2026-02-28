#!/bin/bash
# SQL MACHINE

sudo apt update
sudo apt install -y curl

# configure netplan stuff
curl https://raw.githubusercontent.com/rubys2-333/s26_testbed_research/refs/heads/main/sql-00-installer-config.yaml -o 00-installer-config.yaml
sudo mv 00-installer-config.yaml /etc/netplan/
sudo netplan apply

# now for the mysql server
sudo apt install -y mysql-server
sudo mysql <<EOF
CREATE DATABASE IF NOT EXISTS users;
USE users;
CREATE TABLE IF NOT EXISTS users (id INT AUTO_INCREMENT PRIMARY KEY, username VARCHAR(100), password VARCHAR(100));
INSERT INTO users (username, password) VALUES ('admin', 'password');

CREATE USER IF NOT EXISTS 'flask'@'192.168.56.10' IDENTIFIED BY 'sudo';
GRANT ALL PRIVILEGES ON users.* TO 'flask'@'192.168.56.10';
FLUSH PRIVILEGES;
EOF

# change config
sudo sed -i 's/^bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql

sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow from 192.168.56.10 to any port 3306
sudo ufw enable
