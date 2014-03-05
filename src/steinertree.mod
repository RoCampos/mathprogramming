#steiner tree

param n integer > 0;

#nodes
set V := {1..n};

#arestas
set E, dimen 3;
set EE := setof{ (i,j,c) in E} (i,j);

#terminals
set T within V;

#corte
set M within V;
set MM := setof{i in M: (i in V and card(M) < card(V) )} i;


#variables
var x{EE}, binary;

minimize obj:
	sum{ (i,j) in EE} x[i,j];
	r: sum{(i,j) in EE : (i in MM and j in (V diff MM))} x[i,j] >= 1;

solve;

display x;

data;
param n := 10;

set E :=
	1 1 2
	2 1 6
	3 2 3
	4 2 6
	5 3 5
	6 5 6
	7 5 4;

set T :=
	1
	5
	4;
end;
