#lang racket

(define (count-pairs x)
    (if (not (pair? x)) 0 
        (+ (count-pairs (car x))
           (count-pairs (cdr x))
           1)))


(define x1 '(1 2 3))

(define pair1 (cons 1 2))
(define pair2 (cons 3 pair1))
(define x2 (cons pair1 pair2))

(define pair3 (cons pair1 pair1))
(define x3 (cons pair3 pair3))

(count-pairs x1)
(count-pairs x2)
(count-pairs x3)

;; no return: [*][*] -> [*][*] -> [*][*]-
;;             ^                         |
;;             |_________________________|    