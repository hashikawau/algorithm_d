#! /bin/env runclisp.sh

(defun power-digit-sum (pow)
  (apply
    #'+
    (number-to-digit-list (expt 2 pow))))

(defun number-to-digit-list (num)
  (mapcar
    #'digit-char-p
    (coerce
      (write-to-string num)
      'list)))

(let ((pow 15)) (format t "power digit sum of 2^~A: ~A~%" pow (power-digit-sum pow)))
(let ((pow 100)) (format t "power digit sum of 2^~A: ~A~%" pow (power-digit-sum pow)))
(let ((pow 1000)) (format t "power digit sum of 2^~A: ~A~%" pow (power-digit-sum pow)))

