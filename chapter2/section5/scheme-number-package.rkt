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
    (put 'sine '(scheme-number) sin)
    (put 'cosine '(scheme-number) cos)
    (put 'atan '(scheme-number) atan)
    (put 'sqrt '(scheme-number) sqrt)
    'done)

(provide install-scheme-number-package)

(atan 1 1)