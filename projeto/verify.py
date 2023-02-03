

import json

with open('in.txt', 'r') as f:
    lines = f.readlines()

for i in lines:
    i = i.replace('\n', '')

    print(i.split(' '))

    

