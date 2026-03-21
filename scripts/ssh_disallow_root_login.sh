SSHDPATH="/etc/ssh/sshd_config"

sudo sed -i 's/^#PermitRootLogin/PermitRootLogin/' $SSHDPATH
sudo sed -i 's/^PermitRootLogin .*/PermitRootLogin no/' $SSHDPATH

sudo systemctl restart ssh