#lang racket
(define (enumerate-interval low high)
  (if (> low high) null
      (cons low (enumerate-interval (+ low 1) high))))

(define (accumulate op init seq)
  (if (null? seq) init
      (op (car seq) (accumulate op init (cdr seq)))))

(define (flat-map proc seq)
  (accumulate cons null (map proc seq)))

(define (not-equal? pair)
  (not (= (car pair) (cadr pair))))

(define (two-sum n s)
  (filter (lambda (pair) (and (not-equal? pair) (<= (cadr pair) n))) 
          (flat-map
           (lambda (i) (list i (- s i)))
           (enumerate-interval 1 (min n (- s 1))))))


(define (three-sum n s)
  (filter (lambda (x) (and (not (= (car x) (cadr x)))
                           (not (= (car x) (caddr x)))))
          (accumulate append
                      null
                      (map (lambda (i) (map
                                        (lambda (pair) (cons i pair))
                                        (two-sum n (- s i))))
                           (enumerate-interval 1 (min n (- s 3)))))))
(three-sum 4 7)
