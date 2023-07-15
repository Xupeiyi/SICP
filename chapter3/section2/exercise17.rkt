#lang racket

(define (record-traversed x traversed)
    (if (and (pair? x) (false? (memq x traversed))) ;; if x is a pair and x not in traversed
        (record-traversed (car x) (record-traversed (cdr x) (cons x traversed)))
        traversed))

(define (count-pairs x) 
    (length (record-traversed x '())))

(define x1 '(1 2 3))

(define pair1 (cons 1 2))
(define pair2 (cons 3 pair1))
(define x2 (cons pair1 pair2))

(define pair3 (cons pair1 pair1))
(define x3 (cons pair3 pair3))

(count-pairs x1)
(count-pairs x2)
(count-pairs x3)