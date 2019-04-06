#! /bin/env runclisp.sh

;--------------------------------------
;
;--------------------------------------
(defun load-grid ()
  (make-array '(20 20)
              :initial-contents
              '((08 02 22 97 38 15 00 40 00 75 04 05 07 78 52 12 50 77 91 08)
                (49 49 99 40 17 81 18 57 60 87 17 40 98 43 69 48 04 56 62 00)
                (81 49 31 73 55 79 14 29 93 71 40 67 53 88 30 03 49 13 36 65)
                (52 70 95 23 04 60 11 42 69 24 68 56 01 32 56 71 37 02 36 91)
                (22 31 16 71 51 67 63 89 41 92 36 54 22 40 40 28 66 33 13 80)
                (24 47 32 60 99 03 45 02 44 75 33 53 78 36 84 20 35 17 12 50)
                (32 98 81 28 64 23 67 10 26 38 40 67 59 54 70 66 18 38 64 70)
                (67 26 20 68 02 62 12 20 95 63 94 39 63 08 40 91 66 49 94 21)
                (24 55 58 05 66 73 99 26 97 17 78 78 96 83 14 88 34 89 63 72)
                (21 36 23 09 75 00 76 44 20 45 35 14 00 61 33 97 34 31 33 95)
                (78 17 53 28 22 75 31 67 15 94 03 80 04 62 16 14 09 53 56 92)
                (16 39 05 42 96 35 31 47 55 58 88 24 00 17 54 24 36 29 85 57)
                (86 56 00 48 35 71 89 07 05 44 44 37 44 60 21 58 51 54 17 58)
                (19 80 81 68 05 94 47 69 28 73 92 13 86 52 17 77 04 89 55 40)
                (04 52 08 83 97 35 99 16 07 97 57 32 16 26 26 79 33 27 98 66)
                (88 36 68 87 57 62 20 72 03 46 33 67 46 55 12 32 63 93 53 69)
                (04 42 16 73 38 25 39 11 24 94 72 18 08 46 29 32 40 62 76 36)
                (20 69 36 41 72 30 23 88 34 62 99 69 82 67 59 85 74 04 36 16)
                (20 73 35 29 78 31 90 01 74 31 49 71 48 86 81 16 23 57 05 54)
                (01 70 54 71 83 51 54 69 16 92 33 48 61 43 52 01 89 19 67 48))
              ))

