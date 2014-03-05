
#size
param c;

#itens
set I, dimen 3;

#indeces
set J := setof{(i,s,p) in I} i;

#binary variable
var a{J}, binary;

#the model
maximize obj :
	sum{(i,s,p) in I} p*a[i];

s.t. size :
	sum{(i,s,p) in I} s*a[i] <= c;

solve;

printf "The knapsack contains:\n";
printf {(i,s,p) in I: a[i] == 1} " %i", i;
printf "\n";

data;

# Size of the knapsack
param c := 100;

# Items: index, size, profit
set I :=
  1 10 10
  2 10 10
  3 15 15
  4 20 20
  5 20 20
  6 24 24
  7 24 24
  8 50 50;

end;
