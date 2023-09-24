#lang racket
;; a) The evaluator would first look for a procedure named "define" in the environment, 
;;    and try to call it. Therefore, the problem is that the evaluator would treat an expression 
;;    as a procedure call even if it's not.

(define (eval exp env) 
    (cond ((self-evaluating? exp) exp)
          ((variable? exp) (lookup-variable-value exp env))
          ((quoted? exp) (text-of-quotation exp))
          ((assignment? exp) (eval-assignment exp env))
          ((application? exp)
           (apply (eval (operator exp) env)
                  (list-of-values (operands exp) env)))
          ((definition? exp) (eval-definition exp env))
          ((if? exp) (eval-if exp env))
          ((lambda? exp) (make-procedure (lambda-parameters exp) 
                                         (lambda-body exp)
                                         env))
          ((begin? exp)
           (eval-sequence (begin-actions exp) env))
          ((cond? exp) (eval (cond->if exp) env))
          (else (error "Unknown expression type -- EVAL " exp))))


(define (application? exp) 
    (tagged-list? exp 'call))

(define (operator exp) 
    (cadr exp))

(define (operands exp)
    (cddr exp))