#lang racket
(define (double x)
  (+ x x))

(define (halve x)
  (/ x 2))

(define (mul-iter a b x)
  (cond ((= a 0) x)
        ((even? a) (mul-iter (halve a) (double b) x))
        (else (mul-iter (- a 1) b (+ b x)))))

(define (mul a b)
  (mul-iter a b 0))