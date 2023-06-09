#lang racket
;; (queen-cols k) repeats (queen-cols (- k 1)) for k times. 
;; (queen-cols k) generates k levels of recursive calls, and each level becomes k times slower.
;; 64T