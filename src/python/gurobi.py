# -*- encoding: UTF-8 -*-

from gurobipy import *

import random

class Network(object):

	def __init__(self, nodes):
	    self.link = {(x,y):(5,2*x//y) for x in range(1,nodes+1) for y in range(1,nodes+1) if y != x}
	    self.nodes = nodes

	def __str__ (self):
		print (self.link)

class Problem(object):
	def __init__(self, network):
		self.network = network
		self.groups = {x:random.sample(range(1,31),5) for x in range(1,6)}
		self.source = {x:random.randint(1,31) for x in range(1,6)}

		self.tk = 1

		# removing duplicates from group/source
		for x in range (1,6):
			try:
				self.groups[x].remove ( self.source[x] )
			except ValueError:
				pass

x = Network(30)
prob = Problem (x)

print (prob.groups)
					
def solver (problem):

	m = Model ("MPP")

	var1 = {}

	for i in range (1,31):
		for j in range (1,31):
			if (i!=j) & ((i,j) in prob.network.link):
				for k in range (1,6):				
					for d in prob.groups[k]:
						t=i,j,k,d
						tupla='x'+str (t)
						var1[t] = m.addVar (vtype=GRB.BINARY, obj=1,name=tupla)

	var2 ={}
	for k in range (1,6):
		for i,j in prob.network.link:
			t=i,j,k
			tupla='y'+str (t)
			var2[t] = m.addVar (vtype=GRB.BINARY, obj=1, name=tupla)


	# CREATING objective function
	objective = m.addVar (vtype=GRB.INTEGER, name="Z",obj=1)
	m.update()
	
	m.setObjective (objective, GRB.MAXIMIZE)

	m.update()	

	for k in range (1,6):
		for d in prob.groups[k]:
			sk = prob.source[k]						
			nameconst='flow1',k,d
			m.addConstr (
				quicksum ( var1[(i,sk,k,d)] for i in range(1, prob.network.nodes+1) if sk != i ) - 
				quicksum ( var1[(sk,i,k,d)] for i in range(1, prob.network.nodes+1) if sk != i ) == -1, 
				name=str(nameconst))

	m.update()

	for k in range (1,6):
		for d in prob.groups[k]:								
			nameconst='flow2',k,d
			m.addConstr (
				quicksum ( var1[(i,j,k,d)] 
					for i,j in prob.network.link if i>j) - 
				quicksum ( var1[(i,j,k,d)] 
					for i,j in prob.network.link if j>i) == 0, 
				name=str(nameconst))


	m.update ()

	for k in range (1,6):
		for d in prob.groups[k]:
			nameconst='flow3',k,d
			sk = prob.source[k]
			m.addConstr (
				quicksum ( var1[(i,j,k,d)] 
					for i,j in prob.network.link if i>j & j not in [sk,d] ) - 
				quicksum ( var1[(i,j,k,d)] 
					for i,j in prob.network.link if j>i & j not in [sk,d] ) == 1, 
				name=str(nameconst))

	m.update ()

	# first constraint of the problem
	for k in range (1,6):				
		for d in prob.groups[k]:
			for i,j in prob.network.link:
				constname='r5',k,d,i,j
				m.addConstr ( var1[(i,j,k,d)] <= var2[(i,j,k)],
					name=str (constname)
					)
	m.update ()
	# second constraint of the problem
	for k in range (1,6):
		for i,j in prob.network.link:
			constname='r6',i,j,k
			m.addConstr	(

				quicksum ( var1[(i,j,k,d)] for d in prob.groups[k]) - 
				var2[(i,j,k)] <= 0,
				name=str(constname)
				)

	m.update ()
	# capacity of the network	
	for i,j in prob.network.link:
		constname='r7',i,j
		m.addConstr (
			5 - 
			quicksum ( var2[(i,j,k)] * prob.tk for k in range(1,6)) >= objective,
			name=str(constname)
		)

	m.update()

	m.write ("teste.lp")

	m.optimize()

solver (prob)
