#lang racket
(let ((items (list 1 3 (list 5 7) 9)))(car (cdaddr items)))

(caar (list (list 7)))

(let ((items (list 1
                   (list 2
                         (list 3
                               (list 4
                                     (list 5
                                           (list 6 7)))))))) (cadadr (cadadr (cadadr items))))