#!/bin/bash

# ESTE SCRIPT É UTILIZADO PARA FAZER 

data_instances=$1

output=$2

for inst in `ls ${data_instances}`
do

	file=`basename ${inst} .dat`

	#cria arquivos *.lp para servir de entrada no gurobi
	glpsol --check --wlp ${output}/${file}.lp --math src/mmmstp.mod --data ${data_instances}/${inst}

done
