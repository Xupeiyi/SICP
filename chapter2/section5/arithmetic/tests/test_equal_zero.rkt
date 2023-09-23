#lang racket
(require "../src/main.rkt")

;; test scheme-number
(=zero? 0)
(not (=zero? 1))

;; test rational
(=zero? (make-rational 0 1))
(not (=zero? (make-rational 1 2)))

;; test complex
(=zero? (make-complex-from-real-imag 0 0))
(not (=zero? (make-complex-from-real-imag 0 2)))
(not (=zero? (make-complex-from-real-imag 2 0)))
(=zero? (make-complex-from-mag-ang 0 1))
(not (=zero? (make-complex-from-mag-ang 1 0)))

;; test sparse-termlist 
(define cr0 (make-complex-from-real-imag 0 0))
(define cp0 (make-complex-from-mag-ang 0 1))
(define r0 (make-rational 0 5))
(define t1 (make-sparse-termlist (list (list 10 cr0) (list 7 cp0) (list 1 r0) (list 0 0))))
(define t2 (make-sparse-termlist (list (list 10 cr0) (list 7 cp0) (list 1 r0) (list 0 1))))

(=zero? t1)
(not (=zero? t2))


;; test polynomial
(define p1 (make-polynomial 'x t1))
(=zero? p1)
(define p2 (make-polynomial 'x t2))
(not (=zero? p2))
(define p3 (make-polynomial 'x (make-sparse-termlist '())))
(=zero? p3)
