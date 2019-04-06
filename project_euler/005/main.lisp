#! /bin/env clisp

(defun smallest-multiple-of (lst)
  (reduce #'smallest-multiple-of-2-values lst))

(defun smallest-multiple-of-2-values (bigger smaller)
  (if
    (< bigger smaller)
    (smallest-multiple-of-2-values smaller bigger)
    (* bigger (/ smaller (gcd bigger smaller)))
  ))

;(let ((n 10) (m 9)) (format t "smallest multiple of ~A, ~A: ~A~%" n m (smallest-multiple-of-2-values n m)))
;(let ((n 90) (m 8)) (format t "smallest multiple of ~A, ~A: ~A~%" n m (smallest-multiple-of-2-values n m)))
;(let ((n 360) (m 7)) (format t "smallest multiple of ~A, ~A: ~A~%" n m (smallest-multiple-of-2-values n m)))
;(let ((n 2520) (m 6)) (format t "smallest multiple of ~A, ~A: ~A~%" n m (smallest-multiple-of-2-values n m)))

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

(let ((lst (range 1 10))) (format t "smallest multiple of ~A: ~A~%" lst (smallest-multiple-of lst)))
(let ((lst (range 1 20))) (format t "smallest multiple of ~A: ~A~%" lst (smallest-multiple-of lst)))

