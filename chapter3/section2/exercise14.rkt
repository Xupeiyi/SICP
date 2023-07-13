#lang racket
(require rnrs/mutable-pairs-6)
(require compatibility/mlist)

(define (mystery x)
    (define (loop x y) 
        (if (null? x) y
            (let ((tmp (mcdr x))) 
                (set-mcdr! x y) (loop tmp x))))
    (loop x '()))

(define v (mlist 'a 'b 'c 'd)) 

(define w (mystery v))

;; v: (mcons 'a '())
;; w: () (mcons 'd (mcons 'c (mcons 'b (mcons 'a '()))))