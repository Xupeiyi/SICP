#lang racket

(require "constraints.rkt")

(define (averager a b c)
    (let ((d (make-connector))
          (e (make-connector)))
        (adder a b d)
        (constant 2 e)
        (multiplier c e d)
        'ok))

(define A (make-connector))
(define B (make-connector))
(define C (make-connector))

(averager A B C)

(probe "a" A)
(probe "b" B)
(probe "c" C)

(set-value! A 10 'user)
(set-value! B 20 'user)
;;(set-value! C 30 'user) -- contradiction error
(forget-value! C 'user)
(forget-value! B 'user)
(has-value? B)

(set-value! C 100 'user)

