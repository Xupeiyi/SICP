;; suppose for interval 1, we have lower bound a and upper bound b. width w1 = (b - a) / 2
;; for interval 2, we have lower bound c and upper bound d. width w2 = (d - c) / 2
;; for interval 1 + interval 2, the lower bound is (a + c), the upper bound is (b + d), 
;; therefore the width w3 = ((b + d) - (a + c)) / 2 = w1 + w2.
;; likewise, for interval 1 - interval 2, the width w4 = w1 - w2

;; suppose we have interval 1 (1, 11), interval 2 (0, 20), interval 3 (10, 30)
;; interval 2 and interval 3 has the same width 20.
;; however, interval 1 * interval 2 has width (11 * 20) - (1 * 0) = 220
;; interval 1 * interval 3 has width (11 * 30) - (1 * 10) = 320
;; for the same widths, we have different results for multiplication. Therefore it's not a 
;; function of the widths of intervals.
;; same reason for division.   
