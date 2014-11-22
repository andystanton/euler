# Project Euler Solutions

Solutions to [Project Euler](https://projecteuler.net) problems. The solutions are written in a variety of languages and must rely on features of that language only i.e. no third party libraries.

Solutions are executed through Docker containers which contain the necessary compilers and runtimes for each language. There may be several solutions per language.

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

If present, these are displayed when the script is run and in particular if there is an answer, the solutions are checked against this and output in green or red accordingly.

## Requirements

 * bash
 * gnu core utils & perl
 * docker 1.3

A good internet connection and disk space is also required as the Docker images are several hundred MB each and 15+ languages are supported.

## Quick Start

```sh
git clone https://github.com/andystanton/euler.git && cd euler
```

To run all solutions to a given problem:

```sh
./euler.sh 1
```

To run a solution to a given problem for a particular language, use the language's source extension:

```sh
./euler.sh 1 java
./euler.sh 1 py
```
