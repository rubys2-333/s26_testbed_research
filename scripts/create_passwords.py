import sys
import string
import random
characters = string.ascii_letters + string.digits
out = ''
for i in sys.argv[1:]:
    passwd = ''.join([random.choice(characters) for _ in range(16)])
    out += f"{i}:{passwd}\n"
out = out.strip()
print(out)
