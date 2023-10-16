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
    (define (or-action-procedure)
        (let ((new-value (logical-or (get-signal a1) 
                                     (get-signal a2))))
             (after-delay or-gate-delay
                (lambda () (set-signal! output new-value)))))
    (add-action! a1 or-action-procedure)
    (add-action! a2 or-action-procedure)    
    'ok)

(define (half-adder a b s c)
    (let ((d (make-wire)) 
          (e (make-wire)))
         (or-gate a b d)
         (and-gate a b c)
         (inverter c e)
         (and-gate d e s)
         'ok))

(define (full-adder a b c-in sum c-out)
    (let ((s (makee-wire))
          (c1 (make-wire))
          (c2 (make-wire)))
         (half-adder b c-in s c1)
         (half-adder a s sum c2)
         (or-gate c1 c2 c-out)
         'ok))

(define (ripple-carry-adder a-list b-list s-list c)
    (let ((c-in (make-wire)))
         (if (null? (cdr a-list))
             (set-signal! c-in 0)
             (ripple-carry-adder (cdr a-list) (cdr b-list) (cdr s-list) c-in))
         (full-adder (car a-list) (car b-list) c-in (car s) c)))

;; ripple-carry-adder 
;; = n * FA
;; = n * (2 * half-adder + or-gate)
;; = n * (2 * max(and-gate-delay + inverter-delay, or-gate-delay) + and-gate-delay)