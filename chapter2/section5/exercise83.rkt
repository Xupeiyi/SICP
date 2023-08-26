#lang racket
(require "arithmetic.rkt"
         "two-dimension-table.rkt"
         "utils.rkt")

(define (install-raise)
    (define (raise-scheme-number n) 
        (make-rat n 1))

    (define (raise-rat n)
        (let ((numer (car n))
              (denom (cdr n)))
            (make-complex-from-real-imag (/ numer denom) 0)))

    ;; ignored real number in this case
    (put 'raise '(scheme-number) raise-scheme-number)
    (put 'raise '(rational) raise-rat)
)

(install-raise)
(define (raise n) 
    (apply-generic 'raise n))

(define s1 5)
(raise s1) ;; '(rational 5 . 1)

(define r1 (make-rat 2 3))
(raise r1) ;; '(complex rectangular 2/3 . 0)

