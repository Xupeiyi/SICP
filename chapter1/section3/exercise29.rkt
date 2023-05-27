#lang racket
(define (simpson f a b n)
  (define (h)(/ (- b a) n))
  (define (coeff k)
    (cond ((or (= k 0) (= k n)) 1)
          ((= (remainder k 2) 1) 4)
          (else 2)))
  (define (inc k)(+ k 1))
  ;; create a function of k
  (define (simpson-term k)(* (coeff k) (f (+ a (* k (h))))))
  (* (/ (h) 3) (sum simpson-term 0 inc n)))

(define (sum term a next b)
  (if (> a b) 0
  (+ (term a) (sum term (next a) next b))))

(define (cube x)
  (* x x x))

(simpson cube 0 1 1000)