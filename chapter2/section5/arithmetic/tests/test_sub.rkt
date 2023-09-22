#lang racket
(require "../src/main.rkt")

;; test scheme-number add
(equ? (sub 3 4) -1)

;; test rational add
(equ? (sub (make-rational 1 2) (make-rational 1 3)) 
      (make-rational 1 6))

;; test complex add
(equ? (sub (make-complex-from-real-imag 1 2) (make-complex-from-real-imag 3 4))
      (make-complex-from-real-imag -2 -2))

(define t1 (list (list 3 3) 
                 (list 2 2) 
                 (list 1 -1)))
(define p1 (make-polynomial 'x (make-sparse-termlist t1)))


(define t2 (list (list 2 (make-rational 1 2)) 
                 (list 1 (make-complex-from-real-imag 1 1))))

(define p2 (make-polynomial 'x (make-sparse-termlist t2)))

(define result-t1 (list (list 3 3)
                        (list 2 (make-rational 3 2))
                        (list 1 (make-complex-from-real-imag -2 -1))))
(define result-p1 (make-polynomial 'x (make-sparse-termlist result-t1)))
(equ? (sub p1 p2) result-p1)