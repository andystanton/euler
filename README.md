# Project Euler Solutions

Solutions to [Project Euler](https://projecteuler.net) problems. The solutions rely on language features only i.e. no third party libraries. Includes shell script to run source files containing a solution using appropriate Docker containers.

The problem and answer can be included in plain text files in each problem directory, e.g.

```
.
├── 1
│   ├── cpp
│   │   └── ...
│   ├── go
│   │   └── ...
│   ├── java
│   │   └── ...
│   ├── answer
│   └── problem
├── ...
├── README.md
└── euler.sh
```

These are displayed when the script is run. If there is an answer, the solutions are checked against this and output in green or red accordingly.

## Requirements

 * bash
 * docker 1.3

## Quick Start

```sh
git clone https://github.com/andystanton/euler.git && cd euler
```

To run all solutions to a given problem:

```sh
./euler.sh 1
```

To run a particular language's solution to a given problem, use the language's source extension:

```sh
./euler.sh 1 java
./euler.sh 1 py
```

## TODO

 * Output time taken for each solution to run.
 * Run each solution in a language specific container rather than rely on the host machine having each language installed.
 * Add erlang, haskell & d.
