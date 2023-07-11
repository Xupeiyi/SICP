#lang racket
(define (make-f prev curr) 
    (lambda (x) (begin (set! prev curr) (set! curr x) prev)))

(define f1 (make-f 0 0))

(+ (f1 0) (f1 1)) ;; 0

(define f2 (make-f 0 0))

(+ (f2 1) (f2 0)) ;; 1