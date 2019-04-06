
(require 'common)
(use-package 'common)

(defun main ()
  (format t "~A~%" (sort (uniq-a^b 5 5) #'<))
  (format t "~A~%" (length (uniq-a^b 100 100)))
)

(defun uniq-a^b (limit-a limit-b)
  (remove-duplicates
    (mapcar
      #'(lambda (tup) (let ((a (first tup)) (b (second tup))) (expt a b)))
      (cross-join (seq 2 limit-a) (seq 2 limit-b)) )))

(main)

