#! /bin/env runclisp.sh

(defun factorial-digit-sum (n)
  (apply #'+ (factorial-digit-list n)))

(defun factorial-digit-list (n)
  (number-to-digits (factorial n)))

(defun number-to-digits (n)
  (mapcar
    #'digit-char-p
    (coerce
      (write-to-string n)
      'list)))

(defun factorial (n &optional (accum 1))
  (if
    (< n 1)
    accum
    (factorial (1- n) (* accum n))))

(let ((n 10)) (format t "~A~%" (factorial n)))
(let ((n 10)) (format t "~A~%" (factorial-digit-list n)))
(let ((n 10)) (format t "~A~%" (factorial-digit-sum n)))
(let ((n 100)) (format t "~A~%" (factorial-digit-sum n)))

