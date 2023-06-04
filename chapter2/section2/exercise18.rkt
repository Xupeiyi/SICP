#lang racket
(define (last-pair l)
  (if (null? (cdr l)) l
      (last-pair (cdr l))))

(define (reverse l)
  (define (iter l result)
  (if (null? l) result 
      (iter (cdr l) (cons (car l) result))))
  (iter l (list)))

(reverse (list 1 2 3 4 5))