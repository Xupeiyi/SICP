#lang racket
(require "./two-dimension-table.rkt")

(define (attach-tag type-tag contents)
    (if (number? contents) contents
        (cons type-tag contents)))

(define (type-tag datum) 
    (cond ((pair? datum) (car datum))
          ((number? datum) 'scheme-number)
          (else (error "Bad tagged datum -- TYPETAG " datum))))

(define (contents datum) 
    (cond ((pair? datum) (cdr datum))
          ((number? datum) datum)
          (else (error "Bad tagged datum -- CONTENTS " datum))))

(define (apply-generic op . args)
    (let ((type-tags (map type-tag args)))
        (let ((proc (get op type-tags)))
            (if proc 
                (apply proc (map contents args))
                (if (= (length args) 2)
                    (let ((type1 (car type-tags))
                          (type2 (cadr type-tags))
                          (a1 (car args))
                          (a2 (cadr args)))
                         (if (equal? type1 type2) 
                             (let ((t1->t2 (get-coercion type1 type2))
                                   (t2->t1 (get-coercion type2 type1)))
                                  (cond (t1->t2 (apply-generic op (t1->t2 a1) a2))
                                        (t2->t1 (apply-generic op a1 (t2->t1) a2))
                                        (else (error "No method for these types -- APPLY-GENERIC"
                                                    (list op type-tags)))))
                             (error "No method for these types -- APPLY-GENERIC"
                                    (list op type-tags))))
                    (error "No method for these types -- APPLY-GENERIC"
                           (list op type-tags)))))))

(provide apply-generic attach-tag contents)