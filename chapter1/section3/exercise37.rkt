#lang racket
(define (cont-frac-recur n d k)
  (define (recur n d i)
  (if (= i k) (/ (n k) (d k))
      (/ (n i) (+ (d i) (recur n d (+ i 1))))))
  (recur n d 1))

(cont-frac-recur (lambda (i) 1.0) (lambda (i) 1.0) 1000)

(define (cont-frac-iter n d k)
  (define (iter n d i result)
    (if (= i 1) result
        (iter n d (- i 1) (/ (n i) (+ (d i) result)))))
  (iter n d k 0))

(cont-frac-iter (lambda (i) 1.0) (lambda (i) 1.0) 1000)