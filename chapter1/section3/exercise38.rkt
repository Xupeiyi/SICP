#lang racket

(define (cont-frac-recur n d k)
  (define (recur n d i)
  (if (= i k) (/ (n k) (d k))
      (/ (n i) (+ (d i) (recur n d (+ i 1))))))
  (recur n d 1))

(+ (cont-frac-recur
 (lambda (i) 1.0)
 (lambda (i) (if (= (remainder (+ i 1) 3) 0) (expt 2 (quotient (+ i 1) 3)) 1))
10000) 2)