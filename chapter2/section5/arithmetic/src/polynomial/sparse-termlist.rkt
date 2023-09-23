#lang racket
(require "../two-dimension-table.rkt" "../generic.rkt")


(define (install-sparse-termlist-package)
    ;; internal procedures
    ;; representation of poly
    ; (define (make-poly variable term-list) 
    ;     (cons variable term-list))
    ; (define (variable p) (car p))
    ; (define (term-list p) (cdr p))
    ; (define (variable? x) (symbol? x))
    ; (define (same-variable? v1 v2) (and (variable? v1) (variable? v2) (eq? v1 v2)))
    ;; representation of terms and term lists
    (define (make-term order coeff) (list order coeff))
    (define (order term) (car term))
    (define (coeff term) (cadr term))        
    (define (negate-term t)
            (make-term (order t) (negate (coeff t))))

    (define (equ?-term t1 t2) 
        (and (equ? (order t1) (order t2))
             (equ? (coeff t1) (coeff t2))))

    ;; it's gauranteed that term's order is the highest
    (define (adjoin-term term term-list) 
        (if (=zero? (coeff term)) 
            term-list 
            (cons term term-list)))

    (define (first-term term-list) (car term-list))
    
    (define (rest-terms term-list) (cdr term-list))
    
    (define (empty-termlist? term-list) (null? term-list))

    (define (the-empty-termlist) '())

    ;; interfaces
    (define (tag term-list) (attach-tag 'sparse-termlist term-list))
    
    (define (negate-termlist L) 
        (if (empty-termlist? L) L
            (adjoin-term (negate-term (first-term L)) 
                         (negate-termlist (rest-terms L)))))
    (put 'negate '(sparse-termlist) 
        (lambda (L) (tag (negate-termlist L))))

    ;; add
    (define (add-terms L1 L2) 
        (cond ((empty-termlist? L1) L2)
              ((empty-termlist? L2) L1)
              (else 
                (let ((t1 (first-term L1)) (t2 (first-term L2)))
                     (cond ((> (order t1) (order t2))
                            (adjoin-term t1 (add-terms (rest-terms L1) L2)))
                           ((< (order t1) (order t2))
                            (adjoin-term t2 (add-terms (rest-terms L2) L1)))
                           (else (adjoin-term (make-term (order t1) (add (coeff t1) (coeff t2)))
                                              (add-terms (rest-terms L1) (rest-terms L2)))))))))
    (put 'add '(sparse-termlist sparse-termlist) 
        (lambda (L1 L2) (tag (add-terms L1 L2))))
    
    ;; sub
    (define (sub-terms L1 L2)
        (add-terms L1 (negate-termlist L2)))
    
    (put 'sub '(sparse-termlist sparse-termlist)
        (lambda (L1 L2) (tag (sub-terms L1 L2))))

    ;; mul
    (define (mul-term-by-all-terms t1 L)
        (if (empty-termlist? L)
            (the-empty-termlist)
            (let ((t2 (first-term L)))
                (adjoin-term 
                    (make-term (add (order t1) (order t2)) 
                               (mul (coeff t1) (coeff t2)))
                    (mul-term-by-all-terms t1 (rest-terms L))))))
    (define (mul-terms L1 L2) 
        (if (empty-termlist? L1) 
            (the-empty-termlist)
            (add-terms (mul-term-by-all-terms (first-term L1) L2)
                       (mul-terms (rest-terms L1) L2))))
    (put 'mul '(sparse-termlist sparse-termlist) 
        (lambda (L1 L2) (tag (mul-terms L1 L2))))

    (define (equ-termlist? t1 t2)
        (cond ((and (empty-termlist? t1) (empty-termlist? t2)) 
                    #t)
              ((and (not (empty-termlist? t1)) (not (empty-termlist? t2))) 
                    (and (equ?-term (first-term t1) (first-term t2))
                            (equ-termlist? (rest-terms t1) (rest-terms t2))))
              (else #f)))
    (put 'equ? '(sparse-termlist sparse-termlist) equ-termlist?)

    (define (=zero?-termlist t)
        (if (empty-termlist? t) 
            #t
            (and (=zero? (coeff (first-term t))) 
                    (=zero?-termlist (rest-terms t)))))
    (put '=zero? '(sparse-termlist) =zero?-termlist)

    (put 'make 'sparse-termlist 
        (lambda (args) (tag args)))
    'done)
    ; (define (make-term order coeff) (list order coeff))
    ; (define (order term) (car term))
    ; (define (coeff term) (cadr term))

    ;; interface to the rest of the system
    ;; (define (tag p) (attach-tag 'polynomial p))
    ; (put 'add '(polynomial polynomial)
    ;     (lambda (p1 p2) (tag (add-poly p1 p2))))
    ; (put 'sub '(polynomial polynomial) 
    ;     (lambda (p1 p2) (tag (sub-poly p1 p2))))

    ; (put 'mul '(polynomial polynomial) 
    ;     (lambda (p1 p2) (tag (mul-poly p1 p2))))
    ; (put 'make 'polynomial (lambda (var terms) (tag (make-poly var terms))))
    ; (put '=zero? '(polynomial) =poly-zero?)
    ; (put 'equ? '(polynomial polynomial) poly-equ?)
    ; (put 'negate '(polynomial) (lambda (p) (tag (negate-poly p))))


(provide install-sparse-termlist-package)