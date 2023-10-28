#lang racket

(require "stream.rkt")

(define factorials (cons-stream 1 (mul-streams (stream-cdr integers) factorials)))

(stream-ref factorials 0)
;Value: 1
(stream-ref factorials 1)
;Value: 2
(stream-ref factorials 2)
;Value: 6
(stream-ref factorials 3)
;Value: 24
(stream-ref factorials 4)
;Value: 120