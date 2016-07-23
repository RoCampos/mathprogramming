
# this file contains the model proposed by VoB (1999)
# for the hop constrained steiner tree problem

# obsevartions:
#	- V(i) = {k \in V | [k,i] \in E}, predecessors of i
#	- N(i) = {j \in V | [i,j] \in E}, sucessors of i


## ------------ param and set section ------------- ##

set V; #vertex
set Q within V; #set of terminals

set E dimen 2; #set of edges

param cost{E}; #cost of each link

param w; #root

param H; #hop limit


## ----------- variable section ----------- ##
var u{V}, binary;
var x{(i,j) in E}, binary;

## ------------ model section ------------- ##


minimize hstp:
	sum{ (i,j) in E} cost[i,j] * x[i,j];

	C1{k in Q}:
		sum { (i,j) in E: k == j} x[i,j] = 1;

	C2{(i,j) in E: i in V}:
		x[i,j] <= sum{ k in V: k == i} x[k,i];

	C3:
		u[w] = 0;

	C4{k in V: k <> w}: 
		sum{(i,j) in E: k == j} x[i,k] <= u[k];

	C5{k in V: k <> w}:
		u[k] <= H * sum{(i,j) in E: k ==j} x[i,k];

	C6{(i,j) in E}:
		(H+1) * x[i,j] + u[i] - u[j] + (H+1)*x[i,j] <= H;

solve;

## ------------ display section ------------- ##
display u;
display x;

end;