(define (front-ptr queue) (mcar queue))

(define (rear-ptr queue) (mcdr queue))

(define (set-front-ptr! queue item) (set-mcar! queue item))

(define (set-rear-ptr! queue item) (set-mcdr! queue item))

(define (empty-queue? queue) (null? (front-ptr queue)))

(define (make-queue) (cons '() '()))

(define (front-queue queue) 
    (if (empty-queue? queue)
        (error "FRONT called with an empty queue " queue)
        (car (front-ptr queue))))

(define (insert-queue! queue item) 
    (let ((new-pair (cons item '()))
        (cond ((empty-queue? queue) 
               (set-front-ptr! queue new-pair)
               (set-rear-ptr! queue new-pair)
               queue)
              (else 
                (set-mcdr! (rear-ptr queue) new-pair)
                (set-rear-ptr! queue new-pair)
                queue)))))

(define (delete-queue! queue item)
    (cond ((empty-queue? queue) 
            (error "DELETE! called with an empty queue"))
          (else 
            (set-front-ptr! queue (cdr (front-ptr queue)))
            queue)))