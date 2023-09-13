#lang racket

(require "arithmetic.rkt"
         "two-dimension-table.rkt"
         "utils.rkt")

(define (raise n) 
    (apply-generic 'raise n))

(define (install-project)

    (define (project-complex n)
        (let ((numer (numerator (real-part n)))
              (denom (denominator (real-part n))))
             (make-rat numer denom)))

    (define (project-rat n)
        (car n))

    ;; ignored real number in this case
    (put 'project '(complex) project-complex)
    (put 'project '(rational) project-rat))

(install-project)

(define (project n)
    (apply-generic 'project n))

(define (projectable? n)
    (with-handlers ([exn:fail? (lambda (e) #f)]) (equ? (raise (project n)) n)))
    


;; ======== tests =========
(define c1 (make-complex-from-real-imag 7.5 2))
(project c1)
(equal? (projectable? c1) #f)

(define c2 (make-complex-from-real-imag 7.5 0))
(project c2)
(projectable? c2)

(define r1 (make-rat 5 2))
(project r1)
(equal? (projectable? r1) #f)

(define r2 (make-rat 3 1))
(project r2)
(projectable? r2)

(define (drop n)
    (if (projectable? n) 
        (drop (project n)) 
        n))

(define c3 (make-complex-from-real-imag 9 0))
(drop c3) 

(define c4 (make-complex-from-real-imag 9.5 0))
(drop c4) 

(define c5 (make-complex-from-real-imag 9.5 1))
(drop c5) 

(define r3 (make-rat 6 2))
(drop r3) 

(define r4 (make-rat 6 4))
(drop r4) 