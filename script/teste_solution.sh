#!/bin/bash

#diretório onde se encontram os arquivos das instâncias (.brite)
instances=$1

#diretório onde se encontram os arquivos .opt
opt=$2

#binário SolutionTest no diretório projeto/build
bin=$3

for inst in `ls -vBh ${instances}`
do

	#echo $inst
	file=`basename ${inst} .brite`
	#file=`basename ${inst} brite.opt`

	#solutionTest <inst>.sol <inst>.opt MODE(1 = VERB 0=noVerb)
	
	# aqui verifica o valor ótimo por solução
	#${bin} ${instances}/${inst} ${opt}/${file}.opt 1 | grep 'Cost =' | cut -d ' ' -f 3 > ${opt}/${file}.sopt

done
