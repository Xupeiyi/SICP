#lang racket
;; prime?
(define (square x) (* x x))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
         ((even? exp) (remainder (square (expmod base (/ exp 2) m)) m))
         (else (remainder (* base (expmod base (- exp 1) m)) m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) #t)
         ((fermat-test n) (fast-prime? n (- times 1)))
         (else #f)))

(define (prime? n) (fast-prime? n 5))

;; prime-sum-pairs
(define (accumulate op init seq)
  (if (null? seq) init
      (op (car seq) (accumulate op init (cdr seq)))))

(define (enumerate-interval low high)
  (if (> low high) null
      (cons low (enumerate-interval (+ low 1) high))))

(define (flat-map proc seq)
  (accumulate append null (map proc seq)))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum?
               (flat-map
                (lambda (i) (map
                             (lambda (j) (list i j))
                             (enumerate-interval 1 (- i 1))))
                (enumerate-interval 1 n)))))

(prime-sum-pairs 6)