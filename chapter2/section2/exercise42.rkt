#lang racket
(define (enumerate-interval low high)
  (if (> low high) null
      (cons low (enumerate-interval (+ low 1) high))))

(define (accumulate op init seq)
  (if (null? seq) init
      (op (car seq) (accumulate op init (cdr seq)))))

(define (flatmap proc seq)
  (accumulate append null (map proc seq)))

(define (make-position r c) (list r c))

(define (row position) (car position))

(define (col position) (cadr position))

(define (adjoin-position new-row k rest-of-queens)
  (cons (make-position new-row k) rest-of-queens))

(define (safe? k positions)
  
  (define (on-col-k? position)
    (= (col position) k))
  
  (define (not-on-col-k? position)
    (not (= (col position) k)))

  (define (on-same-row? position1 position2)
    (= (row position1) (row position2)))

  (define (on-same-diagonal? position1 position2)
    (= (abs (- (row position1) (row position2)))
       (abs (- (col position1) (col position2)))))
  
  (define (safe-on-row queen others)
    (null? (filter (lambda (other) (on-same-row? queen other)) others)))s

  (define (safe-on-diagonal queen others)
    (null? (filter (lambda (other) (on-same-diagonal? queen other)) others)))
  
  (let ((queen-on-col-k (car (filter on-col-k? positions)))
        (queens-not-on-col-k (filter not-on-col-k? positions)))
    (and (safe-on-row queen-on-col-k queens-not-on-col-k)
         (safe-on-diagonal queen-on-col-k queens-not-on-col-k))))

(define empty-board null)

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter (lambda (positions) (safe? k positions))
                (flatmap (lambda (rest-of-queens)
                           (map (lambda (new-row)
                                  (adjoin-position new-row k rest-of-queens))
                                (enumerate-interval 1 board-size)))
                         (queen-cols (- k 1))))))
  (queen-cols board-size))


(length (queens 8))
(length (queens 10))