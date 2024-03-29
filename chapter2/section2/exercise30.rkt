#lang racket

(define (square x) (* x x))

(define (square-tree1 tree)
  (cond ((null? tree) null)
        ((not (pair? tree)) (square tree))
        (else (cons (square-tree1 (car tree))
                    (square-tree1 (cdr tree))))))

(define (square-tree2 tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (square-tree2 sub-tree)
             (square sub-tree)))
       tree))


(define t (list 1 (list 2 (list 3 4) 5) (list 6 7)))

(square-tree1 t)

(square-tree2 t)