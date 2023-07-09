#lang racket

(define (make-account balance password max-trial)
    (define (withdraw amount)
        (if (>= balance amount) 
            (begin (set! balance (- balance amount)) balance)
            "Insufficient funds"))

    (define (deposit amount)
        (set! balance (+ balance amount)) balance)

    (define call-the-cops (lambda () (error "Calling the cops!")))

    (define (dispatch input-password command)
        (if (eq? input-password password)
            (cond ((eq? command 'withdraw) withdraw)
                  ((eq? command 'deposit) deposit)
                  (else (error "Unknown request -- MAKE-ACCOUNT " command)))
            (if (> max-trial 0) (begin (set! max-trial (- max-trial 1)) 
                                       (lambda (amount) "Incorrect password"))
                                (call-the-cops))))
    dispatch)

(define acc (make-account 100 'my-password 6))

((acc 'my-password 'withdraw) 30)

((acc 'other-password 'withdraw) 30)

((acc 'my-password 'deposit) 50)

((acc 'other-password 'deposit) 80)

((acc 'other-password 'withdraw) 30)

((acc 'other-password 'withdraw) 30)

((acc 'other-password 'withdraw) 30)

((acc 'other-password 'withdraw) 30)

((acc 'other-password 'withdraw) 30)