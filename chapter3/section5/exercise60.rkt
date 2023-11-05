#lang racket

(require "stream.rkt")

;; a
(define (integrate-series s)
    (div-streams s integers))

;; b
;; (somehow the result is not correct)
(define cosine-series 
    (cons-stream 1 (integrate-series (scale-stream sine-series -1))))

(define sine-series
    (cons-stream 0 (integrate-series cosine-series)))

(define (mul-series s1 s2)
    (cons-stream (* (stream-car s1) (stream-car s2))
                 (add-streams (add-streams (scale-stream (stream-cdr s2) (stream-car s1))
                                           (scale-stream (stream-cdr s1) (stream-car s2)))
                              (cons-stream 0 (mul-series (stream-cdr s1) (stream-cdr s2))))))

(define cos2x-plus-sin2x 
    (add-streams (mul-streams cosine-series cosine-series)
                 (mul-streams sine-series sine-series)))

; (define cos2x (mul-streams integers integers))
; (stream-ref cos2x 0)
; (stream-ref cos2x 1)
; (stream-ref cos2x 2)
; (stream-ref cos2x 3)

(stream-ref cos2x-plus-sin2x 0)
(stream-ref cos2x-plus-sin2x 1)
(stream-ref cos2x-plus-sin2x 2)
(stream-ref cos2x-plus-sin2x 3)
(stream-ref cos2x-plus-sin2x 4)
(stream-ref cos2x-plus-sin2x 5)
