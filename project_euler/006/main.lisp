#! /bin/env clisp

(defun sum-square-difference (lst)
  (- (square-of-sums-of lst) (sum-of-squares-of lst)))

(defun range (begin end)
  (if
    (> begin end)
    (reverse (range end begin))
    (do
      ((i end (1- i))
       (accum-list nil (cons i accum-list)))
      ((< i begin) accum-list)
      ()
      )))

;(format t "~A~%" (range 11 10))

(defun sum-of-squares-of (lst)
  (reduce #'+ (mapcar #'square lst)))

(defun square (n)
  (* n n))

;(format t "~A~%" (sum-of-squares-of (range 1 10)))

(defun square-of-sums-of (lst)
  (square (reduce #'+ lst)))

;(format t "~A~%" (square-of-sums-of (range 1 10)))

(let ((lst (range 1 10))) (format t "sum-square difference of ~A: ~A~%" lst (sum-square-difference lst)))
(let ((lst (range 1 100))) (format t "sum-square difference of ~A: ~A~%" lst (sum-square-difference lst)))

