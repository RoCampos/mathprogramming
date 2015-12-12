# -*- encoding: utf-8 -*-

import os

def get_network(file):
	#print "Reading the File: " + str(file)
	edges = 0
	network_links = {}
	with open(file) as f:
		for current_line in f:    
			if current_line.find ('Edges:') != -1:	
				#getting the number of edges
				edges = (int)(current_line.split()[2])  
				#print "Number of edges: " + str(edges)
				continue

			#reading the edges
			if edges > 0:        
				line = current_line.split ()  
				v = (int)(line[1])+1
				w = (int)(line[2])+1
				link = (min(v,w), max(v,w))
				cost = int(float((line[3])))
				band = int(float((line[5])))
				link_property = (cost,band)
				network_links[link] = link_property
				edges = edges - 1	

	return network_links			


def get_groups(file):	
	#print "Reading the file: groups"

	mlist = False

	gn = None
	tk = None
	sc = None
	size = None
	members = []

	groups = []
	with open(file) as f:
		for line in f:
		    if line.find ("Group Number:") > -1:                
		        gn = int(line.split ()[3])
		        tk = int(line.split ()[7])
		        continue;
		    
		    if line.find ("Source:") > -1:
		        sc = int(line.split ()[2])+1
		        size = int(line.split ()[6])
		        mlist = True
		        continue
		        
		    if mlist:        
		        members = map (int, line.split ())
		        members = [x+1 for x in members]
		        group = (gn, tk, sc, size, members)
		        groups.append (group)        
		        #clean data
		        gn = None
		        tk = None
		        sc = None
		        size = None
		        members = [] 
		        mlist = False

	return groups

