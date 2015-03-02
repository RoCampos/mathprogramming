#!/bin/bash

instances=$1

opt=$2

bin=$3

for inst in `ls -vBh ${instances}`
do

	#echo $inst
	#file=`basename ${inst} .brite`
	file=`basename ${inst} brite.opt`

	#solutionTest <inst>.sol <inst>.opt MODE(1 = VERB 0=noVerb)
	${bin} ${instances}/${inst} ${opt}/${file}.opt 0

done
