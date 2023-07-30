#lang racket

(define (make-queue)
    (let ((front-ptr '())
          (rear-ptr '()))

    (define (empty-queue?)
        (null? front-ptr))

    (define (front-queue) 
        (if (empty-queue?) 
            (error "FRONT called with an empty queue\n")
            (mcar front-ptr)))
    
    (define (insert-queue! item)
        (let ((new-pair (mcons item '())))
            (cond ((empty-queue?) 
                    (set! front-ptr new-pair) 
                    (set! rear-ptr new-pair)) 
                  (else 
                    (set-mcdr! rear-ptr new-pair)
                    (set! rear-ptr new-pair)))))
    
    (define (delete-queue!)
        (cond ((empty-queue?)
                (error "DELETE! called with an empty queue"))
              (else (set! front-ptr (mcdr front-ptr)))))
    
    (define (print-queue) 
        (define (print-list list) 
            (unless (null? list) 
            (begin (display (mcar list)) (display " ") 
                    (print-list (mcdr list)))))
        (if (empty-queue?)
            (print null)
            (begin (display "Queue: ")
                   (print-list front-ptr) 
                   (display "\n"))))

    (define (dispatch m) 
        (cond ((eq? m 'front-queue) front-queue)
              ((eq? m 'empty-queue?) empty-queue?)
              ((eq? m 'insert-queue!) insert-queue!)
              ((eq? m 'delete-queue!) delete-queue!)
              ((eq? m 'print-queue) print-queue)
              (else (error "Method not supported: " m))))
    dispatch))

(define q (make-queue))

((q 'insert-queue!) 'a)
((q 'insert-queue!) 'b)
((q 'insert-queue!) 'c)
((q 'print-queue)) ;; a b c

((q 'delete-queue!))
((q 'print-queue)) ;; b c

((q 'delete-queue!))
((q 'print-queue)) ;; c

((q 'insert-queue!) 'd)
((q 'print-queue)) ;; c d

((q 'delete-queue!))
((q 'print-queue)) ;; d