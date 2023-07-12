reference: https://sicp.readthedocs.io/en/latest/chp3/10.html

evaluating (w1 50)

              +-------------------------------------------+
global env -> |                                           |
              |   w1                                      |
              +---|---------------------------------------+
                  |                               ^
                  |          (make-withdraw 100)  |
                  |                               |
                  |                    +--------------+
                  |                    |              |
                  |             E1 ->  | initial: 100 |
                  |                    |              |
                  |                    +--------------+
                  |                               ^
                  | ((lambda (balance) ...) 100)  |
                  |                               |
                  |                    +--------------+
                  |                    |              |
                  |             E2 ->  | balance: 100 |
                  |                    |              |
                  |                    +--------------+
                  |                      |        ^  ^
                  |                      |        |  |                                    +------------+
                  |                      v        |  |                                    |            |
                  +------------------> [*][*]-----+  +------------------------------------| amount: 50 | <- E3
                                        |                                                 |            |
                                        |                                                 +------------+
                                        v
                                 parameters: amount                                    (if (>= balance amount)
                                 body: (if (>= balance amount)                             (begin (set! balance (- balance amount))
                                           (begin (set! balance (- balance amount))               balance)
                                           balance)                                        "Insufficient funds")