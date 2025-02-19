(defun merge-lists (left right)
  "Merges two sorted lists into one sorted list."
  (cond
    ((null left) right)
    ((null right) left)
    ((<= (car left) (car right)) 
     (cons (car left) (merge-lists (cdr left) right)))
    (t (cons (car right) (merge-lists left (cdr right))))))

(defun partition-into-pairs (lst)
  "Partitions lst into sorted pairs."
  (if (null lst)
      nil
      (if (null (cdr lst))
          (list lst)
          (cons (merge-lists (list (car lst)) (list (cadr lst))) 
                (partition-into-pairs (cddr lst))))))

(defun merge-pass (lists)
  "Performs one pass of merging adjacent lists."
  (if (null lists)
      nil
      (if (null (cdr lists))
          lists
          (cons (merge-lists (car lists) (cadr lists)) 
                (merge-pass (cddr lists))))))

(defun bottom-up-mergesort (lst)
  "Sorts lst using the bottom-up mergesort algorithm."
  (let ((lists (partition-into-pairs lst)))
    (loop while (cdr lists) do
          (setf lists (merge-pass lists)))
    (car lists)))

;; Test Case
(format t "Sorting list: (1 7 2 1 8 6 5 3 7 9 4)~%")
(format t "Sorted list: ~a~%" (bottom-up-mergesort '(1 7 2 1 8 6 5 3 7 9 4)))
