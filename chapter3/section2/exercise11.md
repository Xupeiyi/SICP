reference: https://sicp.readthedocs.io/en/latest/chp3/11.html

          +----------------------------------------------------+
global -> |                                                    |
env       | make-account      acc                              |
          +----|---------------|-------------------------------+
               |       ^       |             ^
               |       |       |             |
               v       |       |   E1 -> +------------------+
             [*][*]----+       |         | balance: 90      |<----------+
              |                |         |                  |           |
              |                |         | withdraw --------------->[*][*]----> parameters: amount
              v                |         |                  |                   body: ...
  parameters: balance          |         |                  |<----------+
  body: (define withdraw ...)  |         |                  |           |
        (define deposit ...)   |         | deposit ---------------->[*][*]----> parameters: amount
        (define dispatch ...)  |         |                  |                   body: ...
        (lambda (m) ...)       |         |                  |<----------+
                               |         |                  |           |
                               +---------->dispatch --------------->[*][*]----> parameters: m
                                         |                  |                   body: ...
                                         +------------------+
                                                   ^
                                                   |
                                                   |
                                             +------------+
                                             |            |
                                       E5 -> | amount: 60 |
                                             |            |
                                             +------------+
                                            (if (>= balance amount)
                                                (begin (set! balance (- balance amount))
                                                       balance)
                                                "...")