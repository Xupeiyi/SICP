#lang racket

(define (monte-carlo trials experiment) 
    (define (iter trials-remaining trials-passed)
        (cond ((= 0 trials-remaining) (/ trials-passed trials))
              ((experiment) (iter (- trials-remaining 1) (+ trials-passed 1)))
              (else (iter (- trials-remaining 1) trials-passed))))
    (iter trials 0))

;; the example given in the textbook would only generate random integers,
;; making the estimate of pi converging to 3
(define (random-in-range low high)
    (let ((range (- high low)))
        (+ low (* (random) range))))

(define (estimated-integral P x1 x2 y1 y2 trials)
    (define (experiment)
        (let ((x (random-in-range x1 x2))
              (y (random-in-range y1 y2)))
            (P x y)))
    (* (monte-carlo trials experiment) (- x2 x1) (- y2 y1)))

(define (square x) (* x x))

(define (in-circle? x y)
    (<= (+ (square (- x 5)) (square (- y 7))) (square 3)))

(define (estimate-pi trials)
    (/ (estimated-integral in-circle? 2 8 4 10 trials) 9.0))

(estimate-pi 10000000)