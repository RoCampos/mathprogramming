#/bin/bash



gurobi_instances=$1

output=$2


for inst in `ls ${gurobi_instances}`
do
	file=`basename ${inst} .lp`

	#executa gurobi gerando a solução e informações de execução
	gurobi_cl ResultFile=${output}/${file}.sol ${gurobi_instances}/${inst} > ${output}/${file}.info

done
