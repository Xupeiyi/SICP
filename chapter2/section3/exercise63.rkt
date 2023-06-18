#lang racket
;; a
;; the results are the same
;; 2-16 result: (1 3 5 7 9 11)

;; b
;; no. tree->list-1 uses an O(n) append in each step so it's slower.