#lang racket
(require "./two-dimension-table.rkt"  
         "./generic.rkt"
         "./scheme-number-package.rkt"
         "./rational-package.rkt"
         "./complex-package.rkt"
         "polynomial/dense-termlist.rkt"
         "polynomial/sparse-termlist.rkt"
         "polynomial/polynomial.rkt")

(install-scheme-number-package)
(install-rational-package)
(install-rectangular-package)
(install-polar-package)
(install-complex-package)

(install-dense-termlist-package)
(install-sparse-termlist-package)
(install-polynomial-package)

; (define (add x y) (apply-generic 'add x y))
; (define (sub x y) (apply-generic 'sub x y))
; (define (mul x y) (apply-generic 'mul x y))
; (define (div x y) (apply-generic 'div x y))
; (define (exp x y) (apply-generic 'exp x y))
; (define (equ? x y) (apply-generic 'equ? x y))
; (define (=zero? x) (apply-generic '=zero? x))
; (define (sine x) (apply-generic 'sine x))
; (define (cosine x) (apply-generic 'cosine x))

(define (make-complex-from-real-imag x y)
    ((get 'make-from-real-imag 'complex) x y))

(define (make-complex-from-mag-ang r a)
    ((get 'make-from-mag-ang 'complex) r a))

(define (make-rational n d)
    ((get 'make 'rational) n d))

(define (make-polynomial var terms)
    ((get 'make 'polynomial) var terms))

(define (make-dense-termlist args) 
    ((get 'make 'dense-termlist) args))

(define (make-sparse-termlist args) 
    ((get 'make 'sparse-termlist) args))

; (put-coercion 'scheme-number 'complex scheme-number->complex)

; (define r1 (make-rational 5 2))
; (define r2 (make-rational 7 2))
; (define c1 (make-complex-from-real-imag 5.5 2))
; (define c2 (make-complex-from-real-imag 2.5 2))

; (add r1 r2) ;; 6

; (sub c1 c2) ;; 1

; (sub c1 r1) ;; 3 + 2i

; (mul (make-complex-from-real-imag 0.7071 0.7071) 2) ;; polar(2, pi/4)

; (div (make-complex-from-mag-ang 1 1) 2) ;; polar(1/2, 1)

; (exp 3 3) ;; 27

; (sine 1)

; (cosine 1)

; (sine (make-rational 3537115888337719 6755399441055744)) ;; pi / 6

; (cosine (make-rational 3537115888337719 3377699720527872)) ;; pi / 3

; (define c3 (make-complex-from-real-imag (make-rational 5 2) 2))
; (define c4 (make-complex-from-real-imag 2 (make-rational 5 2)))

; (mul c3 c4) ;; 0 + 10.25i = '(complex polar 10.25 . 1.5707963267948966)

(provide add sub mul div equ? exp =zero? sine cosine negate
         make-complex-from-mag-ang make-complex-from-real-imag 
         make-rational make-polynomial make-dense-termlist make-sparse-termlist)