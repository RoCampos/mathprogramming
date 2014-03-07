
param n;

set V := 1..n;

set T within V;

#set C within V cross V;
#set CC :=setof { (i,j,k) in C} (i,j);

set E within {i in V, j in V: i<j};

set ED := {i in V, j in V: (i,j) in E or (j,i) in E};

param c{V,V} >=0;

param r in V;

var x {(i,j) in ED, k in T: k != r} binary;

var y {E} binary;

minimize totalcost: 
	sum {(i,j) in E} c[i,j] * y[i,j];

	flow1 {k in T: k != r}:	sum {j in V: (r,j) in ED} x[r,j,k] - sum {j in V: (j,r) in ED} x[j,r,k] = 1;
	flow2 {k in T, i in V: i != r and i != k and k != r} : sum {j in V: (i,j) in ED} x[i,j,k] - sum {j in V: (j,i) in ED} x[j,i,k] = 0;
	force1 {(i,j) in E, k in T: k != r}: x [i,j,k] <= y [i,j];
	force2 {(i,j) in E, k in T: k != r}: x [j,i,k] <= y [i,j];

solve;

display totalcost;
display y;

data;

param n := 4;
set E :=(2,4) (0,3) (1,3) (2,3) (1,2) (0,4) (0,1) (1,4) ;
set C :=
0 871.946 0 501.43 637.201 
871.946 0 609.69 331.892 526.545 
0 609.69 0 772.189 780.626 
501.43 331.892 772.189 0 0 
637.201 526.545 780.626 0 0 
;
set T := 0 1 4;
param r := 0;

end;
