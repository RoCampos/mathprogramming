#!/bin/bash

#directory where info files (.info) are stored
#these files are the info files of results
solver_instance=$1

bin="bin/optCheck"

echo -e "INSTANCE\tBEST_OBJC\tBEST_BOUND\tGAP"

for inst in `ls -vH ${solver_instance}/*.info`
do

	${bin} ${inst}

done
