#lang racket
;; 1. explicit dispatch
;; new type:
;; modify all processes that dispatches the operations

;; new operation:
;; add another general process (with no naming conflicts)


;; 2. data-driven
;; new type:
;; add a new column to the op-type table

;; new operation:
;; add a new row to the op-type table (by modifiying every install-package process)


;; 3. message-passing
;; new type:
;; add another make-from-... process

;; new operation:
;; add new operations to each make-from-... process


;; data-driven and message-passing are most appropriate for a system in which new types must often be added
;; data-driven is also appropriate for a system in which new operations must often be added