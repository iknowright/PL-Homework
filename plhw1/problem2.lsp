;; this indicate which number should split the numbers
(defun split-number (numbers)
    ;; make left hand size ceiling if it is odd number, left will be n/2 + 1
    (ceiling (/ (length numbers) 2)))

;; function to return left side split numbers
(defun left-split (numbers l)
    (cond
        ((= l 0) '())
        ( T (cons (car numbers) (left-split (cdr numbers) (- l 1)))))
)

;; function to return right side split numbers
(defun right-split (numbers l)
    (cond
        ((= l 0) numbers)        
        (T (right-split (cdr numbers) (- l 1))))
)

;; merge two numbers to one
(defun merge-two-list (left right)
    (cond
        ;; in the process if 'cdr' and 'car', ther is the chance of nil occured
        ((not right) left)
        ((not left) right)
        ;; make the sort queue here
        ((< (car left) (car right)) (cons (car left) (merge-two-list (cdr left) right)))
        (T (cons (car right) (merge-two-list left (cdr right))))
    )
)

;; mergesort itself
(defun mergesort (numbers)
    ;; it is good we take care of 'length == 1' here, and return that wait for merge-two-list to merge them
    (if (= (length numbers) 1)
        numbers
        (merge-two-list
            (mergesort (left-split numbers (split-number numbers)))
            (mergesort (right-split numbers (split-number numbers)))
        )
    )
)

;; see the recursion goes
(trace mergesort)
(trace merge-two-list)

; main function
(let 
    ((n (read))
        (numbers))
    (setf numbers
        (do ((i 0 (+ i 1))
            (tmp nil))
        ((>= i n)
            (reverse tmp))
        (setf tmp (cons (read) tmp))))
    (format t "~{~A ~}~%" (mergesort numbers)))