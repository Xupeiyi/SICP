#lang racket
(require "../src/main.rkt")

(define t1 (make-dense-termlist (list 1 0 0 0 0 -1)))
(define t2 (make-dense-termlist (list 1 0 -1)))
(define result-q1 (make-dense-termlist (list 1 0 1 0)))
(define result-r1 (make-dense-termlist (list 1 -1)))
(define q1 (car (div t1 t2)))
(define r1 (cadr (div t1 t2)))
(equ? q1 result-q1)
(equ? r1 result-r1)