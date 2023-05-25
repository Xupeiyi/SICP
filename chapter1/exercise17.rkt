#lang racket
(define (double x)
  (+ x x))

(define (halve x)
  (/ x 2))

(define (mul a b)
  (cond ((= a 0) 0)
        ((even? a) (mul (halve a) (double b)))
        (else (+ b (mul (- a 1) b)))))
