(defun insert-sorted (item sorted)
  "Inserts an item into a sorted list while maintaining ascending order."
  (cond
    ((null sorted) (list item))
    ((<= item (car sorted)) (cons item sorted))
    (t (cons (car sorted) (insert-sorted item (cdr sorted))))))

(defun insertion-sort (lst)
  "Sorts lst using the insertion sort algorithm."
  (labels ((sort-helper (sorted unsorted)
             (if (null unsorted) 
                 sorted
                 (sort-helper (insert-sorted (car unsorted) sorted) (cdr unsorted)))))
    (sort-helper nil lst)))

;; Test Case
(format t "Sorting list: (5 3 8 6 2 4 7 1)~%")
(format t "Sorted list: ~a~%" (insertion-sort '(5 3 8 6 2 4 7 1)))
