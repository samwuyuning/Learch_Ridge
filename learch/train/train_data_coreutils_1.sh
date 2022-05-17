#!/bin/bash

PROG_LIST=${1}

STRATEGIES=('random-path' 'nurs:cpicnt' 'nurs:depth')
for strategy in "${STRATEGIES[@]}"
do
       cat ${PROG_LIST} | while read prog
       do 
	       ./train_data.sh ${prog} ~/train_data 1800 0 ${strategy}
       done
done       
