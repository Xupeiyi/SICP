#lang racket
(require "arithmetic.rkt"
         "two-dimension-table.rkt")

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

(provide install-raise)
