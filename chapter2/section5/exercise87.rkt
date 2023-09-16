#lang racket
(define (=zero? x) (apply-generic '=zero? x))

(define (=poly-zero? p)
    (define (=termlist-zero? t)
        (if (empty-termlist? t) 
            #t
            (and (=zero? (coeff (first-term t))) 
                    (=termlist-zero? (rest-terms t)))))
    (=termlist-zero? (term-list p)))