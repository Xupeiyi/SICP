#lang racket

(define (split combine-large combine-small)
  (define some-split (painter n)
    (let ((smaller (some-split painter (- n 1))))
      (combine-large painter (combine-small smaller smaller))))
  some-split)
