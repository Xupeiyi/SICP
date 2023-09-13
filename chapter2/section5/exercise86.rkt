#lang racket

;; add generic add, sub, mul, div and these methods to the complex number package
;; substitute the generic methods for + , -, *, /, sin, cos, atan 
(define (sine x)
  (apply-generic 'sine x))
(define (cosine x)
  (apply-generic 'cosine x))
(define (atan x)
  (apply-generic 'atan x))  
(define (sqrt x)
  (apply-generic 'sqrt x))


;; under the install-complex-package method
;; change these methods  
(define (add-complex z1 z2)
  (make-from-real-imag (add (real-part z1) (real-part z2))
                       (add (imag-part z1) (imag-part z2))))
(define (sub-complex z1 z2)
  (make-from-real-imag (sub (real-part z1) (real-part z2))
                       (sub (imag-part z1) (imag-part z2))))
(define (mul-complex z1 z2)
  (make-from-real-imag (mul (magnitude z1) (magnitude z2))
                       (add (angle z1) (angle z2))))
(define (div-complex z1 z2)
  (make-from-real-imag (div (magnitude z1) (magnitude z2))
                       (sub (angle z1) (angle z2))))

;; add these to the scheme number package
(put 'sine '(scheme-number) sin)
(put 'cosine '(scheme-number) cos)
(put 'atan '(scheme-number) atan)
(put 'sqrt '(scheme-number) sqrt)

;; add these to the rational number package
(put 'sine '(rational)
  (lambda (x) (tag (sin (/ (numer x) (denom x))))))
(put 'cosine '(rational)
     (lambda (x) (tag (cos (/ (numer x) (denom x))))))
(put 'atan '(rational) atan)
(put 'sqrt '(rational) (lambda (x) (/ (sqrt (numer x)) (sqrt (denom x)))))

