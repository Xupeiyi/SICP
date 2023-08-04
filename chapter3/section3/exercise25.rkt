#lang racket
(require compatibility/mlist)

(define (assoc key records)
    (cond ((null? records) false)
          ((equal? key (mcar (mcar records))) (mcar records))
          (else (assoc key (mcdr records)))))

(define (make-table) (mlist '*table*))

(define (look-up table . keys) 
    (if (null? keys) (error "Incorrect number of keys")
        (let ((record (assoc (car keys) (mcdr table))))
         (if record 
            ;; if record is a pair of key and table, keep looking up
            (cond ((mpair? (mcdr record))
                   (apply look-up (cons record 
                                        (cdr keys))))
                    ;; if record is a pair of key and value, stop
                   (else (mcdr record)))
                record))))

(define (insert! table value . keys)

    (define (inner-insert! table value keys)
        (if (null? keys) 
            (set-mcdr! table value)
            (let ((record (assoc (car keys) (mcdr table))))
                (cond (record 
                        ;; if record is a pair of key and value
                        ;; set the record to be a pair of key and empty list
                        ;; thus making the record another table
                        (when (not (mpair? (mcdr record))) (set-mcdr! record '()))
                        (inner-insert! record value (cdr keys)))
                    ;; if the first key doesn't have a corresponding record
                    ;; insert a pair of key and empty list at the front
                    (else (set-mcdr! table 
                                     (mcons (mcons (car keys) '()) 
                                            (mcdr table)))
                            (inner-insert! (mcar (mcdr table)) value (cdr keys))))))
        'ok)

    (if (null? keys) 
        (error "Incorrect number of keys!")
        (inner-insert! table value keys)))


(define t (make-table))

(insert! t 1 'a 'b 'c)
(= (look-up t 'a 'b 'c) 1) ;; 1

(insert! t 2 'a 'b)
(= (look-up t 'a 'b) 2) ;; 2

;; keys can be extended
;; key ('a 'b) wont exist anymore
(insert! t 3 'a 'b 'c)
(= (look-up t 'a 'b 'c) 3);; 3


(insert! t 4  'a 'b 'd)
(= (look-up t 'a 'b 'd) 4) ;; 4

;; key ('a 'b 'c) still exists
(= (look-up t 'a 'b 'c) 3) ;; 3

(insert! t 5 'b 'c 'd 'e)
(= (look-up t 'b 'c 'd 'e) 5);; 5

(insert! t 10 'b)
(= (look-up t 'b) 10) ;; 10

;; the unused keys would be ignored
(= (look-up t 'b 'c 'd 'e) 10) ;; 10

(insert! t 11 'b 'c)
(= (look-up t 'b 'c) 11);; 11

(not (look-up t 'x));; #f
(= (look-up t 'a 'b 'd) 4);; 4

(insert! t 12 'c)
(= (look-up t 'c) 12);

(display t)