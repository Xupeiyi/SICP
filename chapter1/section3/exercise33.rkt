#lang racket
(define (next n)
  (if (= n 2) 3
  (+ n 2)))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (square n)(* n n))

(define (prime? n)
  (if (< n 2) #f (= n (smallest-divisor n))))

(define (filtered-accumulate combiner null-value term a next b filter)
  (define (next-filtered x)
    (if (filter (next x)) (next x)
        (next-filtered (next x))))
  (if (> a b) null-value
      (combiner (term a) (filtered-accumulate combiner null-value term (next-filtered a) next-filtered b filter))))

;; question a
(define (identity x) x)
(define (inc x)(+ x 1))

(filtered-accumulate + 0 identity 0 inc 23 prime?)

;; question b
(define (gcd a b)
  (if (= b 0) a
      (gcd b (remainder a b))))

(define (product-prime n)
  (define (relatively-prime? x)
    (= (gcd n x) 1))
  (filtered-accumulate * 1 identity 1 inc n relatively-prime?))

(product-prime 12)