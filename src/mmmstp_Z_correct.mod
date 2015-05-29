/* WITH NO BUDGET CONSTRAINT
*
* Este versão tem a restrição OUT que resolve o problema de arestas
* adicionadas a solução necessidade.
*/

set VERTEX;
set LINKS within {VERTEX} cross {VERTEX};

set GROUPS;
set MEMBER dimen 2;
set MGROUPS{k in GROUPS} := {i in VERTEX: (k,i) in MEMBER}; 
param Mroot{k in GROUPS};

param cost{LINKS} default 1;
param cap{LINKS} default 4;
param traffic{k in GROUPS} default 2;

param BUDGET default 15000;
param OPT{k in GROUPS};


var y{(i,j) in LINKS, k in GROUPS}, binary;
var x{ (i,j) in LINKS, k in GROUPS, d in MGROUPS[k]}, binary;

var Z, integer >= 0;

maximize objective: Z;

	r1{k in GROUPS, d in MGROUPS[k]}:
		sum {(i,Mroot[k]) in  LINKS} x[i, Mroot[k], k, d] -
		sum {(Mroot[k], i) in  LINKS} x[Mroot[k], i, k, d] = -1;

	r2{k in GROUPS, d in MGROUPS[k]}:
		sum { (i,d) in LINKS} x[i, d, k, d] -
		sum { (d,i) in LINKS} x[d, i, k, d] = 1;

	r3{k in GROUPS, d in MGROUPS[k], j in VERTEX: j <> d and j <> Mroot[k]}:
		sum { (i,j) in LINKS} x[i, j, k, d] - 
		sum { (j,i) in LINKS} x[j, i, k, d] = 0;

	r4{k in GROUPS, d in MGROUPS[k], (i,j) in LINKS}:
		x[i,j,k,d] <= y[i,j,k];

	out{k in GROUPS, (i,j) in LINKS}:
		sum{d in MGROUPS[k]} x[i,j,k,d] - y[i,j,k] >= 0;

	r5{(i,j) in LINKS}:
		cap[i,j] - sum{ k in GROUPS } (y[i,j,k] + y[j,i,k] )*traffic[k] >= Z;
	
	r7{i in VERTEX, k in GROUPS}:
		sum { (j,m) in LINKS: m=i and m <> Mroot[k]} y[j,m,k] <=1;

	#fix incoming flow on the root of k
	#r8{ (i,j) in LINKS, k in GROUPS: Mroot[k] = j}:
	#	y[i,j,k] = 0;

solve;

