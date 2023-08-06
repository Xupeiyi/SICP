#lang racket
;; a) it will result in an infinite loop, as the program will
;; keep coercing 'complex to 'complex and looking for an operation for 'exp '(complex complex)

;; b) No

;; c) apply-generic reimplemented in utils.rkt
(require "./arithmetic.rkt")

(define c1 (make-complex-from-real-imag 1 2))
(define c2 (make-complex-from-real-imag 3 4))
(exp c1 c2) ;; raises error