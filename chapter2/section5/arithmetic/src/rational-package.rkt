#lang racket
(require "two-dimension-table.rkt" "generic.rkt")

(define (install-rational-package)
    (define (numer x) (car x))
    (define (denom x) (cdr x))
    (define (make-rat n d) 
        (let ((g (gcd n d)))
             (cons (/ n g) (/ d g))))
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
    (define (negate-rat r) 
        (make-rat (* -1 (numer r)) (denom r)))
    (define (equ? x y)
        (and (= (numer x) (numer y))
             (= (denom x) (denom y))))
    (define (=zero? n) (= (numer n) 0))
    (define (project-rat n) (numer n))
    (define (raise-rat n)
        (let ((numer (car n))
              (denom (cdr n)))
            ((get 'make-from-real-imag 'complex) (/ numer denom) 0)))
    (define (tag x) (attach-tag 'rational x))
    (put 'add '(rational rational)
        (lambda (x y) (tag (add-rat x y))))
    (put 'sub '(rational rational)
        (lambda (x y) (tag (sub-rat x y))))
    (put 'mul '(rational rational)
        (lambda (x y) (tag (mul-rat x y))))
    (put 'div '(rational rational)
        (lambda (x y) (tag (div-rat x y))))
    (put 'negate '(rational) (lambda (n) (tag (negate-rat n))))
    (put 'sine '(rational) 
        (lambda (x) (sin (/ (numer x) (denom x)))))
    (put 'cosine '(rational) 
        (lambda (x) (cos (/ (numer x) (denom x)))))
    (put 'atan '(rational) 
        (lambda (x) (atan (/ (numer x) (denom x)))))
    (put 'make 'rational (lambda (n d) (tag (make-rat n d))))
    (put 'equ? '(rational rational) equ?)
    (put '=zero? '(rational) =zero?)
    (put 'project 'rational project-rat)
    (put 'raise 'rational raise-rat)
    (put 'sqrt '(rational) (lambda (x) (/ (sqrt (numer x)) (sqrt (denom x)))))
    'done)

(provide install-rational-package)