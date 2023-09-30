#lang racket
#|
(define (count-leaves x)
  (cond (((null? x) 0)
         ((not (pair? x)) 1)
         (else (+ (count-leaves (car x))
                  (count-leaves (cdr x)))))))
|#

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define tree (list (list 1 2 3 4) (list (list (list 5) 6 7 (list 8 9)))))

(define (count-leaves t)
  (accumulate + 
              0 
              (map (lambda (x) 
                           (if (pair? x) (count-leaves x) 1)) t)))

(count-leaves tree)
(count-leaves '())