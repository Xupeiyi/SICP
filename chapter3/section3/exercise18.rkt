#lang racket
(require rnrs/mutable-pairs-6)
(require compatibility/mlist)

(define (contains-cycle? x)
    (let ((visited '()))
        (define (visited? head) (memq head visited))
        (define (traverse head)
            (if (visited? head) 
                #t
                (begin 
                    (set! visited (cons head visited))
                    (if (null? (mcdr head)) #f
                    (traverse (mcdr head))))))
        (traverse x)))


(define x1 (mlist 1 2 3))

(define (make-cycle x)
    (set-mcdr! (last-pair x) x) x)

(define (last-pair x) 
    (if (null? (mcdr x)) x 
        (last-pair (mcdr x))))

(contains-cycle? x1)

(define x2 (make-cycle x1))

(contains-cycle? x2)
