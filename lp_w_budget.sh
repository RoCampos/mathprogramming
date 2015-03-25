#!/bin/bash

#### this file generate the lp's files for gurobi solver.
#### the budget of each instance is considerated

#directory where the instances are stored (brite files)
instances=$1

#output directory of resulting files
output_dir=$2

#file containing a columnn of budget for each instance.
budget=$3

#list of budget used as input for the lpGenerator
budgets=(`cat ${budget}`)

bin=$4

x=0;
for inst in `ls -vH ${instances} --hide=*~`
do

	file=`basename ${inst} .brite`
	echo ${file}

	${bin} ${instances}/${inst} ${budgets[x]} > ${output_dir}/${file}.lp
	gzip ${output_dir}/${file}.lp

	let "x = x + 1"

done

