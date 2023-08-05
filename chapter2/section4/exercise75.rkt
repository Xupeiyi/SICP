#lang racket
(define (make-from-mag-ang r a)
  (define (dispatch op)
    (cond ((eq? op 'real-part) (* r (cos a)))
          ((eq? op 'imag-part) (* r (sin a)))
          ((eq? op 'magnitude) r)
          ((eq? op 'angle) a)
          (else (error "Unknown op -- MAKE-FROM-MAG-ANG " op))))
  dispatch)

(define n1 (make-from-mag-ang 1.4142 0.78539))

(n1 'real-part)
(n1 'imag-part)
(n1 'magnitude)
(n1 'angle)