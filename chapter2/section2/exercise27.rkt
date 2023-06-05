#lang racket
(define (deep-reverse x)
  (if (not (pair? x)) x
       (append (deep-reverse (cdr x))
               (list (deep-reverse (car x))))))

(define items1 (list (list 1 2) (list 3 4 5) (list 6 7 8 9)))

(deep-reverse items1)
(define items2 (list 1 2 (list 3 4) 5))

(deep-reverse items2)
(deep-reverse (list 1 2 3 4 5))

(define items3 (list (list 1 2 3)))
(deep-reverse items3)

(deep-reverse (list))