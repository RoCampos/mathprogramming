#/bin/bash



gurobi_instances=$1

output=$2


for inst in `ls -vBh ${gurobi_instances}`
do
	#obtem o nome da instância sem as extensões.
	#útil para atribuir outras extensões para o resultado( .sol .opt etc)
	file=`basename ${inst} .lp.gz`

	echo "${inst}"
	#executa gurobi gerando a solução e informações de execução
	time gurobi_cl ResultFile=${output}/${file}.sol Threads=4 ${gurobi_instances}/${inst} > ${output}/${file}.info

done
