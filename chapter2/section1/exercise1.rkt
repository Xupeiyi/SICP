#lang racket

(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))

(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y))))

(define (equal-rat? x y)
  (= (* (numer x) (denom y)) (* (numer y) (denom x))))

(define (gcd a b)(if (= b 0) a (gcd b (remainder a b))))

(define (make-rat n d)
  (let ((g (if (> (* n d) 0) (gcd n d) (* -1 (gcd n d))))) (cons (/ n g) (/ d g))))

(define (numer x) (car x))

(define (denom x) (cdr x))

(define (print-rat x)
  (newline)s
  (display (numer x))
  (display "/")
  (display (denom x)))

(print-rat (make-rat 1 3))
(print-rat (make-rat -1 3))
(print-rat (make-rat 1 -3))
(print-rat (make-rat -1 -3))