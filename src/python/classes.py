# -*- encoding: utf-8 -*-

"""
	This class reprents a network

"""
class Network(object):

	links = dict #armazena as arestas
	nodes = int #armazena o número de vérices
	
	def __init__(self, links, nodes):
		self.links = links
		self.nodes = nodes

	def set(self, links):
		self.links = links

	def exists(self, link):
		return link in self.links

	def properties(self, link):		
		if self.exists(link):
			return self.links[link]
		else:
			return ()

"""
	Classe que repreenta um grupo multicast
"""
class MulticastGroup(object):
	
	def __init__(self, group):
		self.id = group[0]
		self.traffic = group[1]
		self.source = group[2]
		self.size = group[3]
		self.members = group[4]	
		#for iteration
		self.i=0
		self.n=len(self.members)

	def get_id(self):
		return self.id

	def get_source(self):
		return self.source

	def get_traffic (self):
		return self.traffic

	def get_member (self,pos):
		if pos < len (self.members):
			return self.members[pos]
		else:
			return -1

	def get_members (self):
		return self.members

	def is_member (self,member):
		return member in self.members

	def is_source (self, node):
		return node == self.source

	def __repr__(self):
		out = "Id: %s\n" % repr(self.id)
		out += "Source: %s\n" % repr(self.source)
		out += "Traffic: %s\n" % repr(self.traffic)
		out += "Members: %s\n" % repr(self.members)
		return out

	repr = __repr__
