#lang racket

(define (rand-update x)
  (let ((a (expt 2 32))
        (c 1103515245)
        (m 12345))
    (modulo (+ (* a x) c) m)))

(define random-init 0)

(define (make-rand x)
    (define generate (lambda () (set! x (rand-update x)) x))
    (define (reset new-value) (set! x new-value)) 
    (define (dispatch m) (cond ((eq? m 'generate) generate) ;; use eq? to compare symbols
                               ((eq? m 'reset) reset)
                               (else (error "UNKNOWN operation -- " m))))
    dispatch)

(define rand (make-rand random-init))

((rand 'reset) 1)
((rand 'generate))
((rand 'generate))
((rand 'generate))
                               
((rand 'reset) 1)
((rand 'generate))
((rand 'generate))
((rand 'generate))
                               

