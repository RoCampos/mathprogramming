#!/bin/bash

# ESTE SCRIPT É UTILIZADO PARA FAZER 

data_instances=$1

output=$2

#o binário está no projeto de doutorado LpGenerator
bin=$3

#budget passed to instance
budget_file=$4
list=( `cat ${budget_file}` )

idx=0


for inst in `ls -vH ${data_instances} --hide *~`
do

	file=`basename ${inst} .dat`

	#cria arquivos *.lp para servir de entrada no gurobi
	#time glpsol --check --wlp ${output}/${file}.lp --math src/mmmstp2.mod --data ${data_instances}/${inst}

	# Usa o Binário LpGenerator para gerar as instâncias
	
	#cria LP e adiciona no diretório ${output}
	#when there is no budget 0 must be passed
	${bin} ${data_instances}/${inst} ${list[ ${idx} ]} > ${output}/${file}.lp
	let "idx = idx + 1"

	#comprime o arquivo gerando um gz.
	#gzip ${output}/${file}.lp

	#remove arquivo lp
	#rm ${output}/${file}.lp

done
