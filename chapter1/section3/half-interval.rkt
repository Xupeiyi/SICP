#lang racket
(define (search f neg-point pos-point)
  (let ((mid-point (average neg-point pos-point)))
   (if (close-enough? neg-point pos-point) mid-point
       (let ((test-value (f mid-point)))
       (cond ((positive? test-value) (search f neg-point mid-point))
             ((negative? test-value) (search f mid-point pos-point))
             (else mid-point))))))

(define (average x y)(/ (+ x y) 2))
(define (positive? x)(> x 0))
(define (negative? x)(< x 0))

(define (close-enough? a b)(< (abs (- a b)) 0.001))

(define (half-interval-method f a b)
  (let ((a-value (f a))
        (b-value (f b)))
    (cond ((and (negative? a-value) (positive? b-value)) (search f a b))
          ((and (negative? b-value) (positive? a-value)) (search f b a))
          (else (error "Values arer not of opposite sign" a b)))))

(half-interval-method sin 2.0 4.0)