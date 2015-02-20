

set VERTEX;
set LINKS within {VERTEX} cross {VERTEX};

set GROUPS;
set MEMBER dimen 2;
set MGROUPS{k in GROUPS} := {i in VERTEX: (k,i) in MEMBER}; 
param Mroot{k in GROUPS};

param cost{LINKS} default 1;
param cap{LINKS} default 2;


var y{(i,j) in LINKS, k in GROUPS}, binary;
var x{ (i,j) in LINKS, k in GROUPS, d in MGROUPS[k]} >=0 ;


minimize objective{k in GROUPS}: sum { (i,j) in LINKS} cost[i,j]*y[i,j,k];

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

solve;

#display y;
display objective;
display sum {k in GROUPS} objective[k];

data;

set VERTEX := 1 2 3 4 5 6;

set LINKS :=
	(1,2)
	(1,4)
	(1,5)
	(2,5)
	(2,3)
	(2,4)
	(3,5)
	(3,4)
	(1,6)
	(6,5)

	(2,1)
	(4,1)
	(5,1)
	(5,2)
	(3,2)
	(4,2)
	(5,3)
	(4,3)
	(6,1)
	(5,6);


set GROUPS := 1 2 3;

param Mroot :=
	1 1
	2 1
	3 3;

#pares de grupo/mebro
set MEMBER := 
	1 2
	1 4
	2 3
	2 5
	3 1
	3 2;

