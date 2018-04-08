import os
import json
from pprint import pprint

state_file = os.getcwd() + '/terraform.tfstate'
state = dict()

with open(state_file) as objects:
    state = json.loads(objects.read()) 

state = state['modules'][0]['resources']

nodes = {}

for droplet in state:
    nodes[state[droplet]['primary']['attributes']['name']] = state[droplet]['primary']['attributes']['ipv4_address']

print('[k8s-primary-master]')
for node in nodes:
    if 'primary' in node:
        print(nodes[node])

print('[k8s-masters]')
for node in nodes:
    if 'master' in node:
        print(nodes[node])

print('[k8s-workers]')
for node in nodes:
    if 'worker' in node:
        print(nodes[node])
