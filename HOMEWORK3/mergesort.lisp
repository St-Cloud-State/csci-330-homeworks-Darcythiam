;; Define partition function
(defun partition-list (lst)
  "Splits lst into two nearly equal halves."
  (labels ((partition-helper (lst left right toggle)
             (cond
               ((null lst) (values (reverse left) (reverse right)))  ; Reverse to maintain order
               (toggle (partition-helper (cdr lst) (cons (car lst) left) right nil))
               (t (partition-helper (cdr lst) left (cons (car lst) right) t)))))
    (partition-helper lst nil nil t))) ; Start with alternating placement
;; Define merge function
(defun merge-lists (left right)
  "Merges two sorted lists into one sorted list."
  (cond
    ((null left) right)   ; If left list is empty, return right
    ((null right) left)   ; If right list is empty, return left
    ((<= (car left) (car right)) 
     (cons (car left) (merge-lists (cdr left) right))) ; Take from left
    (t (cons (car right) (merge-lists left (cdr right)))))) ; Take from right
;; Define mergesort function
(defun mergesort (lst)
  "Sorts lst using the mergesort algorithm."
  (if (or (null lst) (null (cdr lst))) ; Base case: empty or one-element list
      lst
      (multiple-value-bind (left right) (partition-list lst)
        (merge-lists (mergesort left) (mergesort right))))) ; Recursively sort & merge
;; Test Mergesort
(format t "Sorting list: (5 3 8 6 2 4 7 1)~%")
(format t "Sorted list: ~a~%" (mergesort '(5 3 8 6 2 4 7 1)))
