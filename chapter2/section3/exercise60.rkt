#lang racket
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-ofset? x (cdr set)))))

(define (adjoin-set x set)
  (cons x set))

(define (union-set set1 set2)
  (append set1 set2))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        (element-of-set? (car set1) set2)
        (cons (car set1) (intersection-set (cdr set1) set2))
        (else (intersection-set (cdr set1) set2))))

;; adjoin-set O(n) -> O(1)
;; union-set O(n**2) -> O(n)
;; use this method if space is enough, adjoin-set and union-set is frequently used, and there are not many repeated values