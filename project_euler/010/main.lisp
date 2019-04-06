#! /bin/env runclisp.sh

(defun summation-of-primes-below (n)
  (sum-list (primes-to (1- n))))

(defun sum-list (lst &optional (accum 0))
  (if
    (null lst)
    accum
    (sum-list (rest lst) (+ accum (first lst)))))

(defun primes-to (n)
  (let
    ((sieved-array (sieve-to n))
     (accum-list nil))
    (do
      ((i 2 (1+ i)))
      ((> i n) (reverse accum-list))
      (if
        (not (aref sieved-array i))
        (setf accum-list (cons i accum-list)))
    )))

(defun sieve-to (n)
  (let
    ((multiple-of-primes-p-array (make-array (1+ n))))
    (do
      ((i 2 (1+ i)))
      ((> i n) multiple-of-primes-p-array)
      (do
        ((j (* 2 i) (+ i j)))
        ((> j n) nil)
        (setf (aref multiple-of-primes-p-array j) t))
    )))

(let ((n 10)) (format t "summation of primes below ~A: ~A~%" n (summation-of-primes-below n)))
;(let ((n 2000000)) (format t "summation of primes below ~A: ~A~%" n (primes-to n)))
(let ((n 2000000)) (format t "summation of primes below ~A: ~A~%" n (summation-of-primes-below n)))

