# REQUIRES: python3
# OUTPUTS: password.txt, changes all user passwords on the system, including root password.
# generate ignore_users.txt if it doesnt exist
touch ignore_users.txt

# get array of users from /etc/shadow that are not system users
mapfile users < <(awk -F: '($3>=1000||$1=="root")&&($1!="nobody") {print $1}' /etc/passwd | grep -v -x -f ignore_users.txt)

# small python script that will generate some random passwords for each user
cat <<EOF > create_passwords.py
import sys
import string
import random
characters = string.ascii_letters + string.digits
out = ''
for user in sys.argv[1:]:
    passwd = ''.join([random.choice(characters) for _ in range(16)])
    out += f"{user}:{passwd}\n"
out = out.strip()
print(out)
EOF

# generate the passwords for the user array
python3 ./create_passwords.py ${users[@]} > passwords.txt

# change those passwords
echo passwords.txt | sudo chpasswd

# cleanup
rm create_passwords.py
