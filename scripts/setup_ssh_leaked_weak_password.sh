# REQUIRES: OpenSSH
# OUTPUTS: a user who's credentials are compromised by leaking a mysql database setup in setup_mysql_leak_weak_password.sh
# this user can be used to log in to the computer with ssh.
USERNAME=mgebril
PASSWORD=sopmac6yelhsa

SSHDPATH="/etc/ssh/sshd_config"

# ensure password authentication is on
sudo sed -i 's/^#PasswordAuthentication/PasswordAuthentication/' $SSHDPATH
sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' $SSHDPATH

# add user to log in to
sudo useradd -m $USERNAME
sudo chpasswd <<< "$USERNAME:$PASSWORD"

# make sure ssh is allowed in firewall, in case it is enabled.
sudo ufw allow ssh

# restart ssh
sudo systemctl restart ssh
