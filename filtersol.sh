#/bin/bash

# this script is used to remove duplicated lines in the solution produced by
# gurobi

sol_instances=$1

for inst in `ls ${sol_instances}/*.sol`
do

	echo "sort ${inst} | uniq -u "

done
