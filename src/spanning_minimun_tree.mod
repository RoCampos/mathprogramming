#spanning minimal tree

set V, dimen 1;

set E, dimen 4;

set EE := setof{(i,v1,v2,c) in E} (v1,v2);

var e{EE}, binary;

minimize obj:
	sum{ (v1,v2) in EE} e[v1,v2];
	r{i in V ,j in V, k in V: (i > j or i < j) and (j <  k or k > k) and ( (i,j) in EE and (j,k) in EE and (k,i) in EE )}: e[i,j] + e[j,k] + e[k,i] >= 1;

solve;


data;	
set V :=
	1
	2
	3
	4
	5
	6;

set E :=
	1 1 2 8
	2 1 6 9
	3 2 3 3
	4 2 6 5
	5 3 5 6
	6 5 6 7
	7 5 4 2;

end;
