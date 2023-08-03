#lang racket
(require compatibility/mlist)

(define (new-assoc same-key? key records)
    (cond ((null? records) false)
          ((same-key? key (mcar (mcar records))) (mcar records))
          (else (assoc key (mcdr records)))))

(define (make-table same-key?)
    (let ((local-table (mlist '*table*)))
        (define (assoc key records)
            (new-assoc same-key? key records))

        (define (lookup key-1 key-2)
            (let ((subtable (assoc key-1 (mcdr local-table))))
                 (if subtable 
                     (let ((record (assoc key-2 (mcdr subtable))))
                          (if record (mcdr record) false))
                     false)))
        
        (define (insert! key-1 key-2 value)
            (let ((subtable (assoc key-1 (mcdr local-table))))
                 (if subtable 
                     (let ((record (assoc key-2 (mcdr subtable))))
                           (if record 
                               (set-mcdr! record value)
                               (set-mcdr! subtable 
                                          (mcons (mcons key-2 value) 
                                                 (mcdr subtable)))))
                     (set-mcdr! local-table 
                                (mcons (mlist key-1 (mcons key-2 value))
                                       (mcdr local-table))))))

        (define (dispatch m) 
            (cond ((eq? m 'lookup-proc) lookup)
                  ((eq? m 'insert-proc!) insert!)
                  (else (error "Unknwon operation -- TABLE" m))))
        dispatch))


(define (float-almost-equal f1 f2) 
    (< (abs (- f1 f2)) 0.5))

(define t (make-table float-almost-equal))

((t 'insert-proc!) 1 2 3)

((t 'lookup-proc) 1.1 2) ;; 3

((t 'lookup-proc) 1.8 2) ;; #f

((t 'insert-proc!) 0.9 2.3 8)

((t 'lookup-proc) 0.7 1.6) ;; 8

