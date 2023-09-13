#lang racket
(require "./two-dimension-table.rkt"  
         "./utils.rkt"
         "./scheme-number-package.rkt"
         "./rational-package.rkt"
         "./complex-package.rkt")

(install-scheme-number-package)
(install-rational-package)
(install-rectangular-package)
(install-polar-package)
(install-complex-package)

(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))
(define (exp x y) (apply-generic 'exp x y))
(define (equ? x y) (apply-generic 'equ? x y))

;; (define (real-part x) (apply-generic 'real-part x))
;; (define (imag-part x) (apply-generic 'imag-part x))
;; (define (numer x) (apply-generic 'numer x))

(define (make-complex-from-real-imag x y)
    ((get 'make-from-real-imag 'complex) x y))

(define (make-complex-from-mag-ang r a)
    ((get 'make-from-mag-ang 'complex) r a))

; (define (scheme-number->complex n)
;         (make-complex-from-real-imag (contents n) 0))

(define (make-rat n d)
    ((get 'make 'rational) n d))

; (put-coercion 'scheme-number 'complex scheme-number->complex)

(define r1 (make-rat 5 2))
(define r2 (make-rat 7 2))
(define c1 (make-complex-from-real-imag 5.5 2))
(define c2 (make-complex-from-real-imag 2.5 2))

(add r1 r2) ;; 6

(sub c1 c2) ;; 1

(sub c1 r1) ;; 3 + 2i

(mul (make-complex-from-real-imag 0.7071 0.7071) 2) ;; polar(2, pi/4)

(div (make-complex-from-mag-ang 1 1) 2) ;; polar(1/2, 1)

(exp 3 3)

(provide add sub mul div equ? exp 
         make-complex-from-mag-ang make-complex-from-real-imag 
         make-rat)