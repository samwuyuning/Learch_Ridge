## Test Script
1. Recompile KLEE
  - `cd ~/learch/klee`
  - `./build.sh`
2. `cd ~/learch/learch/eval` 
2. Usage: `./test_coreutils.sh [program_list.txt] [output directory] [strategy_list.txt] [max time]`
2. Example:
- program_list.txt
  - b2sum
  - base64
- strategy_list.txt
  - random-path
  - feedforward train/trained/feedforward_3.pt
  - nurs:depth
- output directory
  - ~/test
- max time (second)
  - 60
  - 1800
- `./test_coreutils.sh ${SOURCE_DIR}/benchmarks/coreutils_test.txt ~/test test_strategies.txt 1800`
3. Show Result
- python3 show_results.py --prog_list ${SOURCE_DIR}/benchmarks/coreutils_test.txt --cov_dir ~/test
       
Using Learch to test new programs
=============================================================================================================

[`eval_gen_tests_coreutils.sh`](eval_gen_tests_coreutils.sh) and [`eval_gen_tests_realworld.sh`](eval_gen_tests_realworld.sh) are used for generating tests for coreutils programs and the 10 real-world programs, respectively. The following example commands run the `random-path` strategy for `base64` and a trained Learch strategy for `diff`.
```
./eval_gen_tests_coreutils.sh base64 ~/test no 60 "random-path"
./eval_gen_tests_realworld.sh diff ${SOURCE_DIR}/benchmarks/diffutils-3.7/obj-llvm/src/diff.bc ~/test_rw 60 "feedforward ${SOURCE_DIR}/train/trained/feedforward_0.pt" "--sym-args 0 2 2 A B --sym-files 2 50 --sym-stdout"
```

The generated tests should be replayed to obtain coverage information:
```
./replay_tests.sh ~/test/random-path/base64 ${SOURCE_DIR}/benchmarks/coreutils-8.31/obj-gcov-base64/src/base64 ${SOURCE_DIR}/benchmarks/coreutils-8.31/obj-gcov-base64
./replay_tests.sh ~/test_rw/feedforward/diff ${SOURCE_DIR}/benchmarks/diffutils-3.7/obj-gcov/src/diff ${SOURCE_DIR}/benchmarks/diffutils-3.7/obj-gcov/
```

Then the coverage and the number of UBSan violations can be checked via:
```
echo "base64" >> base64.txt
python3 show_results.py --prog_list base64.txt --cov_dir ~/test
echo "diff" >> diff.txt
python3 show_results.py --prog_list diff.txt --cov_dir ~/test_rw
```
