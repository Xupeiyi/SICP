#lang racket
(require "stream.rkt")

(define (interleave s1 s2)
    (if (stream-null? s1) s2 
        (cons-stream (stream-car s1) 
                     (interleave s2 (stream-cdr s1)))))

(define (pairs s t)
    (cons-stream (list (stream-car s) (stream-car t))
                 (interleave
                    (interleave (stream-map (lambda (x) (list (stream-car s) x)) (stream-cdr t))
                                (stream-map (lambda (x) (list x (stream-car t))) (stream-cdr s)))         
                    (pairs (stream-cdr s) (stream-cdr t)))))

(define s (pairs integers integers))

(stream-ref s 0)
(stream-ref s 1)
(stream-ref s 2)
(stream-ref s 3)
(stream-ref s 4)
(stream-ref s 5)
(stream-ref s 6)
(stream-ref s 7)
(stream-ref s 8)
(stream-ref s 9)
