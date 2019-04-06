#! /bin/env clisp

(defun largest-palindrome-product (inclusive-min inclusive-max)
  (first (sort (palindrome-product-list inclusive-min inclusive-max) #'>)))

(defun palindrome-product-list (inclusive-min inclusive-max)
  (let
    ((accum-list))
    (do
      ((i inclusive-max (1- i)))
      ((< i inclusive-min) accum-list)
      (do
        ((j i (1- j)))
        ((< j inclusive-min) nil)
        (let
          ((product (* i j)))
          ;(format t "~A x ~A = ~A~%" i j product)
          (if
            (palindrome-p product)
            (setf accum-list (cons product accum-list))
          ))))))

(defun palindrome-p (n)
  (cond
    ((listp n) (palindrome-list-p n))
    ((stringp n) (palindrome-list-p (coerce n 'list)))
    ((numberp n) (palindrome-list-p (coerce (write-to-string n) 'list)))
    (t nil)))

(defun palindrome-list-p (remains)
  (cond
    ((< (length remains) 2) t)
    ((not (equal (first remains) (last-atom remains))) nil)
    (t (palindrome-list-p (rest (without-last remains))))
  ))

(defun last-atom (lst)
  (let
    ((last-cons (last lst)))
    (if (atom last-cons)
        last-cons
        (first last-cons))
  ))

(defun without-last (lst)
  (reverse (rest (reverse lst))))

;(let ((n '(1 0 0))) (format t "~A is palindrome: ~A~%" n (palindrome-p n)))
;(let ((n '(1 0 1))) (format t "~A is palindrome: ~A~%" n (palindrome-p n)))
;(let ((n '(1 1 0 1))) (format t "~A is palindrome: ~A~%" n (palindrome-p n)))
;(let ((n '(1 0 0 1))) (format t "~A is palindrome: ~A~%" n (palindrome-p n)))
;(let ((n 100)) (format t "~A is palindrome: ~A~%" n (palindrome-p n)))
;(let ((n 101)) (format t "~A is palindrome: ~A~%" n (palindrome-p n)))
;(let ((n 1101)) (format t "~A is palindrome: ~A~%" n (palindrome-p n)))
;(let ((n 1001)) (format t "~A is palindrome: ~A~%" n (palindrome-p n)))
;(let ((n 10) (m 99)) (format t "palindrome products from ~A to ~A: ~A~%" n m (palindrome-product n m)))
;(let ((n 100) (m 999)) (format t "palindrome products from ~A to ~A: ~A~%" n m (palindrome-product n m)))

(time (let ((n 10) (m 99)) (format t "largest palindrome product from ~A to ~A: ~A~%" n m (largest-palindrome-product n m))))
(time (let ((n 100) (m 999)) (format t "largest palindrome product from ~A to ~A: ~A~%" n m (largest-palindrome-product n m))))

