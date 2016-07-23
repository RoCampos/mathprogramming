
# this file contains the model proposed by VoB (1999)
# for the hop constrained steiner tree problem
# http://link.springer.com/article/10.1023/A:1018967121276

# obsevartions:
#	- V(i) = {k \in V | [k,i] \in E}, predecessors of i
#	- N(i) = {j \in V | [i,j] \in E}, sucessors of i


## ------------ param and set section ------------- ##

set V; #vertex
set Q; #set of terminals

set LINKS dimen 2; #set of edges
param LINKS_SIZE;

param E{LINKS};
param cost{ i in 1 .. LINKS_SIZE}; #cost of each link

param w; #root

param H; #hop limit


## ----------- variable section ----------- ##
var u{V}, binary;
var x{(i,j) in LINKS}, binary;

## ------------ model section ------------- ##


minimize hstp:
	sum{ (i,j) in LINKS} cost[ E[i,j] ] * x[i,j];

	C1{k in Q}:
		sum { (i,j) in LINKS: j == k} x[i,j] = 1;

	C2{ (i,j) in LINKS: i not in Q}:
		x[i,j] <= sum{ k in V: (k,i) in LINKS} x[k,i];

	C3:
		u[w] = 0;

	C4{k in V: k <> w}: 
		sum{(i,k) in LINKS} x[i,k] <= u[k];

	C5{k in V: k <> w}:
		u[k] <= H * sum{(i,k) in LINKS} x[i,k];

	C6{(i,j) in LINKS}:
		(H+1) * x[i,j] + u[i] - u[j] + (H-1)*x[i,j] <= H;

solve;


## ------------ display section ------------- ##
display u;
display x;

end;