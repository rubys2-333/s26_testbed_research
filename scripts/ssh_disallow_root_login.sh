SSHDPATH="/etc/ssh/sshd_config"

sed -i 's/^#PermitRootLogin/PermitRootLogin/' $SSHDPATH
sed -i 's/^PermitRootLogin .*/PermitRootLogin no/' $SSHDPATH