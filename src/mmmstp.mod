

set VERTEX;
set LINKS within {VERTEX} cross {VERTEX};

set GROUPS;
set MEMBER dimen 2;
set MGROUPS{k in GROUPS} := {i in VERTEX: (k,i) in MEMBER}; 
param Mroot{k in GROUPS};

param cost{LINKS} default 1;
param cap{LINKS} default 2;
param traffic{k in GROUPS} default 1;

param BUDGET default 40000;


var y{(i,j) in LINKS, k in GROUPS}, binary;
var x{ (i,j) in LINKS, k in GROUPS, d in MGROUPS[k]} >=0 ;

var Z{ (i,j) in LINKS}, integer >= 0;


#maximize objective{ (i,j) in LINKS}: cap[i,j] - sum{ k in GROUPS } y[i,j,k];

minimize objective{ (i,j) in LINKS}: sum{ k in GROUPS } y[i,j,k]*traffic[k];

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

	r5{(i,j) in LINKS}:
		cap[i,j] - sum{ k in GROUPS } y[i,j,k]*traffic[k] >= Z[i,j];

	r6{(i,j) in LINKS}:
		Z[i,j] >=0;


	r7: sum { (i,j) in LINKS, k in GROUPS} y[i,j,k]*cost[i,j] <= BUDGET	;

solve;

#for {k in GROUPS, (i,j) in LINKS: y[i,j,k] = 1}
#{
	#printf "%s -- %s:%s\n", i,j,k;
#}

display 'CAPACIDADE RESIDUAL', min {(i,j) in LINKS} (cap[i,j] - sum{ k in GROUPS } y[i,j,k]*traffic[k]);
display 'CUSTO', sum { (i,j) in LINKS, k in GROUPS} y[i,j,k]*cost[i,j];

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

