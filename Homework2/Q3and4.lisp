;; lists
(defvar list1 '(a b x d))
(defvar list2 '(a (b (x d))))
(defvar list3 '(((a (b (x) d)))))

;; Accessing 'x' in (a b x d)
(print "Accessing 'x' in (a b x d):")
(print (car (cdr (cdr list1))))

;; Accessing 'x' in (a (b (x d)))
(print "Accessing 'x' in (a (b (x d))):")
(print (car (car (cdr (car (cdr list2))))))
script Q1
;; Accessing 'x' in (((a (b (x) d))))
(print "Accessing 'x' in (((a (b (x) d)))):")
(print (car (cdr (car (cdr (car (car list3)))))))

;; Constructing (a b x d)
(defvar list1 (cons 'a (cons 'b (cons 'x (cons 'd nil)))))
(print "Constructed (a b x d):")
(print list1)

;; Constructing (a (b (x d)))
(defvar list2 (cons 'a (cons (cons 'b (cons (cons 'x (cons 'd nil)) nil)) nil)))
(print "Constructed (a (b (x d))):")
(print list2)

;; Constructing (((a (b (x) d))))
(defvar list3 (cons (cons (cons 'a (cons (cons 'b (cons (cons 'x nil) (cons 'd nil))) nil)) nil) nil))
(print "Constructed (((a (b (x) d)))):")
(print list3)
