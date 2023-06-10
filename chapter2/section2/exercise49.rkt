#lang racket
(define outline-painter (segements->painter (list (make-segement (make-vect 0 0) (make-vect 0 1))
                                                 (make-segement (make-vect  0 1) (make-vect 1 1))
                                                 (make-segement (make-vect  1 1) (make-vect 1 0))
                                                 (make-segement (make-vect  1 0) (make-vect 0 0)))))

(define x-painter (segements->painter (list (make-segement (make-vect 0 0) (make-vect 1 1))
                                                 (make-segement (make-vect 0 1) (make-vect 1 0)))))

(define diamond-painter (segments->painter (list (make-segment (make-vect 0 0.5) (make-vect 0.5 0))
                                                 (make-segment (make-vect 0.5 0) (make-vect 1 0.5))
                                                 (make-segment (make-vect 1 0.5) (make-vect 0.5 1))
                                                 (make-segment (make-vect 0.5 1) (make-vect 0 0.5)))))