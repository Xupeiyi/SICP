#lang racket

;; 

(define (adjoin-term term term-list) 
    (define (adjoin-term-iter term term-list order-diff) 
        (if (= order-diff 1)
            (cons (coeff term) term-list)
            (adjoin-term-iter term (cons 0 term-list (- order-diff 1)))))
    (if (=zero? (coeff term)) 
        term-list 
        (adjoin-term-iter term term-list (- (order term) 
                                            (- (length term-list) 1)))))
(define (the-empty-termlist) '())
(define (first-term term-list) 
    (make-term (- (length term-list) 1) 
                (car term-list)))
(define (rest-terms term-list) (cdr term-list))
(define (empty-termlist? term-list) (null? term-list))
(define (make-term order coeff) (list order coeff))
(define (order term) (car term))
(define (coeff term) (cadr term))

(define (=zero? x) (= x 0))