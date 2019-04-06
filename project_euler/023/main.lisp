;#!/bin/env runclisp.sh

(defun non-abundant-sums (limit)
  (reduce
    #'+
    (non-abundant-sums-list
      (abundant-num-list 12 limit)
      limit)))

(defun non-abundant-sums-list (lst n)
  (remove-if
    (currying #'sum-of-two-numbers-p (make-array (length lst) :initial-contents lst))
    (seq 1 n)))

(defun currying (f arg1)
  (lambda (arg2) (apply f (list arg1 arg2))))

(defun sum-of-two-numbers-p (sorted-arr n)
  (let
    ((size (array-dimension sorted-arr 0)))
    (do
      ((i 0 (1+ i)))
      ((>= i size) nil)
      (let*
        ((x (aref sorted-arr i))
         (y (- n x)))
        (cond
          ((> x n) (return nil))
          ((find-elem-a sorted-arr y)
           ;(format out-s "~A: ~A + ~A~%" n x y)
           (return t))
          (t nil)
        )))))

(defun find-elem-a
  (sorted-arr
    n
    &optional
    (left 0)
    (right (1- (array-dimension sorted-arr 0))))
  (cond
    ((equal left right)
      (equal n (aref sorted-arr left)))
    ((equal (1+ left) right)
      (or
        (equal n (aref sorted-arr left))
        (equal n (aref sorted-arr right))
      ))
    (t
      (let*
        ((center (floor (+ left right) 2))
         (pivot (aref sorted-arr center)))
        (cond
          ((< n pivot) (find-elem-a sorted-arr n left   center))
          ((> n pivot) (find-elem-a sorted-arr n center right))
          (t t)
        )))))

(defun abundant-num-list (i-start i-end)
  (remove-if-not #'abundant-num-p (seq i-start i-end)))

(defun load-abundant-num-list (file-path)
  (with-open-file (input-s (make-pathname :name file-path) :direction :input)
    (do
      ((accum-list nil (cons (parse-integer line) accum-list))
       (line (read-line input-s nil :eof) (read-line input-s nil :eof)))
      ((eq line :eof) (sort accum-list #'<))
    )))

(defun abundant-num-p (n)
  (< n
    (reduce #'+ (proper-divisors n))))

(defun proper-divisors (n)
  (let*
    ((lst (divisors-under-sqrt n))
     (rev-divs (mapcar (currying #'floor n) lst)))
    (remove-duplicates
      (append
        '(1)
        lst
        rev-divs))))

(defun divisors-under-sqrt (n)
  (remove-if-not
    #'(lambda (x) (zerop (mod n x)))
    (seq 2 (floor (sqrt n)))))

(defun seq (i-start i-end &optional (accum-list nil))
  (if
   (> i-start i-end)
   accum-list
   (seq i-start (1- i-end) (cons i-end accum-list))))

;(format t "~A~%" (find-elem-a (make-array 5 :initial-contents '(2 4 6 8 10)) 0))
;(format t "~A~%" (find-elem-a (make-array 5 :initial-contents '(2 4 6 8 10)) 1))
;(format t "~A~%" (find-elem-a (make-array 5 :initial-contents '(2 4 6 8 10)) 2))
;(format t "~A~%" (find-elem-a (make-array 5 :initial-contents '(2 4 6 8 10)) 3))
;(format t "~A~%" (find-elem-a (make-array 5 :initial-contents '(2 4 6 8 10)) 4))
;(format t "~A~%" (find-elem-a (make-array 5 :initial-contents '(2 4 6 8 10)) 5))
;(format t "~A~%" (find-elem-a (make-array 5 :initial-contents '(2 4 6 8 10)) 6))
;(format t "~A~%" (find-elem-a (make-array 5 :initial-contents '(2 4 6 8 10)) 7))
;(format t "~A~%" (find-elem-a (make-array 5 :initial-contents '(2 4 6 8 10)) 8))
;(format t "~A~%" (find-elem-a (make-array 5 :initial-contents '(2 4 6 8 10)) 9))
;(format t "~A~%" (find-elem-a (make-array 5 :initial-contents '(2 4 6 8 10)) 10))
;(format t "~A~%" (find-elem-a (make-array 5 :initial-contents '(2 4 6 8 10)) 11))

;(format t "~A~%" (proper-divisors 6))
;(format t "~A~%" (proper-divisors 12))
;(format t "~A~%" (proper-divisors 28))
;(format t "~A~%" (abundant-num-p 12))
;(format t "~A~%" (abundant-num-p 28123))
;(format t "~A~%" (abundant-num-list 12 10000))
;(dolist (x (abundant-num-list 12 28123)) (format t "~A~%" x))

;(format t "~A~%" (load-abundant-num-list "abundant_numbers.txt"))
;(format t "~A~%" (sum-of-two-numbers-p '(1 2 3) 1))
;(format t "~A~%" (sum-of-two-numbers-p '(1 2 3) 2))
;(format t "~A~%" (sum-of-two-numbers-p '(1 2 3) 3))
;(format t "~A~%" (sum-of-two-numbers-p '(1 2 3) 6))
;(format t "~A~%" (sum-of-two-numbers-p '(1 2 3) 7))
;(let ((lst (load-abundant-num-list "abundant_numbers.txt"))) (format t "~A~%" (sum-of-two-numbers-p lst 7)))
;(let ((lst (load-abundant-num-list "abundant_numbers.txt"))) (format t "~A~%" (sum-of-two-numbers-p lst 24)))

;(let ((limit 1000) (lst (load-abundant-num-list "abundant_numbers.txt"))) (format t "~A~%" (sum-of-two-elems-list-under limit lst)))
;(let ((limit 10000) (lst (load-abundant-num-list "abundant_numbers.txt"))) (format t "~A~%" (length (sum-of-two-elems-list-under limit lst))))
;(let ((limit 28123) (lst (load-abundant-num-list "abundant_numbers.txt"))) (format t "~A~%" (sum-of-two-elems-list-under limit lst)))
;(let ((limit 2000) (lst (load-abundant-num-list "abundant_numbers.txt"))) (format t "~A~%" (non-abundant-sums-list lst limit)))
;(let ((limit 28123) (lst (load-abundant-num-list "abundant_numbers.txt"))) (format t "~A~%" (non-abundant-sums-list lst limit)))

(format t "~A~%" (non-abundant-sums 28123))

