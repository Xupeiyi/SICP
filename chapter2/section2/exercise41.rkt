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

;;
(define (flatmap proc seq)
  (accumulate append null (map proc seq)))

(define (ordered-triples n)
  (flatmap (lambda (i)
             (flatmap (lambda (j)
                        (map (lambda (k)
                               (list i j k))
                             (enumerate-interval 1 (- j 1))))
                      (enumerate-interval 1 (- i 1))))
           (enumerate-interval 1 n)))

(define (triple-sum t)
  (+ (car t) (cadr t) (caddr t)))

(define (ordered-triples-of-sum n s)
  (filter (lambda (t)
            (= s (triple-sum t)))
          (ordered-triples n)))

(ordered-triples-of-sum 4 7)