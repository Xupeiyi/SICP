#lang racket

(define (tagged-list? exp tag)
    (if (pair? exp)
        (eq? (car exp) tag)
        false))

(define (cond? exp) (tagged-list? exp 'cond))

;; clauses
(define (cond-clauses exp) (cdr exp))

(define (cond-else-clause? clause) 
    (eq? (cond-predicate clause) 'else))

(define (cond-predicate clause) 
    (car clause))

(define (cond-actions clause)
    (cdr clause))

;; test-recipient clauses
(define (cond-test-recipient-clause? clause)
    (eq? tagged-list? (cond-actions clause) '=>))

(define (cond-test test-recipient-clause) 
    (car test-recipient-clause))

(define (cond-recipient test-recipient-clause)
    (cadr test-recipient-clause))

(define (cond->if exp) 
    (expand-clauses (cond-clauses exp)))

(define (expand-clauses clauses)
    (if (null? clauses)
        'false
    (let ((first-clause (car clauses)) 
          (rest-clauses (cdr clauses)))
          ;; if first clause is an else clause
          (if (cond-else-clause? first-clause)
              ;; and there are no more clauses
              (if (null? rest-clauses)
                  ;; return its actions as an expression
                  (sequence->exp (cond-actions first-clause))
                  (error "Else clause isn't last -- COND->IF clauses"))
              ;; otherwise, make an if expression
              ;; if the first clause is a test-recipient clause
                (if (cond-test-recipient-clause? first-clause)
                    ;; make a if expression with the test as the predicate
                    ;; and '(recipient test) as the consequent
                    (make-if (cond-test first-clause)
                             (list (cond-recipient first-clause) (cond-test first-clause))
                             (expand-clauses rest-clauses))
                    ;; otherwise, just make a regular if expression
                    (make-if (cond-predicate first-clause)
                             (sequence->exp (cond-actions first-clause))
                             (expand-clauses rest-clauses)))))))