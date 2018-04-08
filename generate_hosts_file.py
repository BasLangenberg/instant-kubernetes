import os
import json
from pprint import pprint

state_file = os.getcwd() + '/terraform.tfstate.backup'
state = dict()

with open(state_file) as objects:
    state = json.loads(objects.read()) 

state = state['modules'][0]['resources']

for droplet in state:
    print(state[droplet]['primary']['attributes']['name'] + ' ' + state[droplet]['primary']['attributes']['ipv4_address'])
