#lang racket
(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (sub-interval x y)
  (add-interval x (make-interval (- (upper-bound y))
                                 (- (lower-bound y)))))

(define (interval-positive? interval) (>= (lower-bound interval) 0))

(define (interval-cross-zero? interval) (and (< (lower-bound interval) 0) (>= (upper-bound interval) 0)))

(define (interval-negative? interval) (< (upper-bound interval) 0))

(define (mul-interval x y)
  (let ((a (lower-bound x))
        (b (upper-bound x))
        (c (lower-bound y))
        (d (upper-bound y)))
        (cond ((interval-positive? x) 
               (cond ((interval-positive? y) (make-interval (* a c) (* b d)))
                     ((interval-cross-zero? y) (make-interval (* b c) (* b d)))                      
                     ((interval-negative? y) (make-interval (* b c) (* a d)))))
                    
              ((interval-cross-zero? x)
               (cond ((interval-positive? y) (make-interval (* a d) (* b d)))
                     ((interval-cross-zero? y) (make-interval (min (* a d) (* b c)) 
                                                              (max (* a c) (* b d))))
                     ((interval-negative? y) (make-interval (* b c) (* a c)))))
              ((interval-negative? x) 
               (cond ((interval-positive? y) (make-interval (* a d) (* b c)))
                     ((interval-cross-zero? y) (make-interval (* a d) (* a c)))
                     ((interval-negative? y) (make-interval (* b d) (* a c))))))))

(define (div-interval x y)
  (if (= (span y) 0)
      (error "Cannot divide an interval of 0 span")
      (mul-interval x (make-interval (/ 1.0 (upper-bound y))
                                 (/ 1.0 (lower-bound y))))))

(define (make-interval a b) (cons a b))

(define (upper-bound interval) (max (car interval) (cdr interval)))

(define (lower-bound interval) (min (car interval) (cdr interval)))

(define (span interval) (- (upper-bound interval) (lower-bound interval)))

(let ((i1 (make-interval -50 10))
      (i2 (make-interval -20 30)))
  (mul-interval i1 i2))