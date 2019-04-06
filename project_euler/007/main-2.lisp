#! /bin/env runclisp.sh

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

(time (let ((n 0)) (format t "primes to ~A: ~A~%" n (primes-to n))))
(time (let ((n 1)) (format t "primes to ~A: ~A~%" n (primes-to n))))
(time (let ((n 2)) (format t "primes to ~A: ~A~%" n (primes-to n))))
(time (let ((n 3)) (format t "primes to ~A: ~A~%" n (primes-to n))))
(time (let ((n 4)) (format t "primes to ~A: ~A~%" n (primes-to n))))
(time (let ((n 5)) (format t "primes to ~A: ~A~%" n (primes-to n))))
(time (let ((n 6)) (format t "primes to ~A: ~A~%" n (primes-to n))))
(time (let ((n 7)) (format t "primes to ~A: ~A~%" n (primes-to n))))
(time (let ((n 100)) (format t "primes to ~A: ~A~%" n (primes-to n))))
(time (let ((n 1000)) (format t "primes to ~A: ~A~%" n (length (primes-to n)))))
(time (let ((n 10000)) (format t "primes to ~A: ~A~%" n (length (primes-to n)))))
(time (let ((n 100000)) (format t "primes to ~A: ~A~%" n (length (primes-to n)))))
(time (let ((n 1000000)) (format t "primes to ~A: ~A~%" n (nth (1- 10001) (primes-to n)))))

