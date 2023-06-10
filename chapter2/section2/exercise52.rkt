#lang racket
(define (corner-split painter n)
  (if (= n 0) painter
      (let ((up (up-split painter (- n 1)))
            ((right (right-split painter (- n 1)))
             (corner (corner-split painter (- n 1)))))
        (beside (below painter up) (below right )corner))))

(define (sqare-limit painter n)
  (let ((quarter flip-horiz ((corner-split painter n))))
    (let ((half (beside (flip-horiz quarter) quarter)))
      (below (flip-vert half) half))))