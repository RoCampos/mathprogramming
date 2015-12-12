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

	NODES = problem.network.nodes+1
	LINKS = problem.network.links
	KSIZE = len(problem.groups)+1

	var1 = {}

	for i in range (1, (NODES)):
		for j in range (1, (NODES)):
			if (i!=j) & ((i,j) in LINKS):
				for k in range ( 1, len(problem.groups)+1 ):				
					for d in problem.groups[k-1].members:						
						t=i,j,k,d
						tupla='x'+str (t)
						var1[t] = m.addVar (vtype=GRB.BINARY, obj=1,name=tupla, ub=1.0, lb=0.0)												
						t=j,i,k,d
						tupla='x'+str (t)
						var1[t] = m.addVar (vtype=GRB.BINARY, obj=1,name=tupla, ub=1.0, lb=0.0)

	var2 ={}
	for k in range (1, KSIZE): # for each group multicast
		for l in LINKS.keys():
			t=l[0],l[1],k
			tupla='y'+str (t)
			var2[t] = m.addVar (vtype=GRB.BINARY, obj=1, name=tupla, ub=1.0, lb=0.0)
			t=l[1],l[0],k
			tupla='y'+str (t)
			var2[t] = m.addVar (vtype=GRB.BINARY, obj=1, name=tupla, ub=1.0, lb=0.0)


	
	m.update()
	
	expr  = []	
	for k in xrange (1, KSIZE ):
	 	expr.append ( quicksum (var2[ (l[0],l[1],k) ] * LINKS[l][0] 
	 		for l in LINKS.keys()) )	
	 	expr.append ( quicksum (var2[ (l[1],l[0],k) ] * LINKS[l][0] 
	 		for l in LINKS.keys()) )
	

	m.setObjective (quicksum (expr), GRB.MINIMIZE)
	m.update ()


	## restrição de fluxo 1
	for k in xrange (1, KSIZE):
	    for d in problem.groups[k-1].members:
	        sk = problem.groups[k-1].source
	        _name='flow1',k,d
	        m.addConstr (
	            quicksum ( var1[x] for x in tuplelist (var1).select ('*',sk,k,d) )
	            -
	            quicksum ( var1[x] for x in tuplelist (var1).select (sk,'*',k,d) )
	            == -1,
	            name=str(_name)
	        )

	m.update ()

	for k in xrange (1, KSIZE):
	    for d in problem.groups[k-1].members:
	        for j in xrange(1,NODES):
	            sk = problem.groups[k-1].source
	            _name='flow2',k,d,j,       
	            m.addConstr (
	                quicksum(
	                   var1[x] for x in tuplelist (var1).select ('*',j,k,d) 
	                    if x[1] not in [sk, d]
	                )
	                -
	                quicksum(
	                    var1[x] for x in tuplelist (var1).select (j,'*',k,d) 
	                    if x[0] not in [sk, d]
	                )
	                == 0,
	                name=str(_name)
	            )            

	m.update ()

	for k in xrange (1, KSIZE):
	    for d in problem.groups[k-1].members:
	        sk = problem.groups[k-1].source
	        _name='flow3',k,d
	        m.addConstr (
	            quicksum (
	                var1[x] for x in tuplelist (var1).select ('*',d,k,d)
	            )
	            -
	            quicksum (
	                var1[x] for x in tuplelist (var1).select (d,'*',k,d)
	            )
	            == 1,
	            name=str(_name)
	        )
	        
	m.update ()

	# first constraint of the problemlem
	for k in range (1, KSIZE):				
		for d in problem.groups[k-1].members:
			for l in LINKS.keys ():
				constname='r5',k,d,l[0],l[1]
				m.addConstr ( var1[(l[0],l[1],k,d)] <= var2[(l[0],l[1],k)],
					name=str (constname)
					)
				constname='r5',k,d,l[1],l[0]
				m.addConstr ( var1[(l[1],l[0],k,d)] <= var2[(l[1],l[0],k)],
					name=str (constname)
					)
	m.update ()

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
			quicksum ( var2[(i,j,k)] * problem.groups[k-1].traffic for k in range(1,KSIZE)) >= 3,
			name=str(constname)
		)
		constname='cap',j,i
		m.addConstr (
			LINKS[(i,j)][1] - 
			quicksum ( var2[(j,i,k)] * problem.groups[k-1].traffic for k in range(1,KSIZE)) >= 3,
			name=str(constname)
		)

	m.update()
	m.write ("teste3.lp")
	m.optimize()

	# for var in m.getVars ():
	# 	if var.getAttr (GRB.Attr.X) >= 1:
	# 		print var.getAttr (GRB.Attr.VarName)



# solver (problem)