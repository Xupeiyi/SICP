#lang racket
(require "./two-dimension-table.rkt")

(define (attach-tag type-tag contents)
    (if (number? contents) contents
        (cons type-tag contents)))

(define (all? predicate seq)
    (if (null? seq) #t
        (and (predicate (car seq)) (all? predicate (cdr seq)))))

(define (all-equal? seq)
    (all? (lambda (x) (equal? x (car seq))) seq))

(define (can-coerce-to type1 type2)
    (if (equal? type1 type2) #t
        (get-coercion type1 type2)))

(define (find-nth-element seq n)
    (if (= n 0) (car seq) 
        (find-nth-element (cdr seq) (- n 1))))

(define (coerce-args target-type args) 
    (if (null? args) '()
        (let ((new-arg (if (equal? (type-tag (car args)) target-type)
                           (car args)
                           ((get-coercion (type-tag (car args)) target-type) (car args)))))
              (cons new-arg (coerce-args target-type (cdr args))))))

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

             (define (apply-generic-with-coercion n)
                (if (< n (length args))
                    ;; see if all types can be converted to type n
                    (let ((nth-type (find-nth-element type-tags n)))
                        (let ((has-coercion-methods (map 
                                                    (lambda (type) (can-coerce-to type nth-type)) 
                                                    type-tags))
                            (coerced-types (make-list (length args) nth-type)))
                           
                            ;; if all types can be converted to type-n
                            ;; and if a method for (type-n ...)  exists
                            (if (and (all? (lambda (x) x) has-coercion-methods)
                                     (get op coerced-types))
                                
                                ;; call that method with new typed args
                                (apply (get op coerced-types) 
                                       (map contents (coerce-args nth-type args)))
                                    
                                ;; otherwise, convert all types to type i + 1
                                (apply-generic-with-coercion (+ n 1)))))
                    (error "No method for these types -- APPLY-GENERIC"
                                  (list op type-tags))))
                    
            (if proc 
                (apply proc (map contents args))
               
                ;; if not all types are equal
                (if (not (all-equal? type-tags))
                    ;; coerce, then apply
                    (apply-generic-with-coercion 0)
                    (error "No method for these types -- APPLY-GENERIC"
                                  (list op type-tags)))))))



(define (make-foo x y z)
    (attach-tag 'foo (list x y z)))

(define (make-bar x y)
    (attach-tag 'bar (cons x y)))

(define (make-baz x)
    (attach-tag 'baz (list x)))

(define (bar->foo b)
    (make-foo (car (contents b)) (cdr (contents b)) 0))

(define (baz->foo b)
    (make-foo (car (contents b)) 0 0))

(define (foo-add c1 c2 c3)
    (make-foo (+ (car c1) (car c2) (car c3))
              (+ (cadr c1) (cadr c2) (cadr c3))
              (+ (caddr c1) (caddr c2) (caddr c3))))


(put-coercion 'bar 'foo bar->foo)
(put-coercion 'baz 'foo baz->foo)
(put 'add '(foo foo foo) foo-add)

(define foo1 (make-foo 1 2 3))
(define bar1 (make-bar 4 5))
(define baz1 (make-baz 6))
;; (coerce-args 'foo (list baz1 bar1 foo1))
;;(foo-add foo1 foo1 foo1)
(apply-generic 'add foo1 foo1 foo1)

(apply-generic 'add baz1 bar1 foo1)
(apply-generic 'add bar1 baz1 bar1)

;; say we can only coerce baz to bar and bar to foo
;; and there's a method 'add for type '(bar foo)
;; in such a case, (add baz1 bar1) won't work, though we can do 
;; (add (baz->bar baz1) (bar->foo bar1))

;; if there's a method 'add for ('foo 'foo 'foo)
;; it won't be considered when the input is ('bar baz 'foo)
;; either, though 'bar and 'baz can be eventually coerced to 'foo 