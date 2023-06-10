#lang racket
(define (below painter1 painter2)
  (let ((split-point (make-vect 0.0 0.5)))
    (let ((paint-below (transform-painter painter1
                                          (make-vect 0.0 0.0)
                                          (make-vect 1.0 0.0)
                                          split-point))
          (painter-upper (transform-painter painter2
                                            split-point
                                            (make-vect 1.0 0.5)
                                            (make-vect 0.0 1.0))))
      (lambda (frame)
        (paint-below frame)
        (paint-upper frame)))))

(define (below painter1 painter2)
  (lambda (frame) (rotate90 (beside (rotate270 painter1) (rotate270 painter2)))))