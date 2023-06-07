#lang racket
(define (subsets s)
  (if (null? s)
      (list null)
      (let ((rest (subsets (cdr s))))
        (append rest
                (map (lambda (r)(cons (car s) r))
                     rest)))))

(subsets (list 1 2 3))