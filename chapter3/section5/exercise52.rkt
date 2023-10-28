#lang racket

(define (stream-car stream)
    (car stream))

(define (stream-cdr stream)
    (force (cdr stream)))

(define (stream-ref s n)
    (if (= n 0)
        (stream-car s)
        (stream-ref (stream-cdr s) (- n 1))))

(define (stream-map proc s)
    (if (stream-null? s)
        the-empty-stream
        (cons-stream (proc (stream-car s)) (stream-map proc (stream-cdr s)))))

(define (stream-for-each proc s)
    (if (stream-null? s) 
        'done
        (begin (proc (stream-car s))
               (stream-for-each proc (stream-cdr s)))))

(define (display-stream s)
    (stream-for-each display-line s))

(define (display-line x)
    (newline)
    (display x))

(define (stream-enumerate-interval low high)
    (if (> low high)
        the-empty-stream
        (cons-stream 
         low
         (stream-enumerate-interval (+ low 1) high))))

(define (stream-filter pred stream)
    (cond ((stream-null? stream) the-empty-stream)
          ((pred (stream-car stream))
           (cons-stream (stream-car stream)
                        (stream-filter pred (stream-cdr stream))))
          (else (stream-filter pred (stream-cdr stream)))))

(define the-empty-stream '())
(define stream-null? null?)

(define (delay exp)
    (lambda () exp))

(define (force delayed-object)
    (delayed-object))

(define (cons-stream a b)
    (cons a (delay b)))

;;
(define sum 0)

(define (accum x)
    (set! sum (+ x sum))
    sum)

(define seq (stream-map accum (stream-enumerate-interval 1 20)))
;; sum = 1 (strangely enough, racket shows sum = 210)

(define y (stream-filter even? seq))
; sum = 6

(define z (stream-filter (lambda (x) (= (remainder x 5) 0)) seq))
; sum = 10

(stream-ref y 7)
; sum = 136 (this is quite different from python's generator, iterating z won't affect y)

(display-stream z)
; sum = 210
