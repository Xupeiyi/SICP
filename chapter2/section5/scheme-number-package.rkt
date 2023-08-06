#lang racket
(require "./two-dimension-table.rkt")

(define (install-scheme-number-package) 
    (put 'add '(scheme-number scheme-number) +)
    (put 'sub '(scheme-number scheme-number) -)
    (put 'mul '(scheme-number scheme-number) *)
    (put 'div '(scheme-number scheme-number) /)
    (put 'equ? '(scheme-number scheme-number) =)
    (put 'exp '(scheme-number scheme-number) expt)

    'done)

(provide install-scheme-number-package)