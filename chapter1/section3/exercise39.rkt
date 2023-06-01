#lang racket

(define (cont-frac-recur n d k)
  (define (recur n d i)
  (if (= i k) (/ (n k) (d k))
      (/ (n i) (+ (d i) (recur n d (+ i 1))))))
  (recur n d 1))

(define (tan-cf x k)
  (define (n i) (if (= i 1) x (* x x -1)))
  (define (d i) (- (* 2 i) 1))
  (cont-frac-recur n d k))


(tan-cf (/ 3.1415926 4) 100000)
(tan-cf (/ 3.1415926 2) 100000)
(tan-cf (* 3.1415926 0.75) 10000)
(tan-cf 3.1415926 100000)