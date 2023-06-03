#lang racket

(define (divides? a b)
  (= (remainder a b) 0))

(define (cons a b)
  (* (expt 2 a) (expt 3 b)))

(define (find-expt n x)
  (define (iter n x result)
    (if (divides? n x) (iter (/ n x) x (+ result 1)) result))
  (iter n x 0))
    
(define (car z)
  (find-expt z 2))

(define (cdr z)
  (find-expt z 3))

(car (cons 6 12))

(cdr (cons 6 12))

(car (cons 7 0))

(cdr (cons 7 0))