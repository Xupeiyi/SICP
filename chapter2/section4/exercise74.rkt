#lang racket
;; a
;; the table structure for get record
;; division | get-record | <the get-record function> 

(define (get-record division name)
  ((get division 'get-record) name))

;; each division should implement a process that finds an employee's record by his/her name and put it into the system


;; b
(define (get-salary division name)
  (let ((record ((get division 'get-record) name)))
    ((get division 'get-salary) record)))

;; each division should implement a process that finds an emplyee's salary from the division's records


;; c
(define (find-employee-record branches name)
  (if (null? branches) (error "employee not found")           
      (let (record ((get division 'get-record) (car branches) name))
        (if (not (null? record)) record
            (find-employee-record (cdr branches) name)))))

;; d
;; add new methods on how to find a record (i.e., get-record), and how to find specific fields in that record structure(i.e., get-salary)