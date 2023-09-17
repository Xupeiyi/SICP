#lang racket
(require "../src/main.rkt")

;; scheme-number
(equ? (negate 1) -1)

;; rational
(equ? (negate (make-rational 2 3)) (make-rational -2 3))

;; complex
(equ? (negate (make-complex-from-real-imag 2 3)) 
      (make-complex-from-real-imag -2 -3))
(equ? (make-complex-from-mag-ang 2 1)
      (negate (negate (make-complex-from-mag-ang 2 1))))

;; polynomial
(define t1 (list (list 5 2) 
                 (list 3 (make-rational 3 7)) 
                 (list 2 (make-complex-from-real-imag 1 3)) 
                 (list 0 -7)))
(define p1 (make-polynomial 'x t1))
(define t2 (list (list 5 -2)
                 (list 3 (make-rational -3 7)) 
                 (list 2 (make-complex-from-real-imag -1 -3)) 
                 (list 0 7)))
(define p2 (make-polynomial 'x t2))
(equ? (negate p1) p2)
