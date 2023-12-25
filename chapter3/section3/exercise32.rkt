;; Suppose the delay of an and-gate is 5 ticks, and we change
;; input B to 1 and A to 0 at tick 1.
;; Then the sequence of execution is as follows.
;;
;;       tick    A     B    A^B   agenda
;;       
;;         0     1     0     0    ()
;;         1     0     1     0    ((5 1) (5 0))
;;         2     0     1     0    ((5 1) (5 0))
;;         3     0     1     0    ((5 1) (5 0))
;;         4     0     1     0    ((5 1) (5 0))
;;         5     0     1     1    ((5 0))
;;         5     0     1     0    ()
;;         
;; In the above table, each element in the agenda is a pair denoting
;; an action. The car of an action is the time to execute, and 
;; the cdr of it is the result of A^B after executing the action.
;; As we can see, after tick 6, the final result of A^B is 0, which is
;; as expected.
;; 
;; However, if we take the FILO approach, the sequence of execution will
;; be the following one.
;;
;;       tick    A     B    A^B   agenda
;;       
;;         0     1     0     0    ()
;;         1     0     1     0    ((5 1) (5 0))
;;         2     0     1     0    ((5 1) (5 0))
;;         3     0     1     0    ((5 1) (5 0))
;;         4     0     1     0    ((5 1) (5 0))
;;         5     0     1     0    ((5 1))
;;         5     0     1     1    ()
;;         
;; After tick 5, the result of A^B is 1, which is obviously wrong.