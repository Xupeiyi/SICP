#lang racket

(require "stream.rkt")

(define (integral integrand initial-value dt)
    (define int 
        (cons-stream initial-value 
                     (scale-stream integrand dt)))
    int)

(define (RC R C dt)
    (define (voltage i v0)
        (add-streams (scale-stream i R)
                     (integral (scale-stream i (/ 1 C)) v0 dt)))
    voltage)