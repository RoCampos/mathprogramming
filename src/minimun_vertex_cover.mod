#math programming for MAXIMUM MATCHING PROBLEM

param c;

#set of edges
set V, dimen 1;

set E within V cross V;

#binary variable
var x{V}, binary;

#the model
minimize obj :
	sum{i in V} x[i];
	r{(i,j) in E}:	x[i] + x[j] >= c;

solve;

printf "Minimun Vertex Cover:\n";
printf {i in V: x[i] == 1} " %i", i;
printf "\n";

data;	
param c := 1;

set V :=
	1
	2
	3
	4
	5
	6;

set E :=
	1 2
	1 6
	2 3
	2 6
	3 5
	5 6
	5 4;

end;
