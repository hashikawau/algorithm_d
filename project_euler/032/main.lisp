
(require 'common)
(use-package 'common)

(defun main ()
  (time (let ((products (enumerate-pandigital-products (seq 1 4)))) (format t "~%sum=~A, ~A~%~%" (sum (mapcar #'first products)) products)))
  (time (let ((products (enumerate-pandigital-products (seq 1 5)))) (format t "~%sum=~A, ~A~%~%" (sum (mapcar #'first products)) products)))
  (time (let ((products (enumerate-pandigital-products (seq 1 6)))) (format t "~%sum=~A, ~A~%~%" (sum (mapcar #'first products)) products)))
  ;(time (let ((products (enumerate-pandigital-products (seq 1 8)))) (format t "~%sum=~A, ~A~%~%" (sum (mapcar #'first products)) products)))
  (time (let ((products (enumerate-pandigital-products (seq 1 9)))) (format t "~%sum=~A, ~A~%~%" (sum (mapcar #'first products)) products)))
)

(defun enumerate-pandigital-products (digit-lst)
  (remove-duplicates
    (reduce
      #'(lambda (accum permutated-digit-lst)
          (append
            accum
            (find-pandigital-product permutated-digit-lst)))
      (permutations digit-lst)
      :initial-value nil)
    :key #'first)
)

(defun find-pandigital-product (digit-lst)
  (let
    ((begin 1)
     (end (1- (length digit-lst)))
     (accum nil))
    (do
      ((i begin (1+ i)))
      ((>= i end) nil)
      (do
        ((j (1+ i) (1+ j)))
        ((> j end) nil)
        (let
           ((a (to-integer (sub-list digit-lst 0 i)))
            (b (to-integer (sub-list digit-lst i j)))
            (c (to-integer (sub-list digit-lst j))))
           (if (equal c (* a b))
             (setf accum (cons (list c a b) accum))
             () ))))
    accum))


(defun to-integer (digit-lst)
  (sum
    (mapcar
      #'*
      (order-lst (1- (length digit-lst)))
      (reverse digit-lst) )))

(defun order-lst (limit)
  (mapcar
    (p-apply #'expt 10)
    (seq 0 limit)) )

;(defun to-integer (digits)
;  (parse-integer
;    (apply
;      #'concatenate
;      (cons 'string (mapcar #'write-to-string digits)))))

(defun sub-list (lst i-start &optional (i-end (length lst)))
  (take
    (- i-end i-start)
    (drop
      i-start
      lst)))

(main)

