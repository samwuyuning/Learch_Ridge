#!/bin/bash

PROG_LIST=${1}

STRATEGIES=('sgs:1' 'sgs:2' 'sgs:4')
for strategy in "${STRATEGIES[@]}"
do
       tac ${PROG_LIST} | while read prog
       do
               ./train_data.sh ${prog} ~/train_data 1800 0 ${strategy}
       done
done
