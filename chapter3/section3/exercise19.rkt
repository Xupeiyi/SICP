#lang racket
(require rnrs/mutable-pairs-6)
(require compatibility/mlist)

(define (contains-cycle? x)
    (define (iter slow fast)
            (cond ((or (null? fast) (null? (mcdr fast))) #f)
                  ((eq? slow fast) #t)
                  (else (iter (mcdr slow) (mcdr (mcdr fast)))))) 
    (iter x (mcdr x)))


(define x1 (mlist 1 2 3 4 5))

(define (make-cycle x)
    (set-mcdr! (last-pair x) x) x)

(define (last-pair x) 
    (if (null? (mcdr x)) x 
        (last-pair (mcdr x))))

(contains-cycle? x1)

(define x2 (make-cycle x1))

(contains-cycle? x2)