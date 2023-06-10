#lang racket
;; (queen-cols k) repeats (queen-cols (- k 1)) for board-size times. 
;; for board-size = 8, it becomes 8**8 times slower