#lang racket
(define (make-segment p1 p2)
  (cons p1 p2))

(define (start-segment s)
  (car s))

(define (end-segment s)
  (cdr s))

(define (make-point x y)
  (cons x y))

(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))

(define (square x) (* x x))

(define (distance point1 point2)
  (sqrt (+ (square (- (x-point point1) (x-point point2)))
           (square (- (y-point point1) (y-point point2))))))


(define (area rect)(* (width rect) (height rect)))

(define (perimeter rect)(* (+ (width rect) (height rect)) 2))

;;implementation 1

#|
(define (make-rectangle diagonal1 diagonal2)
                (cons diagonal1 diagonal2))

(define (diagonal1 rect)(car rect))

(define (diagonal2 rect)(cdr rect))

(define (width rect)
  (distance (start-segment (diagonal1 rect))
            (start-segment (diagonal2 rect))))

(define (height rect)
  (distance (start-segment (diagonal1 rect))
            (end-segment (diagonal2 rect))))

(let ((p1 (make-point 0 0))
      (p2 (make-point 5 1))
      (p3 (make-point -1 5))
      (p4 (make-point 4 6)))
  (area (make-rectangle (make-segment p1 p4) (make-segment p2 p3))))
|#

(define (make-rectangle side1 side2)
                (cons side1 side2))

(define (side1 rect)(car rect))

(define (side2 rect)(cdr rect))

(define (width rect)
  (distance (start-segment (side1 rect))
            (end-segment (side1 rect))))

(define (height rect)
  (distance (start-segment (side2 rect))
            (end-segment (side2 rect))))

(let ((p1 (make-point 0 0))
      (p2 (make-point 5 1))
      (p3 (make-point -1 5))
      (p4 (make-point 4 6)))
  (area (make-rectangle (make-segment p1 p2) (make-segment p1 p3))))
