
(require 'common)
(use-package 'common)

(defun main ()
  (let* ((p 4) (lst (sum-of-nth-powers p))) (format t "sum of ~A: ~A~%" lst (sum lst)))
  (let* ((p 5) (lst (sum-of-nth-powers p))) (format t "sum of ~A: ~A~%" lst (sum lst)))
  )

(defun sum-of-nth-powers (p)
  (remove-if-not
    (p-apply #'equal-to-sum-of-nth-powers-p p)
    (seq 2 (expt 10 (calc-limit p)))))

(defun equal-to-sum-of-nth-powers-p (p n)
  (equal n (digit-nth-powers p n)))

; calc i where 10^i > 9^p * i
; e.g. limit is 5
;      when p is 4
;      10000(=10^5) > 32805(=5*9^4)
(defun calc-limit (p)
  (do
    ((i 1 (1+ i)))
    (nil nil)
    (let
      ((e^i   (expt 10 i))
       (i*9^p (* i (expt 9 p))))
      (if
        (> e^i i*9^p)
        (return-from calc-limit i)
        nil ))))



(defun digit-nth-powers (p n)
  (sum (mapcar
         (pth-pow-func p)
         (to-digit-list n))))

(defun to-digit-list (n)
  (mapcar
    #'digit-char-p
    (coerce (write-to-string n) 'list)))

(defun pth-pow-func (p)
  (lambda (a) (expt a p)))


(main)

