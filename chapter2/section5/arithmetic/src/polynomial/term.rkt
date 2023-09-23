#lang racket

(require "../two-dimension-table.rkt" "../generic.rkt")

; (define (add x y) (apply-generic 'add x y))
; (define (sub x y) (apply-generic 'sub x y))
; (define (=zero? x) (apply-generic '=zero? x))

(define (install-term-package)
    (define (make-term order coeff) (list order coeff))
    (define (order term) (car term))
    (define (coeff term) (cadr term))
    (define (tag t) (attach-tag 'term t))
    (put 'order '(term) order)
    (put 'coeff '(term) coeff)
    (put 'make 'term 
        (lambda (order coeff) (tag (make-term order coeff))))
    'done)

(install-term-package)

(define (make-term order coeff) 
    ((get 'make 'term) order coeff))

(define (coeff t) (apply-generic 'coeff t))

(define (order t) (apply-generic 'order t))

; (define (tag t) (attach-tag 'term t))
; (define (make-term order coeff) (tag (list order coeff)))
; (define (order term) (car term))
; (define (coeff term) (cadr term))

(install-term-package)

(provide make-term coeff order)