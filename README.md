# Project Euler Solutions

Solutions to [Project Euler](https://projecteuler.net) problems. The solutions rely on language features only i.e. no third party libraries. Includes shell script to run source files containing a solution.

The problem and answer can be included in plain text files in each problem directory, e.g.

```
.
├── 1
│   ├── answer
│   ├── cpp
│   │   └── ...
│   ├── go
│   │   └── ...
│   ├── java
│   │   └── ...
│   └── problem
├── ...
├── README.md
└── euler.sh
```

The problem and answer are printed out when the script is run. If there is an answer, the solutions are checked against this and output in green or red accordingly.

## Quick Start

```sh
git clone https://github.com/andystanton/euler.git && cd euler

./euler.sh 1
```

## Supported Languages

 * python 3
 * ruby 2
 * java 8
 * scala 2.11
 * go 1.3
 * rust 0.13
 * c
 * c++ 11
 * node js 0.10.33
 * groovy 2.3
 * coffeescript 1.8


## TODO

 * Output time taken for each solution to run.
 * Run each solution in a language specific container rather than rely on the host machine having each language installed.
 * Add erlang, haskell & d.
