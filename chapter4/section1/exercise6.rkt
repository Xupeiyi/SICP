#lang racket

;; (let ((var1 exp1) (var2 exp2) ...) body)

(define (let? exp)
    (tagged-list? exp 'let))

(define (let-bindings exp) (cadr exp))

(define (binding-var binding)
    (car binding))

(define (binding-value binding)
    (cadr binding))

(define (let-vars exp) (map binding-var (let-bindings exp)))

(define (let-exps exp) (map binding-value (let-bindings exp)))

(define (let-body exp) (cadddr exp))

(define (let->combination exp)
    ;; build an application expression
    (cons
    ;; the operator is a lambda expression 
    (make-lambda (let-vars exp) (let-body exp))
    ;; the operands are the let-values
    (let-exps exp)))


(define (eval exp env) 
    (cond ((self-evaluating? exp) exp)
          ((variable? exp) (lookup-variable-value exp env))
          ((quoted? exp) (text-of-quotation exp))
          ((assignment? exp) (eval-assignment exp env))
          ((definition? exp) (eval-definition exp env))
          ((if? exp) (eval-if exp env))
          ((lambda? exp) (make-procedure (lambda-parameters exp) 
                                         (lambda-body exp)
                                         env))
          ((begin? exp)
           (eval-sequence (begin-actions exp) env))
          ((cond? exp) (eval (cond->if exp) env))
          ;; add support for let expressions
          ((let? exp) (eval (let->combination exp) env))
          ((application? exp)
           (apply (eval (operator exp) env)
                  (list-of-values (operands exp) env)))
          (else (error "Unknown expression type -- EVAL " exp))))
