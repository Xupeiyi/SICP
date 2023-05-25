#lang racket
(define (fact-iter n product)
  (if (= n 1) product
      (fact-iter (- n 1) (* product n))))

 (define (factorial n)
   (fact-iter n 1))