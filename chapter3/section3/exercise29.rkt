#lang racket

(define (inverter input output)
    (define (invert-input)
        (let ((new-value (logical-not (get-signal input))))
            (after-delay inverter-delay
                (lambda () (set-signal! output new-value)))))
    (add-action! input invert-input))

(define (logical-not s)
    (cond ((= s 0) 1)
          ((= s 1) 0)
          (else (error "Invalid signal " s))))

(define (and-gate a1 a2 output)
    (define (and-action-procedure)
        (let ((new-value (logical-and (get-signal a1) 
                                      (get-signal a2))))
             (after-delay and-gate-delay
                (lambda () (set-signal! output new-value)))))
    (add-action! a1 and-action-procedure)
    (add-action! a2 and-action-procedure)    
    'ok)

(define (or-gate a1 a2 output)
    (let ((b (make-wire))
          (c (make-wire))
          (d (make-wire)))
         (inverter a1 b)
         (inverter a2 c)
         (and-gate b c d)
         (inverter d output)
         'ok))

;; or-gate-delay = 3 * inverter-delay + and-gate-delay