#lang racket
(require "../src/main.rkt")

;; test scheme-number add
(equ? (add 3 4) 7)

;; test rational add
(equ? (add (make-rational 1 2) (make-rational 1 3)) 
      (make-rational 5 6))

;; test complex add
(equ? (add (make-complex-from-real-imag 1 2) (make-complex-from-real-imag 3 4))
      (make-complex-from-real-imag 4 6))

;; test sparse-termlist
(define t1 (make-sparse-termlist (list (list 3 3) 
                                       (list 2 2) 
                                       (list 1 -1))))
(define t2 
        (make-sparse-termlist (list (list 2 (make-rational 1 2)) 
                                    (list 1 (make-complex-from-real-imag 1 1)))))
(define result-t1 
        (make-sparse-termlist (list (list 3 3)
                                    (list 2 (make-rational 5 2))
                                    (list 1 (make-complex-from-real-imag 0 1)))))
(equ? (add t1 t2) result-t1)

;; test polynomial
(define p1 (make-polynomial 'x t1))
(define p2 (make-polynomial 'x t2))
(define result-p1 (make-polynomial 'x result-t1))

(equ? (add p1 p2) result-p1)