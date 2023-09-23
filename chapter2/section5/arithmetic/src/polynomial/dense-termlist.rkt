#lang racket

(require "../two-dimension-table.rkt" "../generic.rkt" )


(define (install-dense-termlist-package)
    (define (make-term order coeff) (list order coeff))
    (define (order term) (car term))
    (define (coeff term) (cadr term))        
    (define (negate-term t)
            (make-term (order t) (negate (coeff t))))
    
    (define (tag term-list) (attach-tag 'dense-termlist term-list))
    
    ;; its gauranteed that term's order is the highest
    (define (adjoin-term term term-list) 
        (define (adjoin-term-iter term term-list order-diff) 
            (if (= order-diff 1)
                (cons (coeff term) term-list)
                (adjoin-term-iter term (cons 0 term-list) (- order-diff 1))))
        (if (=zero? (coeff term)) 
            term-list 
            (adjoin-term-iter term term-list (- (order term) 
                                                (- (length term-list) 1)))))

    (define (first-term term-list) 
        (make-term (- (length term-list) 1) 
                   (car term-list)))

    (define (rest-terms term-list) (cdr term-list))

    (define (empty-termlist? term-list) (null? term-list))

    (define (the-empty-termlist) '())

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
    (put 'add '(dense-termlist dense-termlist) 
        (lambda (L1 L2) (tag (add-terms L1 L2))))
    
    (define (negate-termlist L) 
        (if (empty-termlist? L) L
            (cons (negate (car L)) 
                  (negate-termlist (rest-terms L)))))
    (put 'negate '(dense-termlist) 
        (lambda (L) (tag (negate-termlist L))))
    
    (define (sub-terms L1 L2)
        (add-terms L1 (negate-termlist L2)))    
    (put 'sub '(dense-termlist dense-termlist)
        (lambda (L1 L2) (tag (sub-terms L1 L2))))

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
    (put 'mul '(dense-termlist dense-termlist) 
        (lambda (L1 L2) (tag (mul-terms L1 L2))))

    (define (div-terms L1 L2)
        (if (empty-termlist? L1)
            (list (the-empty-termlist) (the-empty-termlist))
            (let ((t1 (first-term L1))
                  (t2 (first-term L2)))
                  (if (> (order t2) (order t1))
                      (list (the-empty-termlist) L1)
                      (let ((new-c (div (coeff t1) (coeff t2)))
                            (new-o (- (order t1) (order t2))))
                           (let ((rest-of-result 
                                    (div-terms (sub-terms 
                                                    L1 
                                                    (mul-term-by-all-terms 
                                                        (make-term new-o new-c) 
                                                        L2)) 
                                               L2)))
                                (list (adjoin-term (make-term new-o new-c) 
                                                   (car rest-of-result)) 
                                      (cadr rest-of-result))))))))
    (put 'div '(dense-termlist dense-termlist) 
        (lambda (L1 L2) 
            (let ((result (div-terms L1 L2)))
                 (list (tag (car result)) (tag (cadr result))))))

    (define (equ-termlist? t1 t2)
        (cond ((and (empty-termlist? t1) (empty-termlist? t2)) 
                    #t)
              ((and (not (empty-termlist? t1)) (not (empty-termlist? t2))) 
                    (and (equ? (car t1) (car t2))
                         (equ-termlist? (rest-terms t1) (rest-terms t2))))
              (else #f)))
    (put 'equ? '(dense-termlist dense-termlist) equ-termlist?)

    (put 'make 'dense-termlist 
        (lambda (args) (tag args)))
    'done)

(provide install-dense-termlist-package)