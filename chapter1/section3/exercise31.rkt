#lang racket
(define (product-recursive term a next b)
  (if (> a b) 1
      (* (term a) (product term (next a) next b))))

(define (product term a next b)
  (define (product-iter term a next b result)
  (if (> a b) result
      (product-iter term (next a) next b (* (term a) result))))

  (product-iter term a next b 1))


(define (factorial n)
  (define (inc x)(+ x 1))
  (define (identity x) x)
  (product identity 1 inc n))

(factorial 6)

(define (pi n)
  (define (denominator k)(+ 3 (* 2 (quotient k 2))))
  (define (numerator k)(+ 2 (* 2 (quotient (+ k 1) 2))))
  (define (pi-term k)(/ (numerator k) (denominator k)))
  (define (inc x)(+ x 1))
  (* 4.0 (product pi-term 0 inc n)))





(pi 10000)