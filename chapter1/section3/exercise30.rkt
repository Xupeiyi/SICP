#lang racket
(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        0
        (iter (next a) (+ result (term a)))))
  (iter a 0))