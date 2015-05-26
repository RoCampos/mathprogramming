set VERTEX;
set LINKS within {VERTEX} cross {VERTEX};

set GROUPS;
set MEMBER dimen 2;
set MGROUPS{k in GROUPS} := {i in VERTEX: (k,i) in MEMBER}; 
param Mroot{k in GROUPS};

param cost{LINKS} default 2;
param cap{LINKS} default 4;
param traffic{k in GROUPS} default 2;

param BUDGET default 6;
param OPT{k in GROUPS};
param Z;

var y{ (i,j) in LINKS, k in GROUPS}, binary;
var x{ (i,j) in LINKS, k in GROUPS, d in MGROUPS[k]}, binary;

#var Z, integer >= 0;

minimize objective: sum {k in GROUPS} sum {(i,j) in LINKS} y[i,j,k]*cost[i,j];

	r1{k in GROUPS, d in MGROUPS[k]}:
		sum {(i,Mroot[k]) in  LINKS} x[i, Mroot[k], k, d] -
		sum {(Mroot[k], i) in  LINKS} x[Mroot[k], i, k, d] = -1;

	r2{k in GROUPS, d in MGROUPS[k]}:
		sum { (i,d) in LINKS} x[i, d, k, d] -
		sum { (d,i) in LINKS} x[d, i, k, d] = 1;

	r3{k in GROUPS, d in MGROUPS[k], j in VERTEX: j <> d and j <> Mroot[k]}:
		sum { (i,j) in LINKS} x[i, j, k, d] - 
		sum { (j,i) in LINKS} x[j, i, k, d] = 0;

	r4{k in GROUPS, d in MGROUPS[k], (i,j) in LINKS}:
		x[i,j,k,d] <= y[i,j,k];

	#r5{(i,j) in LINKS}:
	#	cap[i,j] - sum{ k in GROUPS } (y[i,j,k] + y[j,i,k] )*traffic[k] >= 0;
	
	#avoiding circle, on vertex receive two flow of diferent vertex
	r7{i in VERTEX, k in GROUPS}:
		sum { (j,m) in LINKS: m=i and m <> Mroot[k]} y[j,m,k] <=1;

	#fix incoming flow on the root of k
	r8{ (i,j) in LINKS, k in GROUPS: Mroot[k] = j}:
		y[i,j,k] = 0;

	r6{(i,j) in LINKS}:
		 sum {k in GROUPS} y[i,j,k] <= Z;

solve;

#for {k in GROUPS} 
#{
#	printf "digraph{\n";
#	for { (i,j) in LINKS: y[i,j,k] = 1} 
#	{
#		printf "%s -> %s:%s\n", i,j,k;
#	}
#	printf "}\n";
#}

#for {k in GROUPS} {
#	printf "digraph{\n";
#	for { (i,j) in LINKS, d in MGROUPS[k]: (x[i,j,k,d] = 1  or x[j,i,k,d] = 1) and i<j } 
#	{
#		printf "%s -- %s:%s\n", i,j,k;
#	}
#	printf "}\n";
#}	

#display {k in GROUPS} sum { (i,j) in LINKS: y[i,j,k] = 1} cost[i,j];

#display min {(i,j) in LINKS: i<j} cap[i,j];

#display min {(i,j) in LINKS}
#		(cap[i,j] - sum{ k in GROUPS } (y[i,j,k])*traffic[k]);

display objective;

#display sum {k in GROUPS,(i,j) in LINKS: i<j} (y[i,j,k] + y[j,i,k])*cost[i,j];
