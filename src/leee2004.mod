#model of lee 2004

set VERTEX ordered;

set LINKS within (VERTEX) cross (VERTEX);

set GROUPS;
set member dimen 2;
set K{k in GROUPS} := {i in VERTEX: (k,i) in member};

param OPT{GROUPS};
param cost{LINKS};
param cap{LINKS};

# 			--------------------------------------------
param N := card (VERTEX);
set MAX := 1 .. 2**N;
set DS {k in MAX} ordered by VERTEX := {i in VERTEX: (k div 2**(ord(i, VERTEX) - 1) ) mod 2 = 1}; 

#			------------------------------------------

var x{ (i,j) in LINKS, k in GROUPS }, binary;

var v{ i in VERTEX, k in GROUPS}, binary;

var Z{ (i,j) in LINKS }, >= 0;

maximize capacidade_residual { (i,j) in LINKS: i < j} : cap[i,j] - sum{k in GROUPS} x[i,j,k];
	

	r1 {k in GROUPS, s in MAX: (s <> 2**N)  and !(K[k] within (DS[s] inter K[k])) }:
		sum {i in VERTEX diff{ DS[s] } , j in DS[s] : (i,j) in LINKS} 
			x[i,j,k] >= 1;
	
	r2{i in VERTEX, k in GROUPS, (i,m) in LINKS}:
		v[i,k] >= x[i,m,k];

	r3{i in VERTEX, k in GROUPS}:
		v[i,k] <= sum{(i,j) in LINKS} x[i,j,k];

	r4{k in GROUPS}:
		sum{i in VERTEX} v[i,k] = 1 + sum{ (i,j) in LINKS} x[i,j,k];

	r5 {(i,j) in LINKS} :
		cap[i,j] - sum{k in GROUPS} x[i,j,k] >= Z[i,j];

#solve;

#display {k in GROUPS, s in index: s > 1 and !(K[k] within (DS[s] inter K[k])) } K[k], DS[s];

#display capacidade_residual;
#display DS[25];
#display K[1];
#display (VERTEX diff{DS[25]}) inter K[1];

#display DS[25] inter K[1];
#display !(K[1] within (DS[25] inter K[1]));

#display r1;
#display v;
#display capacidade_residual;


data;

set VERTEX := 1 2 3 4 5;

set LINKS :=
	(1,2)
	(1,4)
	(1,5)
	(2,5)
	(2,3)
	(2,4)
	(3,5)
	(3,4) 

	(2,1)
	(4,1)
	(5,1)
	(5,2)
	(3,2)
	(4,2)
	(5,3)
	(4,3);

set GROUPS := 1 2 3;

param OPT := 
	1 2 
	2 2
	3 2;

param : cost cap := 
	1 2 1 2
	1 4 1 2
	1 5 1 2
	2 5 1 2
	2 3 1 2
	2 4 1 2
	3 5 1 2
	3 4 1 2
	
	2 1 1 2
	4 1 1 2
	5 1 1 2
	5 2 1 2
	3 2 1 2
	4 2 1 2
	5 3 1 2
	4 3 1 2 ;


#pares de grupo/mebro
set member :=
	1 1 
	1 2
	1 4
	2 1
	2 3
	2 5
	3 1
	3 2
	3 3;

