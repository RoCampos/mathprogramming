

import sys

from classes import Network, MulticastGroup
from multicastpacking import MulticastPacking, solver
import reader

import random
import time

def main():

	#getting the file
	file = None

	if len(sys.argv) >=2:
		file = sys.argv[1]
	
	# creating network data	
	links = reader.get_network (file)	
	net = Network (links, nodes=30)
	
	# #creating a group	
	mgroups = [MulticastGroup(x) for x in reader.get_groups (file)]

	# creating the problem instance
	problem = MulticastPacking (net, mgroups)

	solver (problem)

	

if __name__ == "__main__":
	main ()