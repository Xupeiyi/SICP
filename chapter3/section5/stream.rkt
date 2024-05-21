#lang racket


(define (stream-car stream)
    (car stream))

(define (stream-cdr stream)
    (force (cdr stream)))

(define (stream-ref s n)
    (if (= n 0)
        (stream-car s)
        (stream-ref (stream-cdr s) (- n 1))))

(define (stream-map proc . argstreams)
    (if (stream-null? (car argstreams))
        the-empty-stream
        (cons-stream (apply proc (map stream-car argstreams))
                     (apply stream-map (cons proc (map stream-cdr argstreams))))))

(define (stream-for-each proc s)
    (if (stream-null? s) 
        'done
        (begin (proc (stream-car s))
               (stream-for-each proc (stream-cdr s)))))

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

; (define (delay exp)
;     (lambda () (exp)))

(define (force delayed-object)
    (delayed-object))

; (define (cons-stream a b)
;     (cons a (delay b)))

(define (add-streams s1 s2)
    (stream-map + s1 s2))

(define (mul-streams s1 s2)
    (stream-map * s1 s2))

(define (div-streams s1 s2)
    (stream-map / s1 s2))

(define (scale-stream stream factor)
    (stream-map (lambda (x) (* x factor)) stream))

(define (partial-sums s)
    (cons-stream (stream-car s) 
                 (add-streams (stream-cdr s) (partial-sums s))))

(define ones (cons-stream 1 ones))

(define integers (cons-stream 1 (add-streams ones integers)))

(define (integrate-series s) (div-streams s integers))

; (define-syntax cons-stream
;   (syntax-rules ()
;     ((cons-stream a b)
;      (cons a (lambda () b)))))

(define (memo-proc proc)
  (let ((already-run? false) (result false))
    (lambda ()
      (if (not already-run?)
          (begin (set! result (proc))
                 (set! already-run? true)
                 result)
          result))))
          
(define-syntax cons-stream
  (syntax-rules ()
    ((cons-stream a b)
     (cons a (delay b)))))

(define-syntax delay
  (syntax-rules ()
    ((delay object)
     (memo-proc (lambda() object)))))

(provide cons-stream 
         stream-car stream-cdr stream-ref stream-null?
         add-streams mul-streams div-streams scale-stream partial-sums stream-map
         integers ones integrate-series)
;; ===================
;; prime?
;; ===================
; (define (smallest-divisor n)
;   (find-divisor n 2))

; (define (find-divisor n test-divisor)
;   (cond ((> (square test-divisor) n) n)
;         ((divides? test-divisor n) test-divisor)
;         (else (find-divisor n (+ test-divisor 1)))))

; (define (divides? a b)
;   (= (remainder b a) 0))

; (define (prime? n)
;   (= n (smallest-divisor n)))

; (define (square n)(* n n))

; (stream-car (stream-cdr (stream-filter prime? 
;     (stream-enumerate-interval 10000 1000000))))