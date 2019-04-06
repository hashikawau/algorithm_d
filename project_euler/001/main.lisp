#! /usr/bin/clisp -C

(defun main ()
  (format t "~A~%" (sum-of-multiples-of '(3 5) (make-number-sequence 1 999))))

(defun sum-of-multiples-of (factor-lst natural-number-lst)
  (let ((accum 0))
       (dolist (x natural-number-lst accum)
         (if (exists-any-p (mapcar #'(lambda (factor) (zerop (mod x factor))) factor-lst))
             (setf accum (+ accum x))))))

(defun make-number-sequence (inclusive-start inclusive-end &optional result-lst)
  (cond
    ((< inclusive-start inclusive-end)
     (make-number-sequence
       inclusive-start
       (1- inclusive-end)
       (cons inclusive-end result-lst)))
    ((> inclusive-start inclusive-end)
     (make-number-sequence
       inclusive-start
       (1+ inclusive-end)
       (cons inclusive-end result-lst)))
    (t
      (cons inclusive-end result-lst)) ))

(defun exists-any-p (lst)
  (dolist (x lst nil)
    (if x
        (return t))))

(main)
