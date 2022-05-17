#!/bin/bash

TESTS_DIR=${1}
GCOV_PATH=${2}
GCOV_DIR=${3}

find ${TESTS_DIR} -type f -name *.gcno | while read f
do
    rm ${f}
done

find ${TESTS_DIR} -type f -name *.gcda | while read f
do
    rm ${f}
done

find ${GCOV_DIR} -type f -name *.gcda | while read f
do
    rm ${f}
done

#${SOURCE_DIR}/replay.sh ${GCOV_PATH} ${TESTS_DIR}/*.ktest
COUNTER=0
FILES=$(ls $TESTS_DIR | sort -g)
for FILE in $FILES; 
do 
    if [[ $FILE == *.ktest ]]
    then
        ${SOURCE_DIR}/replay.sh ${GCOV_PATH} ${TESTS_DIR}/${FILE}
    fi
    if [[ $FILE == *.log_10mins ]]
    then
        let COUNTER=COUNTER+10
        find ${GCOV_DIR} -type f -name *.gcda | while read f
        do
            mkdir -p ${TESTS_DIR}/${COUNTER}/$(dirname ${f})
            cp ${f} ${TESTS_DIR}/${COUNTER}/${f}
        done

        find ${GCOV_DIR} -type f -name *.gcno | while read f
        do
            mkdir -p ${TESTS_DIR}/${COUNTER}/$(dirname ${f})
            cp ${f} ${TESTS_DIR}/${COUNTER}/${f}
        done
    fi
done

find ${GCOV_DIR} -type f -name *.gcda | while read f
do
    mkdir -p ${TESTS_DIR}/$(dirname ${f})
    cp ${f} ${TESTS_DIR}/${f}
done

find ${GCOV_DIR} -type f -name *.gcno | while read f
do
    mkdir -p ${TESTS_DIR}/$(dirname ${f})
    cp ${f} ${TESTS_DIR}/${f}
done

rm -rf /tmp/klee-replay-*