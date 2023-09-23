#lang racket

(require "../two-dimension-table.rkt" "../generic.rkt")

; (define (add x y) (apply-generic 'add x y))
; (define (sub x y) (apply-generic 'sub x y))
; (define (=zero? x) (apply-generic '=zero? x))
;(install-term-package)

; (define (make-term order coeff) 
;     ((get 'make 'term) order coeff))

; (define (coeff t) (apply-generic 'coeff t))

; (define (order t) (apply-generic 'order t))



;; (define (install-dense-term-list-package)
    ;; internal procedures
    ;; representation of poly
    ; (define (make-poly variable term-list) 
    ;     (cons variable term-list))
    ; (define (variable p) (car p))
    ; (define (term-list p) (cdr p))
    ; (define (variable? x) (symbol? x))
    ; (define (same-variable? v1 v2) (and (variable? v1) (variable? v2) (eq? v1 v2)))
    
    ;; representation of terms and term lists
    ; (define (add-terms L1 L2) 
    ;     (cond ((empty-termlist? L1) L2)
    ;           ((empty-termlist? L2) L1)
    ;           (else 
    ;             (let ((t1 (first-term L1)) (t2 (first-term L2)))
    ;                  (cond ((> (order t1) (order t2))
    ;                         (adjoin-term t1 (add-terms (rest-terms L1) L2)))
    ;                        ((< (order t1) (order t2))
    ;                         (adjoin-term t2 (add-terms (rest-terms L2) L1)))
    ;                        (else (adjoin-term (make-term (order t1) (add (coeff t1) (coeff t2)))
    ;                                           (add-terms (rest-terms L1) (rest-terms L2)))))))))
    
    ; (define (add-poly p1 p2) 
    ;     (if (same-variable? (variable p1) (variable p2))
    ;         (make-poly (variable p1) 
    ;                    (add-terms (term-list p1) (term-list p2)))
    ;         (error "Polys not in same var -- ADD-POLY" (list p1 p2))))
    
    ; (define (negate-poly p)
    ;     (define (negate-term t)
    ;         (make-term (order t) (negate (coeff t))))
    ;     (define (negate-termlist t) 
    ;         (if (empty-termlist? t) t
    ;             (adjoin-term (negate-term (first-term t)) 
    ;                          (negate-termlist (rest-terms t)))))
    ;     (make-poly (variable p) (negate-termlist (term-list p))))

    ; (define (sub-terms L1 L2)
    ;     (add-terms L1 (negate L2)))

    ; (define (sub-poly p1 p2)
    ;     (if (same-variable? (variable p1) (variable p2))
    ;         ; (make-poly (variable p1)
    ;         ;            (sub-terms (term-list p1) (term-list p2)))
    ;         (add-poly p1 (negate-poly p2))
    ;         (error "Polys not in same var -- SUB-POLY" (list p1 p2))))
    
    ; (define (mul-poly p1 p2) 
    ;     (if (same-variable? (variable p1) (variable p2))
    ;         (make-poly (variable p1) 
    ;                    (mul-terms (term-list p1) (term-list p2)))
    ;         (error "Polys not in same var -- MUL-POLY" (list p1 p2))))
    
    ; (define (mul-terms L1 L2) 
    ;     (if (empty-termlist? L1) 
    ;         (the-empty-termlist)
    ;         (add-terms (mul-term-by-all-terms (first-term L1) L2)
    ;                    (mul-terms (rest-terms L1) L2))))
    
    ; (define (mul-term-by-all-terms t1 L)
    ;     (if (empty-termlist? L)
    ;         (the-empty-termlist)
    ;         (let ((t2 (first-term L)))
    ;             (adjoin-term 
    ;                 (make-term (+ (order t1) (order t2)) 
    ;                            (mul (coeff t1) (coeff t2)))
    ;                 (mul-term-by-all-terms t1 (rest-terms L))))))
    
    ; (define (=poly-zero? p)
    ;     (define (=termlist-zero? t)
    ;         (if (empty-termlist? t) 
    ;             #t
    ;             (and (=zero? (coeff (first-term t))) 
    ;                  (=termlist-zero? (rest-terms t)))))
    ;     (=termlist-zero? (term-list p)))

    ; (define (poly-equ? p1 p2)
    ;     (define (term-equ? t1 t2)
    ;         (and (equ? (order t1) (order t2))
    ;              (equ? (coeff t1) (coeff t2))))
    ;     (define (termlist-equ? t1 t2)
    ;         (cond ((and (empty-termlist? t1) (empty-termlist? t2)) 
    ;                     #t)
    ;               ((and (not (empty-termlist? t1)) (not (empty-termlist? t2))) 
    ;                     (and (term-equ? (first-term t1) (first-term t2))
    ;                          (termlist-equ? (rest-terms t1) (rest-terms t2))))
    ;               (else #f)))
    ;     (and (same-variable? (variable p1) (variable p2))
    ;          (termlist-equ? (term-list p1) (term-list p2))))
    
    ;; inner construction and selection methods
    ;; its gauranteed that term's oder is the highest
    ; (define (adjoin-term term term-list) 
    ;     (define (adjoin-term-iter term term-list order-diff) 
    ;         (if (= order-diff 1)
    ;             (cons (coeff term) term-list)
    ;             (adjoin-term-iter term (cons 0 term-list (- order-diff 1)))))
    ;     (if (=zero? (coeff term)) 
    ;         term-list 
    ;         (adjoin-term-iter term term-list (- (order term) 
    ;                                             (- (length term-list) 1)))))
    ; (define (the-empty-termlist) '())
    ; (define (first-term term-list) 
    ;     (make-term (- (length term-list) 1) 
    ;                (car term-list)))
    ; (define (rest-terms term-list) (cdr term-list))
    ; (define (empty-termlist? term-list) (null? term-list))
    
    ; (define (make-term order coeff) (list order coeff))
    ; (define (order term) (car term))
    ; (define (coeff term) (cadr term))

    ; ;; interface to the rest of the system
    ; (define (tag-term-list term-list) (attach-tag 'dense-term-list term-list))
    ; (define (tag-term term) (attach-tag 'dense-term term))
    ; ;;(put 'make 'dense-term-list (lambda (terms) (tag-term-list t)))
    ; (put 'adjoin-term '(dense-term dense-term-list) 
    ;     (lambda (term term-list) (tag-term-list (adjoin-term term term-list))))
    ; (put 'first-term '(dense-term-list) 
    ;     (lambda (term-list) (tag-term first-term)))
    ; (put 'rest-terms '(dense-term-list) 
    ;     (lambda (term-list) (tag-term-list rest-terms)))
    ; (put 'empty-termlist? '(dense-term-list) empty-termlist?)
    ;; (define (make-term order coeff) (list order coeff))

    ;; (define (order term) (car term))
    ;; (define (coeff term) (cadr term))
    ; (define (tag p) (attach-tag 'polynomial p))
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
    ;'done)


; (define (empty-termlist? L) (apply-generic 'empty-termlist? L))
; (define (first-term L) (apply-generic 'first-term L))
; (define (rest-terms L) (apply-generic 'rest-terms L))
; (define (the-empty-termlist L) (apply-generic 'the-empty-termlist L))
; (define (adjoin-term t L) (apply-generic 'adjoin-term t L))

(define (install-polynomial-package)
    ;; internal procedures
    ;; representation of poly
    (define (make-poly variable term-list) 
        (cons variable term-list))
    (define (variable p) (car p))
    (define (term-list p) (cdr p))
    (define (variable? x) (symbol? x))
    (define (same-variable? v1 v2) (and (variable? v1) (variable? v2) (eq? v1 v2)))
    ;; representation of terms and term lists
    
    ;; need to be generic: empty-termlist? first-term rest-terms order coeff adjoin-term make-term
    ; (define (add-terms L1 L2) 
    ;     (cond ((empty-termlist? L1) L2)
    ;           ((empty-termlist? L2) L1)
    ;           (else 
    ;             (let ((t1 (first-term L1)) (t2 (first-term L2)))
    ;                  (cond ((> (order t1) (order t2))
    ;                         (adjoin-term t1 (add-terms (rest-terms L1) L2)))
    ;                        ((< (order t1) (order t2))
    ;                         (adjoin-term t2 (add-terms (rest-terms L2) L1)))
    ;                        (else (adjoin-term (make-term (order t1) (add (coeff t1) (coeff t2)))
    ;                                           (add-terms (rest-terms L1) (rest-terms L2)))))))))
    
    (define (add-poly p1 p2) 
        (if (same-variable? (variable p1) (variable p2))
            (make-poly (variable p1) 
                       (add (term-list p1) (term-list p2)))
            (error "Polys not in same var -- ADD-POLY" (list p1 p2))))
    
    (define (negate-poly p)
        ; (define (negate-term t)
        ;     (make-term (order t) (negate (coeff t))))
        ; (define (negate-termlist t) 
        ;     (if (empty-termlist? t) t
        ;         (adjoin-term (negate-term (first-term t)) 
        ;                      (negate-termlist (rest-terms t))))))
        (make-poly (variable p) (negate (term-list p))))

    ; (define (sub-terms L1 L2)
    ;     (add-terms L1 (negate L2)))

    (define (sub-poly p1 p2)
        (if (same-variable? (variable p1) (variable p2))
            ; (make-poly (variable p1)
            ;            (sub-terms (term-list p1) (term-list p2)))
            (add-poly p1 (negate-poly p2))
            (error "Polys not in same var -- SUB-POLY" (list p1 p2))))
    (put 'sub '(polynomial polynomial) 
        (lambda (p1 p2) (tag (sub-poly p1 p2))))
    
    (define (mul-poly p1 p2) 
        (if (same-variable? (variable p1) (variable p2))
            (make-poly (variable p1) 
                       (mul (term-list p1) (term-list p2)))
            (error "Polys not in same var -- MUL-POLY" (list p1 p2))))
    
    (put 'mul '(polynomial polynomial) 
        (lambda (p1 p2) (tag (mul-poly p1 p2))))
    ; (define (mul-terms L1 L2) 
    ;     (if (empty-termlist? L1) 
    ;         (the-empty-termlist L1)
    ;         (add-terms (mul-term-by-all-terms (first-term L1) L2)
    ;                    (mul-terms (rest-terms L1) L2))))
    
    ; (define (mul-term-by-all-terms t1 L)
    ;     (if (empty-termlist? L)
    ;         (the-empty-termlist L)
    ;         (let ((t2 (first-term L)))
    ;             (adjoin-term 
    ;                 (make-term (+ (order t1) (order t2)))
    ;                 (mul-term-by-all-terms t1 (rest-terms L))))))
    
    ;; it's gauranteed that term's order is the highest
    ; (define (adjoin-term term term-list) 
    ;     (if (=zero? (coeff term)) 
    ;         term-list 
    ;         (cons term term-list)))
    
    (define (=poly-zero? p)
        ; (define (=termlist-zero? t)
        ;     (if (empty-termlist? t) 
        ;         #t
        ;         (and (=zero? (coeff (first-term t))) 
        ;              (=termlist-zero? (rest-terms t)))))
        (=zero? (term-list p)))

    (define (poly-equ? p1 p2)
        ; (define (term-equ? t1 t2)
        ;     (and (equ? (order t1) (order t2))
        ;          (equ? (coeff t1) (coeff t2))))
        ; (define (termlist-equ? t1 t2)
        ;     (cond ((and (empty-termlist? t1) (empty-termlist? t2)) 
        ;                 #t)
        ;           ((and (not (empty-termlist? t1)) (not (empty-termlist? t2))) 
        ;                 (and (term-equ? (first-term t1) (first-term t2))
        ;                      (termlist-equ? (rest-terms t1) (rest-terms t2))))
        ;           (else #f)))
        (and (same-variable? (variable p1) (variable p2))
             (equ? (term-list p1) (term-list p2))))

    ; (define (the-empty-termlist) '())
    ; (define (first-term term-list) (car term-list))
    ; (define (rest-terms term-list) (cdr term-list))
    ; (define (empty-termlist? term-list) (null? term-list))
    ; (define (make-term order coeff) (list order coeff))
    ; (define (order term) (car term))
    ; (define (coeff term) (cadr term))

    ;; interface to the rest of the system
    (define (tag p) (attach-tag 'polynomial p))
    (put 'add '(polynomial polynomial)
        (lambda (p1 p2) (tag (add-poly p1 p2))))

    (put 'make 'polynomial (lambda (var terms) (tag (make-poly var terms))))
    (put '=zero? '(polynomial) =poly-zero?)
    (put 'equ? '(polynomial polynomial) poly-equ?)
    (put 'negate '(polynomial) (lambda (p) (tag (negate-poly p))))
    'done)


(provide install-polynomial-package)