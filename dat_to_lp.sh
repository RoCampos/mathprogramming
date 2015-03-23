#!/bin/bash

# ESTE SCRIPT É UTILIZADO PARA FAZER 

data_instances=$1

output=$2

#o binário está no projeto de doutorado LpGenerator
bin=$3

for inst in `ls ${data_instances}`
do

	file=`basename ${inst} .dat`

	#cria arquivos *.lp para servir de entrada no gurobi
	time glpsol --check --wlp ${output}/${file}.lp --math src/mmmstp2.mod --data ${data_instances}/${inst}

	# Usa o Binário LpGenerator para gerar as instâncias
	
	#cria LP e adiciona no diretório ${output}
	#${bin} ${data_instances}/${inst} > ${output}/${file}.lp

	#comprime o arquivo gerando um gz.
	#gzip ${output}/${file}.lp

	#remove arquivo lp
	#rm ${output}/${file}.lp

done
