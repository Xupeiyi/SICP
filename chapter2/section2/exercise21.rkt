#lang racket
(define nil (list))

(define (square-list items)
  (if (null? items) nil (cons (square (car items)) (square-list (cdr items)))))

(define (square-list1 items)
  (map square items))

(define (square x) (* x x))

(square-list1 (list 1 2 3 4))