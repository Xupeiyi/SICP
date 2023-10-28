#lang racket

(require "./stream.rkt")

;; pi / 4 = 1 - 1/3 + 1/5 - 1/7
(define (pi-summands n)
    (cons-stream (/ 1.0 n) 
                 (stream-map - (pi-summands (+ n 2)))))

(define (square x) (* x x))

(define (euler-transform s)
    (let ((s0 (stream-ref s 0))
          (s1 (stream-ref s 1))
          (s2 (stream-ref s 2)))
         (cons-stream (- s2 (/ (square (- s2 s1)) 
                               (+ s0 (* -2 s1) s2)))
                      (euler-transform (stream-cdr s)))))

(define (make-tableau transform s)
    (cons-stream s (make-tableau transform (transform s))))

(define (accelerated-sequence transform s)
    (stream-map stream-car (make-tableau transform s)))

(define pi-stream 
    (scale-stream (partial-sums (pi-summands 1)) 4))

(define accelerated-pi-stream (euler-transform pi-stream))

(define super-accelerated-pi-stream (accelerated-sequence euler-transform pi-stream))

(stream-ref pi-stream 8)
(stream-ref accelerated-pi-stream 8)
(stream-ref super-accelerated-pi-stream 8)
