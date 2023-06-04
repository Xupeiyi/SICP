#lang racket
;; 1.
;; in the next iteration, this line:(iter (cdr things) (cons (square (car things)) answer))
;; will put the next squared item before the current result

;; 2.
;; (cons answer (square (car things))) will create a list whose
;; first element is also a list ("answers" in this situation)