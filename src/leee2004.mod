#model of lee 2004

set VERTEX ordered;

set LINKS within (VERTEX) cross (VERTEX);
param E{LINKS};
param E_SIZE;

set GROUPS;
set member dimen 2;
set K{k in GROUPS} := {i in VERTEX: (k,i) in member};

param OPT{GROUPS};
param cost{i in 1 .. E_SIZE};
param cap{i in 1 .. E_SIZE};

# 			--------------------------------------------
param N := card (VERTEX);
set MAX := 1 .. 2**N;
set DS {k in MAX} ordered by VERTEX := {i in VERTEX: (k div 2**(ord(i, VERTEX) - 1) ) mod 2 = 1}; 

#			------------------------------------------

var x{ i in 1..E_SIZE , k in GROUPS }, binary;

var v{ i in VERTEX, k in GROUPS}, binary;

var Z{ i in 1 .. E_SIZE }, integer >= 0;

maximize capacidade_residual { (i,j) in LINKS: i < j} : cap[ E[i,j] ] - sum{k in GROUPS} x[ E[i,j] ,k] ;
	
	r1 {k in GROUPS, s in MAX: (s <> 2**N)  and !(K[k] within (DS[s] inter K[k])) }:
		sum {i in VERTEX diff{ DS[s] } , j in DS[s] : (i,j) in LINKS} 
			x[ E[i,j] ,k] >= 1;
	
	r2{i in VERTEX, k in GROUPS, (m,n) in LINKS: (m < n) and ((i = m) or (i = n)) }:
		v[i,k] >= x[ E[m,n] ,k];

	r3{i in VERTEX, k in GROUPS}:
		v[i,k] <= sum{ (m,n) in LINKS: (m < n) and ( (i = m) or (i = n) )} 
					x[ E[m,n] ,k];

	r4{k in GROUPS}:
		sum{i in VERTEX} v[i,k] = 1 + sum{ (i,j) in LINKS: i<j} x[ E[i,j],k];

	r5 {(i,j) in LINKS: i<j} :
		cap[ E[i,j] ] - sum{k in GROUPS} x[ E[i,j] ,k] >= Z[ E[i,j] ];

	r6 { (i,j) in LINKS: i < j} :
		Z[ E[i,j] ] >= 0;

#	r7 {k in GROUPS} :
#		sum { (i,j) in LINKS} x[ E[i,j] , k] <= 1.5*OPT[k]; 

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

param E :=
	1 2 1
	1 4 2
	1 5 3
	2 5 4
	2 3 5
	2 4 6
	3 5 7
	3 4 8
	
	2 1 1
	4 1 2
	5 1 3
	5 2 4
	3 2 5
	4 2 6
	5 3 7
	4 3 8;

param E_SIZE := 8;

set GROUPS := 1 2 3;

param OPT := 
	1 2 
	2 2
	3 2;

param : cost cap := 
	1 1 2
	2 1 2
	3 1 2
	4 1 2
	5 1 2
	6 1 2
	7 1 2
	8 1 2;


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

