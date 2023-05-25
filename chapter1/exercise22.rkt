#lang racket
(#%require (only racket/base current-milliseconds))
(define (runtime) (current-milliseconds))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (when (prime? n)
      (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (square n)(* n n))


(define (search-for-primes start end)
  (define (search-for-primes-iter curr)
    (when (< curr end) (timed-prime-test curr))
    (when (< curr end) (search-for-primes-iter (+ 1 curr))))
  (search-for-primes-iter start))

(search-for-primes )