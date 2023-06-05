#lang racket
(define (same-parity . items)
  (define (is-same x)
    (= (remainder x 2)
       (remainder (car items) 2)))
  (define (recur x)
    (if (null? x) null
        (if (is-same (car x)) (cons (car x) (recur (cdr x)))
            (recur (cdr x)))))
  (recur items))

(same-parity 1 2 3 4 5 6 7)

(same-parity 2 3 4 5 5 6 7)