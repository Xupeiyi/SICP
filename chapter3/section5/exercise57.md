Let f(n) denote the number of additions to calculate the nth fibonacci number.
For the optimized procedure, 
        f(0) = 0
        f(1) = 0
        f(2) = 1
        ...
        f(n) = n - 1 (?)

While for the non-optimized procedure,
        f(0) = 0
        f(1) = 0
        ...
        f(n) = f(n - 1) + f(n - 2) + 1