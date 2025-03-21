;; Recursive Descent Parser for the given grammar
;; This parser processes input strings and reports errors if invalid

(defun parseG (input)
  "Parses G → x | y | z | w"
  (if (member (car input) '(x y z w))
      (values (cdr input) `(G ,(car input))) ;;Return parse tree node
      (error (format nil "Unexpected symbol at position ~A: ~A. Expected 'x', 'y', 'z', or 'w'." 
                     (- (length input) 1) (car input)))))

(defun parseEprime (input)
  "Parses E' → oG E' | ε (optional rule)"
  (if (equal (car input) 'o)
      (let ((rest (cdr input)))  ;;Consume 'o'
        (multiple-value-bind (new-rest treeG) (parseG rest)
          (if treeG
              (multiple-value-bind (final-rest treeEprime) (parseEprime new-rest)
                (values final-rest `(E' o ,treeG ,treeEprime)))  ;;Return parse tree node
              (values input nil))))
      (values input `(E' ε))))  ;;ε-case, return parse tree node

(defun parseE (input)
  "Parses E → G E'"
  (multiple-value-bind (new-rest treeG) (parseG input)
    (if treeG
        (multiple-value-bind (final-rest treeEprime) (parseEprime new-rest)
          (values final-rest `(E ,treeG ,treeEprime)))  ;;Return parse tree node
        (values input nil))))

(defun parseX (input)
  "Parses X → ε (optional, does nothing)"
  (values input `(X ε)))  ;;Always returns parse tree node

(defun parseLprime (input)
  "Parses L' → sL' | ε"
  (if (equal (car input) 's)
      (let ((rest (cdr input)))
        (multiple-value-bind (new-rest treeLprime) (parseLprime rest)
          (values new-rest `(L' s ,treeLprime))))  ;;Return parse tree node
      (values input `(L' ε))))  ;;ε-case, return parse tree node

(defun parseL (input)
  "Parses L → sL'"
  (if (equal (car input) 's)
      (let ((rest (cdr input)))
        (multiple-value-bind (new-rest treeLprime) (parseLprime rest)
          (values new-rest `(L s ,treeLprime))))  ;;Return parse tree node
      (error (format nil "Unexpected symbol at position ~A: ~A. Expected 's'." 
                     (- (length input) 1) (car input)))))

(defun parseS (input)
  "Parses S → sX | dLb"
  (if (null input)
      (error "Unexpected end of input. Expected 's' or 'd'.")
    (if (equal (car input) 's)
        (let ((rest (cdr input)))
          (multiple-value-bind (new-rest treeX) (parseX rest)
            (values new-rest `(S s ,treeX))))  ;;Return parse tree node

        (if (equal (car input) 'd)
            (let ((rest (cdr input)))
              (multiple-value-bind (new-rest treeL) (parseL rest)
                (if (and treeL (consp new-rest) (equal (car new-rest) 'b))
                    (values (cdr new-rest) `(S d ,treeL b))  ;;Consume 'b'
                    (error "Unexpected end of input. Expected 'b'."))))
            
            (error (format nil "Unexpected symbol: ~A. Expected 's' or 'd'." 
                           (if (null input) "empty input" (car input))))))))


(defun parseI (input)
  "Parses the start symbol I → iES and ensures all input is consumed."
  (if (equal (car input) 'i)
      (let ((rest (cdr input)))  ;;Move to next input symbol
        (multiple-value-bind (new-rest treeE) (parseE rest)
          (if treeE
              (multiple-value-bind (final-rest treeS) (parseS new-rest)
                (if (and treeS (null final-rest))  ;;Ensure all input is consumed
                    (values final-rest `(I i ,treeE ,treeS))  ;;Return parse tree node
                    (error (format nil "Parsing Error: Extra characters found: ~A" final-rest))))
              (values input nil))))
      (error (format nil "Unexpected symbol at position 1: ~A. Expected 'i'." (car input)))))


(defun parse (input)
  "Main parser function that starts parsing from I and returns a parse tree."
  (handler-case
      (multiple-value-bind (final-rest tree) (parseI input)
        (if (and tree (null final-rest))
            (format t "Parse Tree: ~A~%" tree)  ;;Print parse tree
            (format t "Parsing Error: Extra characters found: ~A~%" final-rest)))
    (error (c) (format t "Error: ~A~%" c))))

