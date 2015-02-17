#multicomodoty as steiner in industry

set V;

set T;

param r;

set LINKS within (V) cross (V) ;

param cost{LINKS};

param delay{LINKS};

var y{LINKS}, binary;

var x{(i,j) in LINKS, k in T} >= 0;

minimize stpd: 
	sum { (i,j) in LINKS} cost[i,j] * y[i,j]; 

	R1{k in T}:
		sum{(i,r) in LINKS} x[i,r,k] -
		sum{(r,i) in LINKS} x[r,i,k] = -1;

	R2{k in T}:
		sum{(i,k) in LINKS} x[i,k,k] -
		sum{(k,i) in LINKS} x[k,i,k] = 1;

	R3{k in T, j in V: j <> r and j <> k}:
		sum{(i,j) in LINKS } x[i,j,k] -
		sum{(j,i) in LINKS } x[j,i,k] = 0;

	R4{k in T, (i,j) in LINKS}:
		x[i,j,k] <= y[i,j];

solve;

#display x;
#display y;
display stpd;
