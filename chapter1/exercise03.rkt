 #lang racket
(define (sumLargerTwo a b c)
  (- (+ a b c)
     (min a b c)))