#lang racket
(define (f-iter x y z count)
  (if (< count 3) x
      (f-iter (+ x (* 2 y) (* 3 z)) x y (- count 1))))

(define (f count)
  (f-iter 2 1 0 count))

(define (f-recursive count)
  (if (< count 3) count
      (+ (f-recursive (- count 1))
         (* 2 (f-recursive (- count 2)))
         (* 3 (f-recursive (- count 3))))))
  