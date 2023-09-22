#lang racket

(require "../two-dimension-table.rkt" "../generic.rkt" "term.rkt")

; (define (add x y) (apply-generic 'add x y))
; (define (sub x y) (apply-generic 'sub x y))
; (define (=zero? x) (apply-generic '=zero? x))

(define (install-dense-termlist-package)
    
    (define (tag term-list) (attach-tag 'dense-termlist term-list))
    
    ;; its gauranteed that term's order is the highest
    (define (adjoin-term term term-list) 
        (define (adjoin-term-iter term term-list order-diff) 
            (if (= order-diff 1)
                (cons (coeff term) term-list)
                (adjoin-term-iter term (cons 0 term-list (- order-diff 1)))))
        (if (=zero? (coeff term)) 
            term-list 
            (adjoin-term-iter term term-list (- (order term) 
                                                (- (length term-list) 1)))))
    (put 'adjoin-term '(term dense-term-list) 
        (lambda (term term-list) (tag (adjoin-term term term-list))))

    (define (first-term term-list) 
        (make-term (- (length term-list) 1) 
                   (car term-list)))
    (put 'first-term '(dense-termlist) first-term)

    (define (rest-terms term-list) (cdr term-list))
    (put 'rest-terms '(dense-termlist) 
        (lambda (t) (tag (rest-terms t))))

    (define (empty-termlist? term-list) (null? term-list))
    (put 'empty-termlist? '(dense-termlist) empty-termlist?)

    (define (the-empty-termlist L) '())
    (put 'the-empty-termlist '(dense-termlist) 
        (lambda (L) (tag (the-empty-termlist L))))

    (put 'make 'dense-termlist 
        (lambda (args) (tag args)))
    'done)

(provide install-dense-termlist-package)
; (install-dense-termlist-package)
; (define t1 (list (list 3 3) 
;                  (list 2 2) 
;                  (list 1 -1)))
; (define (make-dense-termlist args) ((get 'make 'dense-termlist) args))
; (make t1)