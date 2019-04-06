#! /bin/env clisp

(defun largest-prime-factor (n)
  (do ((i
         (floor (sqrt n))
         (1- i))
      )
      ((< i 2))
      (if (and (zerop (mod n i))
               (primep i))
          (return i)) ))

(defun primep (n)
  (cond
    ((< n 2) nil)
    ((equal n 2) t)
    ((equal n 3) t)
    ((zerop (mod n 2)) nil)
    ((zerop (mod n 3)) nil)
    (t
      (do ((i
             5
             (+ 2 i))
           (limit-num
             (floor (sqrt n)))
          )
          ((> i limit-num) t)
          (if (zerop (mod n i))
              (return nil))
      ))
  ))

;(let ((n 0)) (format t "~A is prime: ~A~%" n (primep n)))
;(let ((n 1)) (format t "~A is prime: ~A~%" n (primep n)))
;(let ((n 2)) (format t "~A is prime: ~A~%" n (primep n)))
;(let ((n 3)) (format t "~A is prime: ~A~%" n (primep n)))
;(let ((n 4)) (format t "~A is prime: ~A~%" n (primep n)))
;(let ((n 5)) (format t "~A is prime: ~A~%" n (primep n)))
;(let ((n 6)) (format t "~A is prime: ~A~%" n (primep n)))
;(let ((n 7)) (format t "~A is prime: ~A~%" n (primep n)))
;(let ((n 8)) (format t "~A is prime: ~A~%" n (primep n)))
;(let ((n 9)) (format t "~A is prime: ~A~%" n (primep n)))
;(let ((n 10)) (format t "~A is prime: ~A~%" n (primep n)))
;(let ((n 11)) (format t "~A is prime: ~A~%" n (primep n)))
;(let ((n 12)) (format t "~A is prime: ~A~%" n (primep n)))

(let ((n 13195)) (format t "largest prime factor of ~A: ~A~%" n (largest-prime-factor n)))
(let ((n 600851475143)) (format t "largest prime factor of ~A: ~A~%" n (largest-prime-factor n)))

