#lang racket

(require "stream.rkt")

(define (mul-series s1 s2)
    (cons-stream (* (stream-car s1) (stream-car s2))
                 (add-streams (add-streams (scale-stream (stream-cdr s2) (stream-car s1))
                                           (scale-stream (stream-cdr s1) (stream-car s2)))
                              (cons-stream 0 (mul-series (stream-cdr s1) (stream-cdr s2))))))

(define (invert-series s) 
    (cons-stream 1 
                (scale-stream (mul-series (stream-cdr s) 
                                          (invert-series s)) 
                              -1)))

(define exp-series 
    (cons-stream 1 (integrate-series exp-series)))

(stream-ref exp-series 0)
(stream-ref exp-series 1)
(stream-ref exp-series 2)
(stream-ref exp-series 3)
(stream-ref exp-series 4)
(stream-ref exp-series 5)