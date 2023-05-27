#lang racket
(define (accumulate-recursive combiner null-value term a next b)
  (if (> a b) null-value
  (combiner (term a) (accumulate combiner null-value term (next a) next b))))

(define (accumulate combiner null-value term a next b)
  (define (accumulate-iter combiner term a next b result)
    (if (> a b) result
        (accumulate-iter combiner term (next a) next b (combiner (term a) result))))
  (accumulate-iter combiner term a next b null-value))

(define (sum term a next b)
  (accumulate + 0 term a next b))

(define (product term a next b)
  (accumulate * 1 term a next b))

(define (pi-sum n)
(define (pi a b)
  (define (pi-term x)(/ 1.0 (* x (+ x 2))))
  (define (pi-next x)(+ x 4))
  (sum pi-term a pi-next b))
  (* 8 (pi 1 10000)))

(define (pi-product n)
  (define (denominator k)(+ 3 (* 2 (quotient k 2))))
  (define (numerator k)(+ 2 (* 2 (quotient (+ k 1) 2))))
  (define (pi-term k)(/ (numerator k) (denominator k)))
  (define (inc x)(+ x 1))
  (* 4.0 (product pi-term 0 inc n)))

(pi-sum 1000)
(pi-product 1000)