#! /bin/env runclisp.sh

(defun maximum-path-sum
  ( triangle
    &optional
    (row 0)
    (col 0)
    (n (array-dimension triangle 0))
    (accum 0)
    (accum-list nil))
  (if
    (<= n 1)
    ;(+ accum (get-value triangle row col))
    (cons (get-value triangle row col) accum-list)
    (let
      ((current-value (get-value triangle row col))
       (d-left-value  (get-value triangle (1+ row) col))
       (d-right-value (get-value triangle (1+ row) (1+ col))))
      (if
        (> d-left-value d-right-value)
        (maximum-path-sum triangle (1+ row) col      (1- n) (+ accum current-value) (cons current-value accum-list))
        (maximum-path-sum triangle (1+ row) (1+ col) (1- n) (+ accum current-value) (cons current-value accum-list))
    ))))

(defun get-value (triangle row col)
  (aref triangle row col))

;(defun go-down-r (row col)
;  )
;
;(defun go-down-r (row col)
;  )

(defun make-triangle (type-n)
  (cond
    ((equal type-n 1)
     (make-array
       '(4 4)
       :initial-contents
       '(
          (3 0 0 0)
          (7 4 0 0)
          (2 4 6 0)
          (8 5 9 3)
        )))
    ((equal type-n 2)
     (make-array
       '(15 15)
       :initial-contents
       '(
          (75 00 00 00 00 00 00 00 00 00 00 00 00 00 00)
          (95 64 00 00 00 00 00 00 00 00 00 00 00 00 00)
          (17 47 82 00 00 00 00 00 00 00 00 00 00 00 00)
          (18 35 87 10 00 00 00 00 00 00 00 00 00 00 00)
          (20 04 82 47 65 00 00 00 00 00 00 00 00 00 00)
          (19 01 23 75 03 34 00 00 00 00 00 00 00 00 00)
          (88 02 77 73 07 63 67 00 00 00 00 00 00 00 00)
          (99 65 04 28 06 16 70 92 00 00 00 00 00 00 00)
          (41 41 26 56 83 40 80 70 33 00 00 00 00 00 00)
          (41 48 72 33 47 32 37 16 94 29 00 00 00 00 00)
          (53 71 44 65 25 43 91 52 97 51 14 00 00 00 00)
          (70 11 33 28 77 73 17 78 39 68 17 57 00 00 00)
          (91 71 52 38 17 14 91 43 58 50 27 29 48 00 00)
          (63 66 04 68 89 53 67 30 73 16 69 87 40 31 00)
          (04 62 98 27 23 09 70 98 73 93 38 53 60 04 23)
        )))
    (t nil))
  )

(defun sum (lst)
  (reduce #'+ lst))

(let ((triangle (make-triangle 1))) (format t "~A~%" triangle))
(let ((triangle (make-triangle 2))) (format t "~A~%" triangle))
(let ((triangle (make-triangle 2))) (format t "~A~%" (maximum-path-sum triangle)))
(let ((triangle (make-triangle 1))) (format t "~A~%" (sum (maximum-path-sum triangle))))
(let ((triangle (make-triangle 2))) (format t "~A~%" (sum (maximum-path-sum triangle))))

