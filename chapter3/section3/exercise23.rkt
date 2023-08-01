#lang racket

(define (make-node value prev next) 
    (mcons value (mcons prev next)))

(define (value node) (mcar node))

(define (prev node) (mcar (mcdr node)))

(define (next node) (mcdr (mcdr node)))

(define (set-prev! node item) 
    (set-mcar! (mcdr node) item))

(define (set-next! node item)
    (set-mcdr! (mcdr node) item))

(define (make-queue) (mcons '() '()))

(define (front-ptr queue) (mcar queue))

(define (rear-ptr queue) (mcdr queue))

(define (empty-queue? queue) (null? (front-ptr queue)))

(define (front-deque queue)
    (if (empty-queue? queue) 
        (error "FRONT called with an empty queue")
        (value (front-ptr queue))))

(define (rear-deque queue)
    (if (empty-queue? queue)
        (error "REAR called with an empty queue")
        (value (rear-ptr queue))))

(define (set-front-ptr! queue node) 
    (set-mcar! queue node))

(define (set-rear-ptr! queue node) 
    (set-mcdr! queue node))

(define (front-insert-deque! queue item) 
    (let ((new-node (make-node item '() '())))
        (cond ((empty-queue? queue) 
                (set-front-ptr! queue new-node)
                (set-rear-ptr! queue new-node) 
                queue)
               (else
                (set-prev! (front-ptr queue) new-node)
                (set-next! new-node (front-ptr queue))
                (set-front-ptr! queue new-node)
                queue))))

(define (rear-insert-deque! queue item) 
    (let ((new-node (make-node item '() '())))
        (cond ((empty-queue? queue) 
                (set-front-ptr! queue new-node)
                (set-rear-ptr! queue new-node) 
                queue)
               (else
                (set-next! (rear-ptr queue) new-node)
                (set-prev! new-node (rear-ptr queue))
                (set-rear-ptr! queue new-node)
                queue))))


(define (front-delete-deque! queue)
    (cond ((empty-queue? queue) 
            (error "DELETE! called with an empty deque"))
          (else 
            (set-front-ptr! queue (next (front-ptr queue)))
            queue)))

(define (rear-delete-deque! queue)
    (cond ((empty-queue? queue) 
            (error "DELETE! called with an empty deque"))
          (else 
            (set-rear-ptr! queue (prev (rear-ptr queue)))
            (set-next! (rear-ptr queue) '())
            queue)))

(define (print-deque queue)
  (define (print-list head) 
    (unless (null? head) 
      (begin (display (value head)) (display " ") 
             (print-list (next head)))))
  (if (empty-queue? queue)
      (print null)
      (begin (display "Queue: ")
             (print-list (front-ptr queue)) 
             (display "\n"))))


(define q (make-queue))

(front-insert-deque! q 'a)
(front-insert-deque! q 'b)
(rear-insert-deque! q 'c)
(rear-insert-deque! q 'd)
(front-insert-deque! q 'e)

(print-deque q) ;; e b a c d

(front-delete-deque! q)
(front-delete-deque! q)
(rear-delete-deque! q)

(print-deque q) ;; a c

(display (front-deque q)) ;; a

(display (rear-deque q)) ;; c
