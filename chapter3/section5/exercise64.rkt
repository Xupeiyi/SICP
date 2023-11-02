#lang racket
(require "stream.rkt")

(define (average x y)
    (/ (+ x y) 2))

(define (sqrt-improve guess x)
    (average guess (/ x guess)))

(define (sqrt-stream x)
    (define guesses
        (cons-stream 1.0 
                     (stream-map (lambda (guess) (sqrt-improve guess x)) guesses)))
    guesses)

(define (stream-limit s tolerance)
    (let ((first-term (stream-car s))
          (next-term (stream-car (stream-cdr s))))
         (if (< (abs (- first-term next-term)) tolerance)
             next-term
             (stream-limit (stream-cdr s) tolerance))))

(define (sqrt x tolerance)
    (stream-limit (sqrt-stream x) tolerance))

(sqrt 1000 0.1)