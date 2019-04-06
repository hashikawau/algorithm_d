#! /bin/env runclisp.sh

(defun collatz-seq (n &optional (accum-list nil))
  (cond
    ((equal n 1) (reverse (cons n accum-list)))
    ((evenp n)   (collatz-seq (/ n 2) (cons n accum-list)))
    (t           (collatz-seq (+ (* n 3) 1) (cons n accum-list)))))

(defun collatz-seq-length (n)
  (list n (length (collatz-seq n))))

(defun seq (inclusive-from inclusive-to &optional (accum-list))
  (if
    (< inclusive-to inclusive-from)
    accum-list
    (seq inclusive-from (1- inclusive-to) (cons inclusive-to accum-list))))

(defun collatz-seq-length-list (inclusive-from inclusive-to)
  (mapcar #'collatz-seq-length (seq inclusive-from inclusive-to)))

(defun longest-collatz-sequence (inclusive-from inclusive-to)
  (first
    (sort
      (collatz-seq-length-list inclusive-from inclusive-to)
      #'>
      :key #'second)))

(let ((n 13)) (format t "collatz sequence start with ~A: ~A~%" n (collatz-seq n)))
(let ((n 13)) (format t "collatz sequence length of ~A: ~A~%" n (collatz-seq-length n)))
(let ((from 1) (to 13)) (format t "seq ~A to ~A: ~A~%" from to (seq from to)))
(let ((from 1) (to 13)) (format t "collatz sequence length list ~A to ~A: ~A~%" from to (collatz-seq-length-list from to)))
(let ((from 1) (to 13)) (format t "longest collatz sequence ~A to ~A: ~A~%" from to (longest-collatz-sequence from to)))
(let ((from 1) (to 100)) (format t "longest collatz sequence ~A to ~A: ~A~%" from to (longest-collatz-sequence from to)))
(let ((from 1) (to 1000)) (format t "longest collatz sequence ~A to ~A: ~A~%" from to (longest-collatz-sequence from to)))
(let ((from 1) (to 10000)) (format t "longest collatz sequence ~A to ~A: ~A~%" from to (longest-collatz-sequence from to)))
(let ((from 1) (to 100000)) (format t "longest collatz sequence ~A to ~A: ~A~%" from to (longest-collatz-sequence from to)))
(let ((from 1) (to 1000000)) (format t "longest collatz sequence ~A to ~A: ~A~%" from to (longest-collatz-sequence from to)))

