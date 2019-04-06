#! /bin/env runclisp.sh

(defun primes-to (n)
  ;(reversed-primes-to n))
  (reverse (reversed-primes-to n)))

(defun reversed-primes-to (n)
  (cond
    ((< n 1) nil)
    ((equal n 1) '(2))
    ((equal n 2) '(3 2))
    (t (greater-than-2nd-primes n '(3 2) 2))))

(defun greater-than-2nd-primes (n accum-list num-primes)
  (if
    (>= num-primes n)
    accum-list
    (do
      ((x (+ 2 (first accum-list)) (+ 2 x)))
      ((prime-factor-p x accum-list) (return (greater-than-2nd-primes n (cons x accum-list) (1+ num-primes))))
      ()
    )))

(defun prime-factor-p (n reversed-primes)
  (let
    ((limit (floor (sqrt n)))
     (ascending-primes (reverse reversed-primes)))
    (dolist
      (p ascending-primes t)
      (cond
        ((> p limit) (return t))
        ((zerop (mod n p)) (return nil))
        (t nil)))))

(defun prime-p (n)
  (cond
    ((< n 2) nil)
    ((equal n 2) t)
    ((evenp n) nil)
    (t
      (let
        ((limit (floor (sqrt n))))
        (do
          ((i 3 (+ 2 i)))
          ((> i limit) t)
          (if
            (zerop (mod n i))
            (return nil))
        )))))

;(let ((n 1)) (format t "~A is prime: ~A~%" n (prime-p n)))
;(let ((n 2)) (format t "~A is prime: ~A~%" n (prime-p n)))
;(let ((n 3)) (format t "~A is prime: ~A~%" n (prime-p n)))
;(let ((n 4)) (format t "~A is prime: ~A~%" n (prime-p n)))
;(let ((n 5)) (format t "~A is prime: ~A~%" n (prime-p n)))
;(let ((n 6)) (format t "~A is prime: ~A~%" n (prime-p n)))
;(let ((n 7)) (format t "~A is prime: ~A~%" n (prime-p n)))

(time (let ((n 0)) (format t "primes to ~A: ~A~%" n (primes-to n))))
(time (let ((n 1)) (format t "primes to ~A: ~A~%" n (primes-to n))))
(time (let ((n 2)) (format t "primes to ~A: ~A~%" n (primes-to n))))
(time (let ((n 3)) (format t "primes to ~A: ~A~%" n (primes-to n))))
(time (let ((n 4)) (format t "primes to ~A: ~A~%" n (primes-to n))))
(time (let ((n 5)) (format t "primes to ~A: ~A~%" n (primes-to n))))
(time (let ((n 6)) (format t "primes to ~A: ~A~%" n (primes-to n))))
(time (let ((n 7)) (format t "primes to ~A: ~A~%" n (primes-to n))))
(time (let ((n 8)) (format t "primes to ~A: ~A~%" n (primes-to n))))
(time (let ((n 9)) (format t "primes to ~A: ~A~%" n (primes-to n))))
(time (let ((n 10)) (format t "primes to ~A: ~A~%" n (primes-to n))))
(time (let ((n 100)) (format t "primes to ~A: ~A~%" n (primes-to n))))
(time (let ((n 1000)) (format t "primes to ~A: ~A~%" n (primes-to n))))
(time (let ((n 10001)) (format t "primes to ~A: ~A~%" n (primes-to n))))

