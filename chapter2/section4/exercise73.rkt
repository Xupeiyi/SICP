#lang racket

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else ((get 'deriv (operator exp)) ;; the derivative function
               (operands exp) 
               var))))

(define (operator exp) (car exp))

(define (operands exp) (cdr exp))


;; a
;; We decide the process to calculate the partial derivative according to the operator of the expression.
;; Then we apply that process to the operands and specify the variable.
;; number? and sae-variable? can't be added to the dispatch because we can't extract operators and operands from numbers and variables


;; b
(define (install-sum-package)
  (define (make-sum a1 a2) (list '+ a1 a2))

  (define (addend operands) (car operands))

  (define (augend operands) (cadr operands))

  (define (deriv-sum operands var)
    (make-sum (deriv (addend operands) var)
              (deriv (augend operands) var)))
  
  ;; interface to the rest of the system
  (put 'deriv '+ deriv-sum)
  'done)


(define (install-product-package)
  (define (make-sum a1 a2) (list '+ a1 a2))

  (define (make-product m1 m2) (list '* m1 m2))
  
  (define (multiplier operands) (car operands))

  (define (multiplicand p) (cadr operands))
  
  (define (deriv-product operands var)
    (make-sum (make-product (multiplier operands) (deriv (multiplicand operands) var))
              (make-product (multiplicand operands) (deriv (multiplier operands) var))))
  
  (put 'deriv '* deriv-product)
  'done)


;; c
(define (install-exponent-package)

  (define (make-product m1 m2) (list '* m1 m2))
  
  
  (define (make-exponentiation base exp) (cond ((=number? exp 0) 1)
                                               ((=number? exp 1) base)
                                               ((and (number? base) (number? exp)) (expt base exp))
                                               (else (list '** base exp))))

  (define (base e) (cadr e))

  (define (exponent e) (caddr e))

  (define (deriv-exponent operands var)
    (make-product (make-product (exponent exp)
                                (make-exponentiation (base exp) (- (exponent exp) 1)))
                  (deriv (base exp) var)))

  (put 'deriv '** deriv-exponent)
  'done)


;; d
;; we only need to change from (put 'deriv '* deriv-product) to (put '* 'deriv deriv-product)