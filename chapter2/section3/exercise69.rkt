#lang racket
;; leaf
(define (make-leaf symbol weight)
  (list 'leaf symbol weight))

(define (leaf? object)
  (eq? (car object) 'leaf))

(define (symbol-leaf x) (cadr x))

(define (weight-leaf x) (caddr x))

;; tree
(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (left-branch tree) (car tree))

(define (right-branch tree) (cadr tree))

(define (symbols tree)
  (if (leaf? tree) (list (symbol-leaf tree)) (caddr tree)))

(define (weight tree)
  (if (leaf? tree) (weight-leaf tree) (cadddr tree)))

;; insert x into set and maintain an ascending order
(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set) (adjoin-set x (cdr set))))))

;; convert a list of (symbol frequency) pairs into a ordered set of leaves
(define (make-leaf-set pairs)
  (if (null? pairs) '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair) ;; symbol 
                               (cadr pair)) ;; frequency
                    (make-leaf-set (cdr pairs))))))

(define (successive-merge set)
  (if (= (length set) 1) (car set)
      (let ((first (car set))
            (second (cadr set))
            (rest (cddr set)))
        (let ((new-tree (make-code-tree first second)))
          (successive-merge (adjoin-set new-tree rest))))))


(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

;; decode
(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit -- CHOOSE-BRANCH" bit))))

(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits) '()
        (let ((next-branch (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch) (decode-1 (cdr bits) tree))
              (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))

;; encode symbol
(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((equal? x (car set)) #t)
        (else (element-of-set? x (cdr set)))))

(define (encode-symbol symbol tree)
  (define (encode-1 current-branch result)
    (if (leaf? current-branch) result
        (let ((left (left-branch current-branch))
              (right (right-branch current-branch)))
            (cond ((element-of-set? symbol (symbols left)) (encode-1 left (append result '(0))))
                  ((element-of-set? symbol (symbols right)) (encode-1 right (append result '(1))))
                  (else (error "INVALID SYMBOL -- " symbol))))))
  (encode-1 tree '()))
  
;; encode
(define (encode message tree)
  (if (null? message) '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define sample-pairs '((A 4) (B 2) (C 1) (D 1)))

(define sample-tree (generate-huffman-tree sample-pairs))

(define sample-message '(A D A B B C A))

(encode sample-message sample-tree) ;;'(0 1 1 0 0 1 0 1 0 1 1 1 0)
