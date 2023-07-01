#lang racket
(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
  (list entry left right))



;; second try on 2023-07-01

(define (list->tree elements)
  (car (partial-tree elements (length elements))))


(define (partial-tree elements n)
  (if (= n 0) (cons '() elements)
      (let ((mid (quotient (+ n 1) 2)))
        (let ((left-result (partial-tree elements (- mid 1))))
          (let ((left-tree (car left-result))
                (non-left-elements (cdr left-result)))
            (let ((root (car non-left-elements))
                  (right-result (partial-tree (cdr non-left-elements) (- n mid))))
              (let ((right-tree (car right-result))
                    (remaining-elements (cdr right-result)))
                (cons (make-tree root left-tree right-tree) remaining-elements))))))))



#|

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

;; in this function elts represents the entire list of elements to build the BST,
;; n represents the number of elements used to build the current partial tree
;; the gist is that one do not need to explicitly search for the root for the BST,
;; since when half of the list is used up, the first element of the remaining list would
;; definitely be the root, and the rest would form the right partial tree.
;; The complexity is O(n)
(define (partial-tree elts n)
  (if (= n 0) (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts) right-size)))
                  (let ((right-tree (car right-result))
                        (remaining-elts (cdr right-result)))
                    (cons (make-tree this-entry left-tree right-tree) remaining-elts))))))))

|#
(list->tree (list 1 3 5 7 9))
(list->tree (list 1 2 3 4 5 6 7 8 9 10))


