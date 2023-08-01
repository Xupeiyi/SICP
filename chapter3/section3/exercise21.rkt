#lang racket

(define (front-ptr queue) (mcar queue))

(define (rear-ptr queue) (mcdr queue))

(define (set-front-ptr! queue item) (set-mcar! queue item))

(define (set-rear-ptr! queue item) (set-mcdr! queue item))

(define (empty-queue? queue) (null? (front-ptr queue)))

(define (make-queue) (mcons '() '()))

(define (front-queue queue) 
    (if (empty-queue? queue)
        (error "FRONT called with an empty queue " queue)
        (mcar (front-ptr queue))))

(define (insert-queue! queue item) 
    (let ((new-pair (mcons item '())))
        (cond ((empty-queue? queue) 
                (set-front-ptr! queue new-pair)
                (set-rear-ptr! queue new-pair)
                queue)
              (else 
                (set-mcdr! (rear-ptr queue) new-pair)
                (set-rear-ptr! queue new-pair)
                queue))))

(define (delete-queue! queue)
    (cond ((empty-queue? queue) 
            (error "DELETE! called with an empty queue"))
          (else 
            (set-front-ptr! queue (mcdr (front-ptr queue)))
            queue)))

(define (print-queue queue)
  (define (print-list list) 
    (unless (null? list) 
      (begin (display (mcar list)) (display " ") 
             (print-list (mcdr list)))))
  (if (empty-queue? queue)
      (print null)
      (begin (display "Queue: ")
             (print-list (front-ptr queue)) 
             (display "\n"))))

; feels like cheating to use the REPL to print the list
; (define (print-queue q)
;   (print (front-ptr q)))

(define q1 (make-queue))
; (print-queue q1)
(insert-queue! q1 'a)
(insert-queue! q1 'b)
(insert-queue! q1 'c)
(print-queue q1)

(delete-queue! q1)
(delete-queue! q1)
(print-queue q1)

(delete-queue! q1)
(print-queue q1)