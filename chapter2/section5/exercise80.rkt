#lang racket

(define (install-scheme-number-package) 
    ;; ...
    (put '=zero? '(scheme-number) (lambda (n) (= n 0))))


(define (install-rational-package)
    ;; ...
    (define (=zero? n) (= (numer n) 0))     
    (put '=zero? '(rational) =zero?)
    'done)


(define (install-complex-package)
    (put '=zero? '(complex) (lambda (n) (= (magnitude n) 0))))


