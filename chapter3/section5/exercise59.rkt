#lang racket

(require "stream.rkt")

;; a
(define (integrate-series s)
    (div-streams s integers))

;; b
(define cosine-series 
    (cons-stream 1 (integrate-series (scale-stream sine-series -1))))

(define sine-series
    (cons-stream 0 (integrate-series cosine-series)))

(stream-ref cosine-series 0)
(stream-ref cosine-series 1)
(stream-ref cosine-series 2)
(stream-ref cosine-series 3)
(stream-ref cosine-series 4)
(stream-ref cosine-series 5)
(stream-ref cosine-series 6)


(stream-ref sine-series 0)
(stream-ref sine-series 1)
(stream-ref sine-series 2)
(stream-ref sine-series 3)
(stream-ref sine-series 4)
(stream-ref sine-series 5)
(stream-ref sine-series 6)