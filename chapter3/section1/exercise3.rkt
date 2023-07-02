#lang racket

(define (make-account balance password)
    (define (withdraw amount)
        (if (>= balance amount) 
            (begin (set! balance (- balance amount)) balance)
            "Insufficient funds"))
    (define (deposit amount)
        (set! balance (+ balance amount)) balance)
    (define (dispatch input-password command)
        (if (eq? input-password password)
            (cond ((eq? command 'withdraw) withdraw)
                  ((eq? command 'deposit) deposit)
                  (else (error "Unknown request -- MAKE-ACCOUNT " command)))
            (lambda (amount) "Incorrect password")))
    dispatch)

(define acc (make-account 100 'my-password))

((acc 'my-password 'withdraw) 30)

((acc 'other-password 'withdraw) 30)

((acc 'my-password 'deposit) 50)

((acc 'other-password 'deposit) 80)