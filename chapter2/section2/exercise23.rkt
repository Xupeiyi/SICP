#lang racket

(define (for-each proc items)
  (define (next)
    (proc (car items))
    (for-each proc (cdr items)))
  (if (null? items) #t (next)))

(for-each (lambda (x) (newline) (display x))
          (list 57 321 88))