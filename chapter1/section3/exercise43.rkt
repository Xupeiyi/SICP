#lang racket

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (if (= n 1) f
      (compose f (repeated f (- n 1)))))

(define (inc x) (+ x 1))

(define (square x)(* x x))

((repeated inc 10) 2)

((repeated square 2) 5)

