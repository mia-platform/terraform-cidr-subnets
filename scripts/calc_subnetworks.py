#!/usr/bin/env python3

from ipaddress import IPv4Address, summarize_address_range, ip_network
from sys import stdin
from itertools import chain
import json

'''
From this range:
10.37.0.0 -> 10.81.255.255

Get arbitrary not overlapping subnets of this kind:
/28
/27
/25


10.109.0.0 > 10.255.255.255 # pods e servizi
/21
/20
/18

input:
{"base_cidr_block":"10.0.0.0/8","final_cidr_block":"","networks":"20,20"}"
'''

js = json.load(stdin)

initial_cidr = js["base_cidr_block"]
final_cidr = js["final_cidr_block"] or initial_cidr

first_ip = ip_network(initial_cidr)[0]
last_ip  = ip_network(final_cidr)[-1]

usable_range = [ipaddr for ipaddr in summarize_address_range(
   IPv4Address(first_ip),
   IPv4Address(last_ip))
   ]

input_networks = {}

cidr_blocks = js["networks"].split(",")
for cidr in set(cidr_blocks):
  input_networks[int(cidr)] = chain(*[ x.subnets(new_prefix=int(cidr)) for x in usable_range ])

results = []

def check(subnets):
  for s in subnets:
    over = False
    for res in results:
      if s.overlaps(res):
        over = True
    if not over:
      return s

for subnet in cidr_blocks:
  results.append(check(input_networks[int(subnet)]))

print(json.dumps(
  {"subnetworks": ','.join([str(x) for x in results])}
  ))
