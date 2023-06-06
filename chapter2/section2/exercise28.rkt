#lang racket

(define (fringe tree)
  (define (iter t result)
    (cond ((null? t) result)
          ((not (pair? t)) (append result (list t))) 
          (else (iter (cdr t) (iter (car t) result)))))
  (iter tree (list)))


(define x1 (list (list 1 2) (list 3 4) 5))
(fringe x1)

(define x2 (list (list 1 2 (list 1 (list 3))) (list 3 4) 5))
(fringe x2)

(define x3 (list 5 4))
(fringe x3)

(define x4 (list))
(fringe x4)

(define x5 (list x1 x1))
(fringe x5)