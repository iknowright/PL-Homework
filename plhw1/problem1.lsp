;;; Problem 1.1

;; max divisor for the number to check whether it is a prime
(defun maxdivisor(n)
    (multiple-value-bind (value)(floor (sqrt n)) value)
)

;;  prime function
(defun prime(x)
    ;; building a case here, exclude 1, 2 ,treat them as special case
    (cond
        ;; we know 1 is not a prime
        ((= x 1) (print Nil))
        ;; 2 is minimun prime number
        ((= x 2) (print T))
        ;; start from 2 to the max divisor we try to divide the number with our divisors
        ;; which I am actually performing is modulus
        (T (let ((n (maxdivisor x)))
            (loop for i from 2 to n
                ;; once a divisor can be divided by the request number, it's not a prime
                when (= (mod x i) 0)
                do (return (print Nil))

                ;; traverse to the last make the number prime
                when (and (not (= (mod x i) 0)) (= i n))
                do (return (print T))
            ))
        )
    )
)

;; test cases
(print 'problem1.1-test-cases)
(prime 2)
(prime 239)
(prime 999)
(prime 17)

;;;problem 1.2

(defun palindrome(input)
    (if (equal (reverse input) input) (print T) (print Nil))
)

(print 'problem1.2-test-cases)
(palindrome '(a b c))
(palindrome '(m a d a m))
(palindrome '(cat dog))
(palindrome '())
(palindrome '(cat dog bird bird dog cat))


;;; problem 1.3

(print 'problem1.3-test-cases)


;; normal fib
(defun fib1(n)

    (cond 
        ((= n 0) 0)
        ((= n 1) 1) 
        (T (+ (fib1 (- n 1)) (fib1 (- n 2))))
    )
)

(print 'trace-case-for-normalfib)
(format t "~%")
(trace fib1)
(fib1 3)


;; tail fib
;; it is more like a for loop bu deduct the n by recursion
(defun tailfib(n a result)
    (if (= n 1)
        result
        ;; magic here
        (tailfib (- n 1) result (+ result a))
    )
)

;; special case for n=0
(defun fib2(n)
    (if (= n 0)
        0
        (tailfib n 0 1)))
    
(print 'trace-case-for-tailfib)
(format t "~%")
(trace fib2)
(fib2 8)