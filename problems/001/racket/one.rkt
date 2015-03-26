#lang racket

(define (generate-range min max)
    (build-list (- max min) (lambda (x) (+ min x))))

(define (range-divisible-by-3-or-5 range)
    (filter (lambda (x) (or (= (modulo x 3) 0) (= (modulo x 5) 0))) range))

(define (sum-list list)
    (foldl + 0 list))

(write (sum-list (range-divisible-by-3-or-5 (generate-range 1 1000))))

