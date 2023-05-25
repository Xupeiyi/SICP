#lang racket
(define (fast-expt-iter n b a)
  (cond ((= n 0) a)
         ((even? n) (fast-expt-iter (/ n 2) (* b b) a))
         (else (fast-expt-iter (- n 1) b (* a b)))))

(define (fast-expt n b)
  (fast-expt-iter n b 1))