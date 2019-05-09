;; make file to string-list
(defun file-to-list (file1 file2)
    (values 
        (with-open-file (stream file1)
            (loop for line = (read-line stream nil)
                while line
                collect line))
        (with-open-file (stream file2)
            (loop for line = (read-line stream nil)
                while line
                collect line))))

;; the result is a recursion call that push the answer string the answer stack
(defun result (list1 list2 l r)
    (cond
        ;; left side diff do first
        ((> l 0) (cons (format nil "~c[31m- ~a~%~c[0m" #\ESC (car list1) #\ESC) (result (cdr list1) list2 (- l 1) r)))
        ;; right side diff then
        ((> r 0) (cons (format nil "~c[32m+ ~a~%~c[0m" #\ESC (car list2) #\ESC) (result list1 (cdr list2) l (- r 1))))
        ;; we know, if diff is push until next match , if there is a match, then we have to push the matched one again , and reset the merge-list
        ((and (= l 0) (= r 0) (car list1) (car list2)) (cons (format nil " ~a~%" (car list2)) (merge-list (cdr list1) (cdr list2) (cdr list2) 0)))   
    )
)

(defun merge-list (list1 list2 list2-copy r)
    (cond
        ;; if both list1 and list2(list2-copy, is just to make the comparison purpose) both nil, return '() for result stack
        ((and (not list1) (not list2-copy))
            '())
        ;; if there is no matches following by list2, we have to clear all answer
        ((not list2-copy)
            (let ((l (length list1)))
                (result list1 list2 l r)))
        ((not list1)
            (result list1 list2 0 (length list2)))
        ;; if there is no matches on right right side we add right counter, until it meets the match or meets nil
        ((not (position (car list2-copy) list1 :test #'equal))
            (merge-list list1 list2 (cdr list2-copy) (+ r 1)))
        ;; if there is a match go to result
        ((position (car list2-copy) list1 :test #'equal)
            (let ((l (position (car list2-copy) list1 :test #'equal)))
                (result list1 list2 l r)))                  
    )
)



;; our diff
(defun diff (file1 file2)
    ;; bind the values created by 'file-to-list'
    (multiple-value-bind (list1 list2)
        (file-to-list file1 file2)
        (format t "~{~A~}" (merge-list list1 list2 list2 0))))


(format t "~%Output:~%")
(diff "file1.txt" "file2.txt")