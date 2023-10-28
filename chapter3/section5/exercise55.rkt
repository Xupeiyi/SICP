#lang racket

(require "stream.rkt")

(define (partial-sums s)
    (cons-stream (stream-car s) 
                 (add-streams (stream-cdr s) (partial-sums s))))

(define parital-int-sums (partial-sums integers))

(stream-cdr parital-int-sums)

(stream-ref parital-int-sums 0) ;; 1
(stream-ref parital-int-sums 1) ;; 3
(stream-ref parital-int-sums 2) ;; 6
(stream-ref parital-int-sums 3) ;; 10
(stream-ref parital-int-sums 4) ;; 15
