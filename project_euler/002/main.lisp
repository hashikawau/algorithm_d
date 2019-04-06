#! /bin/env clisp

(defun sum-of-even-fibonacci-numbers (limit-elem)
  (let ((accum 0))
       (dolist (x (fibonacci-seq limit-elem) accum)
               (if (evenp x)
                   (setf accum (+ x accum)) ))))

(defun fibonacci-seq (limit-elem &optional (reverse-seq '(2 1)))
  (let ((next-elem (+ (first reverse-seq) (second reverse-seq))))
       (if (>= next-elem limit-elem)
           reverse-seq
           (fibonacci-seq limit-elem (cons next-elem reverse-seq)))))

;(format t "~A~%" (fibonacci-seq 4000000))
(format t "~A~%" (sum-of-even-fibonacci-numbers 4000000))

