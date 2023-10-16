#lang racket
(require "constraints.rkt")

(define (squarer a b)
    (define (process-new-value)
        (if (has-value? b)
            (if (< (get-value b) 0) 
                (error "square less than 0 -- SQUARER" (get-value b))
                (set-value! a (sqrt (get-value b)) me))
            (when (has-value? a) 
                (set-value! b (* (get-value a) (get-value a)) me))))

    (define (process-forget-value)
        (forget-value! b me)
        (forget-value! a me)
        (process-new-value))
    
    (define (me request)
        (cond ((eq? request 'I-have-a-value)
               (process-new-value))
              ((eq? request 'I-lost-my-value)
               (process-forget-value))
              (else (error "Unknown request -- SQUARER " request))))
    (connect a me)
    (connect b me)
    me)

(define A (make-connector))
(define B (make-connector))

(squarer A B)

(probe "a" A)
(probe "b" B)

(set-value! A 10 'user)
(forget-value! A 'user)

(set-value! B 9 'user)
;;(set-value! B 20 'user)
;;(set-value! C 30 'user) -- contradiction error
; (forget-value! C 'user)
; (forget-value! B 'user)
; (has-value? B)

; (set-value! C 100 'user)