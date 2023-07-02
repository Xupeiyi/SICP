#lang racket

(define (par1 r1 r2) 
    (div-interval (mul-interval r1 r2)
                  (add-interval r1 r2)))

(define (par2 r1 r2) 
    (let ((one (make-interval 1 1)))
         (div-interval one (add-interval (div-interval one r1) 
                                         (div-interval one r2)))))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (sub-interval x y)
  (add-interval x (make-interval (- (upper-bound y))
                                 (- (lower-bound y)))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4) (max p1 p2 p3 p4))))

(define (div-interval x y)
  (if (= (span y) 0)
      (error "Cannot divide an interval of 0 span")
      (mul-interval x (make-interval (/ 1.0 (upper-bound y))
                                 (/ 1.0 (lower-bound y))))))

(define (make-interval a b) (cons a b))

(define (upper-bound interval) (max (car interval) (cdr interval)))

(define (lower-bound interval) (min (car interval) (cdr interval)))

(define (span interval) (- (upper-bound interval) (lower-bound interval)))

(define (make-center-percent c p)
    (let ((width (* c (/ p 100)))) 
        (make-center-width c width)))

(define (make-center-width c w) 
    (make-interval (- c w) (+ c w)))

(define (percent i) 
    (* (/ (width i) (center i)) 100))

(define (center i)
    (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width i) 
    (/ (- (upper-bound i) (lower-bound i)) 2))


;; (define A (make-interval 1 5)) ;; result: '(0.3076923076923077 . 8.0)
;; (define B (make-interval 4 8)) ;; result: '(0.8 . 3.0769230769230766)
(define A (make-center-percent 5 1))
(define B (make-center-percent 10 1))

(center (par1 A B))
(percent (par1 A B))

(center (par2 A B))
(percent (par2 A B))

(div-interval A A)
(div-interval A B)