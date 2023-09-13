#lang racket
(require "./two-dimension-table.rkt")

(define (install-scheme-number-package) 
    (put 'add '(scheme-number scheme-number) +)
    (put 'sub '(scheme-number scheme-number) -)
    (put 'mul '(scheme-number scheme-number) *)
    (put 'div '(scheme-number scheme-number) /)
    (put 'equ? '(scheme-number scheme-number) =)
    (put 'exp '(scheme-number scheme-number) expt)
    (put 'equ? '(scheme-number scheme-number) =)
    (define (raise-scheme-number n) 
        ((get 'make 'rational) n 1))
    (put 'raise 'scheme-number raise-scheme-number)
    'done)

(provide install-scheme-number-package)