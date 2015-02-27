#!/bin/bash

#diretório das instâncias que serão convertidas para dat
#segundo o modelo mmmstp
mpp_instances=$1

#diretório de saída dos arquivos *.dat
output=$2

#binário que executa o processo: modelData
bin=$3

for inst in `ls ${mpp_instances}`
do

	file=`basename ${inst} .brite`

	#opção dois indica que será criada a saída com base no modelo mmmstp
	./$bin $mpp_instances/$inst 2 > ${output}/${file}.dat

done