(defun product (lst)
  (reduce #'* lst))

(defun head-pos-list (grid-size)
  (let
    ((accum-list nil))
    (do
      ((i 0 (1+ i)))
      ((>= i grid-size) accum-list)
      (do
        ((j 0 (1+ j)))
        ((>= j grid-size))
        (setf accum-list (cons (list i j) accum-list))
      ))))

(defun adjacent-list (succ-pos n pos-ij &optional (accum-list nil))
  (if
    (< n 1) accum-list
    (let
      ((i (nth 0 pos-ij))
       (j (nth 1 pos-ij)))
      (adjacent-list succ-pos (1- n) (funcall succ-pos pos-ij) (cons (list i j) accum-list))
    )))

(defun make-succ-to-hor (grid-size)
  (lambda (pos-ij)
    (let
      ((i (nth 0 pos-ij))
       (j (nth 1 pos-ij)))
      (list i (mod (1+ j) grid-size)))))

(defun make-succ-to-ver (grid-size)
  (lambda (pos-ij)
    (let
      ((i (nth 0 pos-ij))
       (j (nth 1 pos-ij)))
      (list (mod (1+ i) grid-size) j))))

(defun make-succ-to-dia (grid-size)
  (lambda (pos-ij)
    (let
      ((i (nth 0 pos-ij))
       (j (nth 1 pos-ij)))
      (list (mod (1+ i) grid-size) (mod (1+ j) grid-size)))))

(defun adjacent-product (grid pos-list)
  (product
    (mapcar
      #'(lambda (pos-ij)
          (aref grid (nth 0 pos-ij) (nth 1 pos-ij)))
      pos-list)))

;(let () (format t "~A~%" (load-grid)))
;(let () (format t "~A~%" (head-pos-list 20)))
;(let () (format t "~A~%" (adjacent-list (make-succ-to-hor 20) 4 '(17 18))))
;(let () (format t "~A~%" (adjacent-list (make-succ-to-ver 20) 4 '(17 18))))
;(let () (format t "~A~%" (adjacent-list (make-succ-to-dia 20) 4 '(17 18))))
(let
  ((grid (load-grid)))
  (format t "~A~%"
    (apply #'max
      (mapcar
        #'(lambda (pos-list) (adjacent-product grid pos-list))
        (append
          (mapcar #'(lambda (head-pos) (adjacent-list (make-succ-to-hor 20) 4 head-pos)) (head-pos-list 20))
          (mapcar #'(lambda (head-pos) (adjacent-list (make-succ-to-ver 20) 4 head-pos)) (head-pos-list 20))
          (mapcar #'(lambda (head-pos) (adjacent-list (make-succ-to-dia 20) 4 head-pos)) (head-pos-list 20))
        )))))



;--------------------------------------
;
;--------------------------------------
(defun vertical-product-of-adjacent-list (grid n)
  (let
    ((grid-size (array-dimension grid 0)))
    (mapcar
      #'(lambda (head-pos) (product (vertical-adjacent grid n head-pos)))
      (vertical-head-pos-list n grid-size))
  ))

(defun vertical-head-pos-list (n grid-size)
  (let
    ((accum-list nil))
    (do
      ((i 0 (1+ i)))
      ((> (+ i n) grid-size) accum-list)
      (do
        ((j 0 (1+ j)))
        ((> (+ j 1) grid-size))
        (setf accum-list (cons (list i j) accum-list))
      ))))

(defun vertical-adjacent (grid n head-pos &optional (accum nil))
  (if
    (< n 1)
    accum
    (let
      ((i (nth 0 head-pos))
       (j (nth 1 head-pos)))
      (vertical-adjacent grid (1- n) (list (1+ i) j) (cons (aref grid i j) accum))
    )))

;--------------------------------------
;
;--------------------------------------
(defun horizontal-product-of-adjacent-list (grid n)
  (let
    ((grid-size (array-dimension grid 0)))
    (mapcar
      #'(lambda (head-pos) (product (horizontal-adjacent grid n head-pos)))
      (horizontal-head-pos-list n grid-size))
  ))

(defun horizontal-head-pos-list (n grid-size)
  (let
    ((accum-list nil))
    (do
      ((i 0 (1+ i)))
      ((> (+ i 1) grid-size) accum-list)
      (do
        ((j 0 (1+ j)))
        ((> (+ j n) grid-size))
        (setf accum-list (cons (list i j) accum-list))
      ))))

(defun horizontal-adjacent (grid n head-pos &optional (accum nil))
  (if
    (< n 1)
    accum
    (let
      ((i (nth 0 head-pos))
       (j (nth 1 head-pos)))
      (horizontal-adjacent grid (1- n) (list i (1+ j)) (cons (aref grid i j) accum))
    )))

;--------------------------------------
;
;--------------------------------------
(defun diagonal-product-of-adjacent-list (grid n)
  (let
    ((grid-size (array-dimension grid 0)))
    (mapcar
      #'(lambda (head-pos) (product (diagonal-adjacent grid n head-pos)))
      (diagonal-head-pos-list n grid-size))
  ))

(defun diagonal-head-pos-list (n grid-size)
  (let
    ((accum-list nil))
    (do
      ((i 0 (1+ i)))
      ((> (+ i n) grid-size) accum-list)
      (do
        ((j 0 (1+ j)))
        ((> (+ j n) grid-size))
        (setf accum-list (cons (list i j) accum-list))
      ))))

(defun diagonal-adjacent (grid n head-pos &optional (accum nil))
  (if
    (< n 1)
    accum
    (let
      ((i (nth 0 head-pos))
       (j (nth 1 head-pos)))
      (diagonal-adjacent grid (1- n) (list (1+ i) (1+ j)) (cons (aref grid i j) accum))
    )))

;--------------------------------------
;
;--------------------------------------
;(let () (format t "~A~%" (vertical-head-pos-list 4 20)))
;(let () (format t "~A~%" (vertical-adjacent (load-grid) 4 '(6 8))))
;(let () (format t "~A~%" (sort (vertical-product-of-adjacent-list (load-grid) 4) #'>)))

;(let () (format t "~A~%" (horizontal-head-pos-list 4 20)))
;(let () (format t "~A~%" (horizontal-adjacent (load-grid) 4 '(6 8))))
;(let () (format t "~A~%" (sort (horizontal-product-of-adjacent-list (load-grid) 4) #'>)))

;(let () (format t "~A~%" (diagonal-head-pos-list 4 20)))
;(let () (format t "~A~%" (diagonal-adjacent (load-grid) 4 '(6 8))))
;(let () (format t "~A~%" (sort (diagonal-product-of-adjacent-list (load-grid) 4) #'>)))

