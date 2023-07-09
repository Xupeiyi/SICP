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

(define (make-joint account password new-password)
    (if (eq? ((account password 'deposit) 0) "Incorrect password") 
        (error "Incorrect password")
        (lambda (input-password command) 
            (if (eq? input-password new-password) 
                (account password command)
                (error "Incorrect password")))))

(define peter-acc (make-account 100 'open-sesame))

;; (define paul-acc (make-joint peter-acc 'sesame 'rosebud)) ;; Incorrect password

(define paul-acc (make-joint peter-acc 'open-sesame 'rosebud))

((peter-acc 'open-sesame 'withdraw) 40) ;; remaining 60

((paul-acc 'rosebud 'withdraw) 40) ;; remaining 20

((paul-acc 'rosebud 'deposit) 10) ;; remaining 30

((peter-acc 'open-sesame 'deposit) 80) ;; remaining 110

;; ((paul-acc 'rose 'deposit) 10) ;; incorrect password

(define percy-acc (make-joint paul-acc 'rosebud 'chocolate))

((percy-acc 'chocolate 'deposit) 300) ;; remaining 410