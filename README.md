Learch: a Learning-based Strategies for Path Exploration in Symbolic Execution
=============================================================================================================

We have tested several deep learning and regression model on KLEE on the basis of Learch. The directory `klee` contains our modified KLEE code (from [this commit](https://github.com/klee/klee/tree/95ce1601c380341ef3b1043644c66be754e345c0)) and `learch` contains the modified Learch code and saved models. Original work of Learch was developed at [SRI Lab, Department of Computer Science, ETH Zurich](https://www.sri.inf.ethz.ch/) as part of the [Machine Learning for Programming](https://www.sri.inf.ethz.ch/research/plml) project. For more details of the original Learch, please refer to [Learch CCS'21 paper](https://files.sri.inf.ethz.ch/website/papers/ccs21-learch.pdf).

## Setup
Initialize with Docker. To build and run:
```
$ docker build -t learch .
$ docker run -it learch
```

## Authors
* Xiecongyou Yang
* Yimeng He
* Yuning Wu
* William Li
