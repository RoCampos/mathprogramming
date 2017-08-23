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
	#Ver documentação no arquvivo DataGenerator.cpp
	# Opções 
	# 1 - Gera um "dat" para árvore de Steiner
	#	Usado com o modelo stp_multi.mod
	# 2 - Gera um "dat" para multiple multicast mmmstp.mod
	# 3 - Gera um "dat" para cada árvore do multiple multicast
	#	Usado com o stp_multi.mod
	
	time ./$bin $mpp_instances/$inst 2 > ${output}/${file}.dat

	

done
