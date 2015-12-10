# -*- encoding: utf-8 -*-

from gurobipy import *

import sys

class MulticastPacking(object):
	
	network = None
	groups = []

	def __init__(self, network, groups):
	    self.network = network
	    self.groups = groups


# multicast with budget constriant
def solver (problem):
	
	m = Model ("MPP")

	print (problem.network.nodes)
	print (problem.network.links)
	print (problem.groups)

	

	var1 = {}

	for i in range (1, (problem.network.nodes+1)):
		for j in range (1, (problem.network.nodes+1)):
			if (i!=j) & ((i,j) in problem.network.links):
				for k in range ( 1, len(problem.groups)+1 ):				
					for d in problem.groups[k-1].members:						
						t=i,j,k,d
						tupla='x'+str (t)
						var1[t] = m.addVar (vtype=GRB.BINARY, obj=1,name=tupla)												
						t=j,i,k,d
						tupla='x'+str (t)
						var1[t] = m.addVar (vtype=GRB.BINARY, obj=1,name=tupla)

	var2 ={}
	for k in range (1, len (problem.groups)+1): # for each group multicast
		for i,j in problem.network.links:
			t=i,j,k
			tupla='y'+str (t)
			var2[t] = m.addVar (vtype=GRB.BINARY, obj=1, name=tupla)
			t=j,i,k
			tupla='y'+str (t)
			var2[t] = m.addVar (vtype=GRB.BINARY, obj=1, name=tupla)


	# CREATING objective function
	# objective = m.addVar (vtype=GRB.INTEGER, name="Z",obj=1)
	# m.update()
	
	# m.setObjective (objective, GRB.MAXIMIZE)

	m.update()	

	NODES = problem.network.nodes+1
	LINKS = problem.network.links
	KSIZE = len(problem.groups)+1

	## restrição de fluxo 1
	for k in range (1, KSIZE ):
		for d in problem.groups[k-1].members:
			sk = problem.groups[k-1].source
			nameconst='flow1',k,d			

			m.addConstr (
				quicksum ( var1[(i,sk,k,d)] 
					for i in xrange(1, NODES) 
						if sk != i and ((sk,i) in LINKS or (i,sk) in LINKS) 
						) - 
				quicksum ( var1[(sk,i,k,d)] 
					for i in xrange(1, NODES) 
						if sk != i and ((sk,i) in LINKS or (i,sk) in LINKS) 
						) == -1, 
				name=str(nameconst))

	m.update()

	print (LINKS.keys()[0])

	for k in range (1,KSIZE):
		for d in problem.groups[k-1].members:								
			nameconst='flow2',k,d
			m.addConstr (
				quicksum ( var1[( l[0],l[1],k,d)] 
					for l in LINKS.keys() ) - 
				quicksum ( var1[( (l[::-1])[0] , (l[::-1])[1] ,k,d)] 
					for l in LINKS.keys()) == 0, 
				name=str(nameconst))

	m.update ()

	for k in range (1,KSIZE):
		for d in problem.groups[k-1].members:
			nameconst='flow3',k,d
			sk = problem.groups[k-1].source
			m.addConstr (
				quicksum ( var1[( l[0] , l[1] , k , d)] 
					for l in LINKS.keys() if l[1] not in [sk,d] ) - 
				quicksum ( var1[( (l[::-1])[0] , (l[::-1])[1] , k , d )] 
					for l in LINKS.keys() if (l[::-1])[0] not in [sk,d] ) == 1, 
				name=str(nameconst))

	m.update ()

	# # first constraint of the problemlem
	# for k in range (1,6):				
	# 	for d in problem.groups[k]:
	# 		for i,j in problem.network.links:
	# 			constname='r5',k,d,i,j
	# 			m.addConstr ( var1[(i,j,k,d)] <= var2[(i,j,k)],
	# 				name=str (constname)
	# 				)
	# m.update ()


	# # second constraint of the problemlem
	# for k in range (1,6):
	# 	for i,j in problem.network.links:
	# 		constname='r6',i,j,k
	# 		m.addConstr	(
	# 			quicksum ( var1[(i,j,k,d)] for d in problem.groups[k]) - 
	# 			var2[(i,j,k)] <= 0,
	# 			name=str(constname)
	# 			)

	# m.update ()
	
	# capacity of the network	
	for i,j in LINKS:
		constname='cap',i,j
		m.addConstr (
			LINKS[(i,j)][1] - 
			quicksum ( var2[(i,j,k)] * problem.groups[k-1].traffic for k in range(1,KSIZE)) >= 0,
			name=str(constname)
		)
		constname='cap',j,i
		m.addConstr (
			LINKS[(i,j)][1] - 
			quicksum ( var2[(j,i,k)] * problem.groups[k-1].traffic for k in range(1,KSIZE)) >= 0,
			name=str(constname)
		)

	m.update()

	m.write ("teste3.lp")

	# m.optimize()



# solver (problem)