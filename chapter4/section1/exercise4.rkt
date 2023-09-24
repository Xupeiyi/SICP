#lang racket

(define (eval exp env) 
    (cond ((self-evaluating? exp) exp)
          ((variable? exp) (lookup-variable-value exp env))
          ((get (car exp)) ((get (car exp)) exp env))
          ((application? exp)
           (apply (eval (operator exp) env)
                  (list-of-values (operands exp) env)))
          (else (error "Unknown expression type -- EVAL " exp))))
          
(define (list-of-values exps env)
    (if (no-operands? exps) 
        '() 
        (cons (eval (first-operand exps) env)
              (list-of-values (rest-operands exps) env))))

;; syntax
; (define (tagged-list? exp tag)
;     (if (pair? exp)
;         (eq? ((car exp) tag))
;         false))

;; 1. self-evaluate
(define (self-evaluating? exp)
    (cond ((number? exp) true)
          ((string? exp) true)
          (else false)))

;; 2. variable
(define (variable? exp) (symbol? exp))

;; 3. quote
; (define (quoted? exp) 
;     (tagged-list? exp 'quote))

(define (text-of-quotation exp) (cadr exp))

(put 'quote text-of-quotation 
    (lambda (exp env) (text-of-quotation exp)))

;; 4. assignment
; (define (assignment? exp) 
;     (tagged-list? exp 'set!))

(define (assignment-variable exp) (cadr exp))

(define (assignment-value exp) (caddr exp))

(define (eval-assignment exp env)
    (set-variable-value! (assignment-variable exp)
                         (eval (assignment-value exp) env)
                         env)
    'ok)
(put 'set! eval-assignment)

;; 5. definition
; (define (definition? exp)
;     (tagged-list exp 'define))

(define (definition-variable exp)
    (if (symbol? (cadr exp))
        (cadr exp)
        (caadr exp)))

(define (definition-value exp)
    (if (symbol? (cadr exp))
        (caddr exp)
        (make-lambda (cdadr exp)
                     (cddr exp))))

(define (eval-definition exp env)
    (define-variable! (definition-variable exp)
                      (eval (definition-value exp) env))
    'ok)
(put 'define eval-definition)

;; 6. lambda 
; (define (lambda? exp) 
;     (tagged-list? exp 'lambda))

(define (lambda-parameters exp) 
    (cadr exp))

(define (lambda-body exp) 
    (cddr exp))

(define (make-lambda parameters body)
    (cons 'lambda (cons parameters body)))

(put 'lambda 
     (lambda (exp env) 
             (make-procedure (lambda-parameters exp) 
                             (lambda-body exp)
                             env)))

;; 7. if ('if predicate consequent alternative)
(define (if-predicate exp) (cadr exp))

(define (if-consequent exp) (caddr exp))

(define (if-alternative exp) 
    (if (not (null? (cdddr exp)))
        (cadddr exp)
        'false))

(define (make-if predicate consequent alternative)
    (list 'if predicate consequent alternative))

(define (eval-if exp env)
    (if (true? (eval (if-predicate exp) env))
        (eval (if-consequent exp) env)
        (eval (if-alternative exp) env)))

(put 'if eval-if)

;; 8. begin ('begin action1 action2 ...)

(define (begin-actions exp) (cdr exp))

(define (last-exp? seq) (null? (cdr seq)))

(define (first-exp seq) (car seq))

(define (rest-exps seq) (cdr seq))

(define (sequence->exp seq)
    (cond ((null? seq) seq)
          ((last-exp? seq) (first-exp seq))
          (else (make-begin seq))))

(define (eval-sequence exps env)
    (cond ((last-exp? exps) (eval (first-exp exps) env))
          (else (eval (first-exp exps) env)
                (eval-sequence (rest-exps exps)) env)))

(put 'begin 
    (lambda (exp env) (eval-sequence (begin-actions exp) env)))

;; 9. application
(define (application? exp) 
    (pair? exp))

(define (operator exp) 
    (car exp))

(define (operands exp)
    (cdr exp))

(define (no-operands? ops)
    (null? ops))

(define (first-operand ops) 
    (car ops))

(define (rest-operands ops)
    (cdr ops))

;; derived expressions
;; cond ('cond ((predicate action)
;;              (predicate action)
;;                ...
;;              (else action)))

(define (cond-clauses exp)
    (cdr exp))

(define (cond-else-clause? clause)
    (eq? (cond-predicate clause) 'else))

(define (cond-predicate clause) 
    (car clause))

(define (cond-actions clause)
    (cdr clause))

(define (cond->if exp)
    (expand-clauses (cond-clauses exp)))

(define (expand-clauses clauses)
    (if (null? clauses)
        'false
        (let ((first (car clauses))
              (rest (cdr clauses)))
             (if (cond-else-clause? first)
                 (if (null? rest)
                     (sequence->exp (cond-actions first))
                     (error "ELSE clause isn't last -- COND->IF " clauses))
                 (make-if (cond-predicate first)
                          (sequence->exp (cond-actions first))
                          (expand-clauses rest))))))
(put 'cond
     (lambda (exp env) (eval (cond->if exp) env)))

;; and ('and predicate1 predicate2 ...)
;; or  ('or predicate1 predicate2 ... )
;; 1. eval-and and eval-or

(define (predicates exp)
    (cdr exp))

(define (eval-and exp env)
    (if (null? (predicate exp) 'true)
        (eval-and-predicates (predicate exp) env)))

(define (eval-and-predicates exps env)
    (let ((first-result (eval (first-exp exps) env))) 
         ;; if first predicate is the last one or is false
         ;; return the first predicate's evaluation 
         (if (or (last-exp? exps) (false? first-result))
             first-result 
             (eval-and-predicates (rest-exps exps) env))))

(define (eval-or exp env)
    (if (null? (predicate exp) 'false)
        (eval-or-predicates (predicate exp) env)))

(define (eval-or-predicates exps env)
    (let ((first-result (eval (first-exp exps) env))) 
         ;; if first predicate is the last one or is true
         ;; return the first predicate's evaluation 
         (if (or (last-exp? exps) (true? first-result))
             first-result 
             (eval-or-predicates (rest-exps exps) env))))


;; 2. implemented as derived expression
(define (and->if exp)
    (if (null? (cdr exp)) 'true  
        (expand-and (cdr exp))))

(define (expand-and predicates)
    (if (last-exp? predicates) 
        (first-exp predicates)
        (make-if (first-exp predicate) 
                 (expand (cdr predicates))
                 'false)))

(define (or->if exp)
    (if (null? (cdr exp)) 'false 
        (expand (cdr exp))))

(define (expand-or predicates)
    (if (last-exp? predicates) 
        (first-exp predicates)
        (make-if (first-exp predicate) 
                 'true
                 (expand-or (cdr predicates)))))
