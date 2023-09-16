#lang racket
(require "../src/main.rkt")

;; test scheme-number add
(equ? (add 3 4) 7)

;; test rational add
(equ? (add (make-rat 1 2) (make-rat 1 3)) 
      (make-rat 5 6))

;; test complex add
(equ? (add (make-complex-from-real-imag 1 2) (make-complex-from-real-imag 3 4))
      (make-complex-from-real-imag 4 6))