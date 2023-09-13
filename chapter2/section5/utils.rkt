#lang racket
(require "two-dimension-table.rkt")

(define (raise n) 
    ((get 'raise (type-tag n)) (contents n)))

(define (project n)
    ((get 'project (type-tag n)) (contents n)))

(define (projectable? n)
    (with-handlers ([exn:fail? (lambda (e) #f)]) 
        (apply (get 'equ? (map type-tag (list n n))) 
                (map contents (list (raise (project n)) n)))))

        ;;(get 'equ? (map type-tag (list n n)) (raise (project n)) n))

(define (drop n)
    (if (projectable? n) 
        (drop (project n)) 
        n))

;; raise arg1's type to arg2's type
(define (raise-to arg1 arg2) 
    (if (equal? (type-tag arg1) (type-tag arg2)) 
        arg1
        (let ((raised-arg1 
                (with-handlers ([exn:fail? (lambda (e) #f)]) (raise arg1))))
            (if raised-arg1
                (raise-to raised-arg1 arg2)
                #f))))

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
                (drop (apply proc (map contents args)))
                (if (= (length args) 2)
                    (let ((type1 (car type-tags))
                          (type2 (cadr type-tags))
                          (a1 (car args))
                          (a2 (cadr args)))
                         (if (not (equal? type1 type2))
                             (let ((raised-a1 (raise-to a1 a2))
                                   (raised-a2 (raise-to a2 a1)))
                                  (cond (raised-a1 (apply-generic op raised-a1 a2))
                                        (raised-a2 (apply-generic op a1 raised-a2))
                                        (else (error "No method for these types -- APPLY-GENERIC"
                                                    (list op type-tags)))))
                             (error "No method for these types -- APPLY-GENERIC"
                                    (list op type-tags))))
                    (error "No method for these types -- APPLY-GENERIC"
                           (list op type-tags)))))))

(provide apply-generic attach-tag contents type-tag raise raise-to drop projectable? project)