#lang racket
(define (equal? a b)
  (cond ((and (null? a)
              (null? b)) #t)
        ((and (not (pair? a))
              (not (pair? b))
              (eq? a b)) #t)
        ((and (pair? a)
              (pair? b)
              (equal? (car a) (car b))
              (equal? (cdr a) (cdr b))) #t)
        (else #f)))

;; true
(equal? '() '())
(equal? 'a 'a)
(equal? '(this (is a) (list)) '(this (is a) (list)))

;; false
(equal? 'a '(a))
(equal? '(this is a list) '(this (is a) list))
(equal? 'a '())
(equal? 'a 'b)