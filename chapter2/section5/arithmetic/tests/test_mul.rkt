#lang racket
(require "../src/main.rkt")

;; test sparse-termlist
(define c1 (make-complex-from-real-imag 0.0001 -2))
(define r1 (make-rational -7 2))

(define t1 (make-sparse-termlist (list (list 1 4) (list 0 c1))))
(define t2 (make-sparse-termlist (list (list 2 1) (list 0 r1))))
(define t3 (make-sparse-termlist (list (list 3 4) 
                                       (list 2 (make-complex-from-mag-ang 2.0000000024999998 -1.5707463267949382))
                                       (list 1 -14) 
                                       (list 0 (make-complex-from-mag-ang 7.000000008749999 -1.5707463267949382)))))
(equ? (mul t1 t2) t3)

;; test dense-termlist
(define dt1 (make-dense-termlist (list 4 -2)))
(define dt2 (make-dense-termlist (list 1 0 r1)))
(equ? (mul dt1 dt2) (make-dense-termlist 4 2 -14 7))
