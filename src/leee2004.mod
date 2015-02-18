#model of lee 2004

set VERTEX;

set LINKS within (VERTEX) cross (VERTEX);
set GROUPS;

param OPT{GROUPS};
param cost{LINKS};
param cap{LINKS};

set member dimen 2;
param members{j in VERTEX, k in GROUPS};


# 			--------------------------------------------

param N := card (VERTEX);
set index := 1 .. 2 **N;
set DS {k in index} := {i in VERTEX: (k div 2**i) mod 2 = 1};

#			------------------------------------------

var x{ (i,j) in LINKS, k in GROUPS }, binary;

var v{ i in VERTEX, k in GROUPS}, binary;

var Z{ (i,j) in LINKS }, >= 0;

maximize capacidade_residual{ (i,j) in LINKS}: Z[i,j];
	
#	r1{k in GROUPS}: 
#		sum { (i,j) in LINKS: (k,j) in member} x[i,j,k] >= 1;

#revisar
#	r1{k in GROUPS}:
#		sum { i in VERTEX, j in VERTEX diff {1..i}:(i,j) in LINKS and (k,j) in member} x[i,j,k] >=1;

	r2{i in VERTEX, k in GROUPS, (i,m) in LINKS}:
		v[i,k] >= x[i,m,k];

#	r3{i in VERTEX, k in GROUPS}:
#		v[i,k] <= sum{(i,j) in LINKS} x[i,j,k];

	r4{k in GROUPS}:
		sum{i in VERTEX} v[i,k] = 1 + sum{ (i,j) in LINKS} x[i,j,k];

	r5{ (i,j) in LINKS}: 
		cap[i,j] - sum{k in GROUPS} x[i,j,k] >= Z[i,j];

	r6{k in GROUPS}:
		sum{ (i,j) in LINKS} x[i,j,k] <= 1.5*OPT[k];

solve;
#display x;
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
	(3,4) ;

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
	3 4 1 2 ;


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
	
#parametro para indicar a quem um membro pertece
param members :=
	1 1 1
	1 2 2
	1 4 4
	2 1 1
	2 3 3
	2 5 5
	3 1 1
	3 2 2
	3 3 3;

