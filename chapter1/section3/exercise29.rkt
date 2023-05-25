#lang racket
(define (simpson f a b n)
  ((if (> a b) 0
  (+ (term a) (sum term (next a) next b))))))