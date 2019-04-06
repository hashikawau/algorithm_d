#! /bin/env runclisp.sh

(defun combination (n)
  (let
    ((accum-list nil))
    (do
      ((i 1 (1+ i)))
      ; terminate if i exceeds limit that
      ;   a(=i) < b(>=i+1) < c(>=i+2)
      ;   and a+b+c = n
      ;   is true
      ; -> n < i+(i+1)+(i+2) = (i+i+i+3)
      ((< n (+ i i i 3))
       (mapcar
         #'(lambda (sorted-triplet) (list sorted-triplet (pythagorean-p sorted-triplet)))
         accum-list))
      (do
        ((j (+ i i 1) (1+ j)))
        ; terminate if j exceeds limit that
        ;   a(=i) < b(=j-i) < c(>=j-i+1)
        ;   and a+b+c = n
        ;   is true
        ; -> n < i+(j-i)+(j-i+1) = j+j+1-i
        ((< n (- (+ j j 1) i)))
        (let
          ; a < b < c
          ((a i)
           (b (- j i))
           (c (- n j)))
          (setf accum-list (cons (list a b c) accum-list)))))
  ))

(defun pythagorean-p (sorted-triplet)
  (let
    ((a (first sorted-triplet))
     (b (second sorted-triplet))
     (c (third sorted-triplet)))
    (equal
      (+ (square a) (square b))
      (square c))))

(defun square (n)
  (* n n))

(defun compare-list (lst-1 lst-2)
  (string<
    (format nil "~A" lst-1)
    (format nil "~A" lst-2)))

(defun product-list (lst)
  (apply #'* lst))

(let ((n 5)) (format t "~A: ~A~%" n (combination n)))
(let ((n 10)) (format t "~A: ~A~%" n (combination n)))

(let ((n 10)) (format t "~A: ~A~%" n (combination n)))
;(let ((n 1000)) (format t "~A: ~A~%" n (combination n)))
;(let ((n 1000)) (format t "~A: ~A~%" n (remove-if-not #'(lambda (x) (second x)) (combination n))))
(let ((n 1000)) (format t "~A: ~A~%" n (product-list (first (first (remove-if-not #'(lambda (x) (second x)) (combination n)))))))

