#!/bin/bash

PROG_LIST=${1}
OUTPUT=${2}
STRATEGIES_LIST=${3}
MAX_TIME=${4}
cat ${STRATEGIES_LIST} | while read line
do
       cat ${PROG_LIST} | while read prog
       do
               items=(${line//##/ })
               strategy=${items[0]}
               model=${items[1]}
	       if [[ "${strategy}" == "feedforward" ]] || [[ "${strategy}" == "ridge" ]]; then
                       echo ${strategy}
                       echo ${model}
                       ./eval_gen_tests_coreutils.sh ${prog} ${OUTPUT} yes ${MAX_TIME} "${strategy} ${SOURCE_DIR}/${model}"
               else
                        echo ${strategy}
                        ./eval_gen_tests_coreutils.sh ${prog} ${OUTPUT} yes ${MAX_TIME} "${strategy}"
                fi
                ./replay_tests.sh ~/test/${strategy}/${prog} ${SOURCE_DIR}/benchmarks/coreutils-8.31/obj-gcov-${prog}/src/${prog} ${SOURCE_DIR}/benchmarks/coreutils-8.31/obj-gcov-${prog}
       done
done
