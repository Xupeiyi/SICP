#lang racket

(define (make-monitored f)
    (let ((count 0))
        (lambda (m) (cond ((eq? m 'how-many-calls?) count)
                          ((eq? m 'reset-count) (set! count 0))
                          (else (begin (set! count (+ count 1)) (f m)))))))

(define (inc1 x) (+ x 1))

(define monitored-inc1 (make-monitored inc1))

(monitored-inc1 2)

(monitored-inc1 3)

(monitored-inc1 4)

(monitored-inc1 'how-many-calls?)

(monitored-inc1 'reset-count)

(monitored-inc1 2)

(monitored-inc1 3)

(monitored-inc1 'how-many-calls?)