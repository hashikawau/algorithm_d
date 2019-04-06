

(provide 'common)

(defpackage common
  (:use common-lisp)
  (:export
    for-each
    take
    drop
    repeat
    p-apply
    f-compose
    seq
    cross-join
    permutations
    sum
    product
    factors
  ))

(in-package common)

;--------------------------------------
;
;--------------------------------------
(defun for-each (xs f)
  (dolist
    (x xs)
    (apply f (list x))))

;--------------------------------------
;
;--------------------------------------
(defun take (n lst &optional (accum nil))
  (if
    (< n 1)
    (reverse accum)
    (let
      ((x (first lst))
       (xs (rest lst)))
      (take (1- n) xs (cons x accum)) )))

(defun drop (n lst)
  (if
    (< n 1)
    lst
    (drop (1- n) (rest lst)) ))

(defun repeat (v n &optional (accum nil))
  (if (< n 1)
    accum
    (repeat v (1- n) (cons v accum))))

;--------------------------------------
;
;--------------------------------------
(defun remove-nth (n lst &optional (prev-lst nil))
  (cond
    ((>= n (length lst))
      (values lst nil) )
    ((< n 0)
      (values
        (append (reverse (rest prev-lst)) lst)
        (first prev-lst) ))
    (t
      (remove-nth
        (1- n)
        (rest lst)
        (cons (first lst) prev-lst) ))))

(defun test-remove-nth (expected-result-lst expected-removed-elem arg-n arg-lst)
  (assert
    (multiple-value-bind (result-lst removed-elem)
      (remove-nth arg-n arg-lst)
      (if (and
            (equal expected-result-lst result-lst)
            (equal expected-removed-elem removed-elem) )
        t
        (format t "fail: arg-n=~A, arg-lst=~A, actual-result-lst=~A, actual-removed-elem=~A~%" arg-n arg-lst result-lst removed-elem) ))))
(test-remove-nth '() nil 0 '())
(test-remove-nth '() nil -1 '())
(test-remove-nth '() nil 1 '())
(test-remove-nth '() 10 0 '(10))
(test-remove-nth '(10) nil -1 '(10))
(test-remove-nth '(10) nil 1 '(10))
(test-remove-nth '(20) 10 0 '(10 20))
(test-remove-nth '(10) 20 1 '(10 20))

;--------------------------------------
;
;--------------------------------------
(defun p-apply (f arg &rest args-1)
  (lambda (&rest args-2)
    (apply f (append (cons arg args-1) args-2)) ))
(let
  ((f #'(lambda (a) (format nil "~A" a))))
  (assert (equal "1" (apply (p-apply f "1") '())))
)
(let
  ((f #'(lambda (a b) (format nil "~A,~A" a b))))
  (assert (equal "1,2" (apply (p-apply f "1" "2") '())))
  (assert (equal "1,2" (apply (p-apply f "1") '("2"))))
)
(let
  ((f #'(lambda (a b c) (format nil "~A,~A,~A" a b c))))
  (assert (equal "1,2,3" (apply (p-apply f "1" "2" "3") '())))
  (assert (equal "1,2,3" (apply (p-apply f "1" "2") '("3"))))
  (assert (equal "1,2,3" (apply (p-apply f "1") '("2" "3"))))
)
(let
  ((f #'(lambda (a b c d) (format nil "~A,~A,~A,~A" a b c d))))
  (assert (equal "1,2,3,4" (apply (p-apply f "1" "2" "3" "4") '())))
  (assert (equal "1,2,3,4" (apply (p-apply f "1" "2" "3") '("4"))))
  (assert (equal "1,2,3,4" (apply (p-apply f "1" "2") '("3" "4"))))
  (assert (equal "1,2,3,4" (apply (p-apply f "1") '("2" "3" "4"))))
)

;--------------------------------------
;
;--------------------------------------
(defun f-compose (func-1 func-2 &rest func-s)
  (lambda (arg-1 &rest arg-s)
    (first (reduce
             #'(lambda (f accum)
                 (list (apply f accum)) )
             (cons func-1 (cons func-2 func-s))
             :from-end t
             :initial-value (cons arg-1 arg-s) ))))
(let
  ((f (lambda (a) (format nil "f~Af" a)))
   (g (lambda (a) (format nil "g~Ag" a)))
   (h (lambda (a) (format nil "h~Ah" a))) )
  (assert (equal "gf1fg" (apply (f-compose g f) '(1))))
  (assert (equal "fg1gf" (apply (f-compose f g) '(1))))
  (assert (equal "hgf1fgh" (apply (f-compose h g f) '(1))))
)
(let
  ((f (lambda (a b c) (format nil "f~A,~A,~Af" a b c)))
   (g (lambda (a) (format nil "g~Ag" a)))
   (h (lambda (a) (format nil "h~Ah" a))) )
  (assert (equal "gf1,2,3fg" (apply (f-compose g f) '(1 2 3))))
  (assert (equal "hgf1,2,3fgh" (apply (f-compose h g f) '(1 2 3))))
)

;--------------------------------------
;
;--------------------------------------
(defun seq (i-start i-end &optional (interval 1))
  (reverse
    (rev-seq
      i-start
      i-end
      interval
      nil)))
(defun rev-seq (i-start i-end interval accum)
  (cond
    ((< interval 1) nil)
    ((< i-end i-start) accum)
    (t (rev-seq (+ i-start interval) i-end interval (cons i-start accum))) ))
(let
  ()
  (assert (equal '(0)     (seq 0 0)))
  (assert (equal '(0 1)   (seq 0 1)))
  (assert (equal '(0 1 2) (seq 0 2)))
  (assert (equal '()      (seq 0 (- 1))))
  (assert (equal '()      (seq 0 (- 2))))
  (assert (equal '(0 1 2) (seq 0 2 1)))
  (assert (equal '(0 2)   (seq 0 2 2)))
  (assert (equal '(0)     (seq 0 2 3)))
  (assert (equal '()      (seq 0 2 0)))
  (assert (equal '()      (seq 2 0 (- 1))))
)

; -------------------------------------
;
; -------------------------------------
(defun cross-join (&rest lst-s)
  (reduce
    #'cross-join-helper
    lst-s
    :from-end t
    :initial-value '(()) ))

; vector-a = '(1 2)
; vector-b = '((3) (4))
; return = '((1 3) (1 4) (2 3) (2 4))
(defun cross-join-helper (vector-a vector-b)
 (reduce
   #'(lambda (a accum)
       (append (cross-elem a vector-b) accum) )
   vector-a
   :from-end t
   :initial-value '() ))

; a = 1
; vector-b = '((3) (4))
; return = '((1 3) (1 4))
(defun cross-elem (a vector-b)
  (mapcar
    #'(lambda (b) (cons a b))
    vector-b))

(assert (equal '()                            (cross-join '()    '()     ) ))
(assert (equal '()                            (cross-join '(1 2) '()     ) ))
(assert (equal '()                            (cross-join '()    '(10 20)) ))
(assert (equal '((1 10) (1 20) (2 10) (2 20)) (cross-join '(1 2) '(10 20)) ))
(assert (equal '()                                                                                        (cross-join '()    '()      '()) ))
(assert (equal '()                                                                                        (cross-join '(1 2) '(10 20) '()) ))
(assert (equal '((1 10 100) (1 10 200) (1 20 100) (1 20 200) (2 10 100) (2 10 200) (2 20 100) (2 20 200)) (cross-join '(1 2) '(10 20) '(100 200)) ))

;--------------------------------------
;
;--------------------------------------
(defun permutations (lst &optional (accum '(nil)))
  (if (null lst)
    accum
    (reduce
      #'append
      (mapcar
        #'(lambda (i)
            (multiple-value-bind (no-nth-lst removed-elem) (remove-nth i lst)
              (permutations
                no-nth-lst
                (mapcar (p-apply #'cons removed-elem) accum) )))
        (seq 0 (1- (length lst))) ))))

(defun test-permutations (expected-result arg-lst)
  (assert
    (equal
      expected-result
      (permutations arg-lst))))
(test-permutations '(nil) '())
(test-permutations '((1)) '(1))
(test-permutations '((2 1) (1 2)) '(1 2))
(test-permutations '((3 2 1) (2 3 1) (3 1 2) (1 3 2) (2 1 3) (1 2 3)) '(1 2 3))

;--------------------------------------
;
;--------------------------------------
(defun sum (lst) (reduce #'+ lst))
(defun product (lst) (reduce #'* lst))

;--------------------------------------
;
;--------------------------------------
(defun factors (n)
  (let*
    ((limit (floor (sqrt n)))
     (lst (list-factors-under limit n)))
    (sort
      (remove-duplicates
        (append
          lst
          (mapcar #'(lambda (x) (/ n x)) lst) ))
      #'< )))

(defun list-factors-under (limit n)
  (do
    ((i 1 (1+ i))
     (accum nil))
    ((> i limit) accum)
    (if (zerop (mod n i))
      (setf accum (cons i accum))
      ()) ))

