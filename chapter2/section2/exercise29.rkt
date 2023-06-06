#lang racket
;; a
#|
(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

(define (left-branch mobile) (car mobile))

(define (right-branch mobile) (cadr mobile))

(define (branch-length branch) (car branch))

(define (branch-structure branch) (cadr branch))

|#

;; d
(define (make-mobile left right)
  (cons left right))

(define (make-branch length structure)
  (cons length structure))

(define (left-branch mobile) (car mobile))

(define (right-branch mobile) (cdr mobile))

(define (branch-length branch) (car branch))

(define (branch-structure branch) (cdr branch))


;; -------------- abtraction barrier-----------


(define (weight? x)(not (pair? x)))

(define (total-weight mobile)
  (if (weight? mobile) mobile
      (+ (total-weight (branch-structure (left-branch mobile)))
         (total-weight (branch-structure (right-branch mobile))))))

;; b
(define b1 (make-branch 2 3))
(define b2 (make-branch 4 5))
(define m1 (make-mobile b1 b2))

(define m2 (make-mobile (make-branch 8 m1) (make-branch 9 10)))

(= (total-weight m2) (+ 3 5 10))

(define b3 (make-branch 5 9))
(define b4 (make-branch 4 5))
(define m3 (make-mobile b3 b4))

(define m4 (make-mobile (make-branch 2 m2) (make-branch 4 m3)))

(= (total-weight m4) (+ 3 5 10 9 5))

;; c

(define (torque branch)
  (* (branch-length branch)
     (total-weight (branch-structure branch))))

(define (balanced? mobile)
  (if (weight? mobile) #t
  (and (balanced? (branch-structure (left-branch mobile)))
       (balanced? (branch-structure (right-branch mobile)))
       (= (torque (left-branch mobile)) (torque (right-branch mobile))))))

#|
test: 
      m5
 __3__|__2____m6
|             |
|       m7__1_|_5___m8 
8       |            |
     _4_|_4_      _1_|_1_
    |       |    |       |
    5       5    1       1


|#

(define m7 (make-mobile (make-branch 4 5) (make-branch 4 5)))
(define m8 (make-mobile (make-branch 1 1) (make-branch 1 1)))
(define m6 (make-mobile (make-branch 1 m7) (make-branch 5 m8)))
(define m5 (make-mobile (make-branch 3 8) (make-branch 2 m6)))

(balanced? m7)
(balanced? m8)
(balanced? m6)
(balanced? m5)
