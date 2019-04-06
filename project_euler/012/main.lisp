
(defstruct generator
  (i 0)
  (n 1))

(defun next (generator)
  (let
    ((i (generator-i generator))
     (n (generator-n generator)))
    (make-generator
      :i (1+ i)
      :n (+ 2 i n))))

(defun proc-until
  (stop-cond
   proc
   &optional
   (generator (make-generator)))
  (let
    ((i (generator-i generator))
     (n (generator-n generator)))
    (if
      (apply stop-cond (list i n))
      nil
      (progn
        (apply proc (list i n))
        (proc-until stop-cond proc (next generator))))))

(defun currying (f arg1)
  (lambda (arg2 arg3) (apply f (list arg1 arg2 arg3))))

(defun num-of-divisors (n)
  (length (divisors n)))

(defun divisors (n)
  (let*
    ((first-half  (divisors-under-sqrt n))
     (second-half (mapcar (quotient-of n) first-half)))
    (remove-duplicates (append first-half second-half))
   ))

(defun quotient-of (n)
  (lambda (x) (floor n x)))

(defun divisors-under-sqrt (n)
  (remove-if-not (divisor-of-p n) (seq 1 (floor (sqrt n)))))

(defun divisor-of-p (n)
  (lambda (x) (zerop (mod n x))))

(defun seq (i-start i-end &optional (accum-list nil))
  (if
    (> i-start i-end)
    accum-list
    (seq i-start (1- i-end) (cons i-end accum-list))))

(defun num-of-divisors-over-n-p (limit)
  (lambda (i n) (< limit (num-of-divisors n))))

(defun highly-divisible-triangular-number (limit)
  (let
    ((last-i 0)
     (last-n 1))
    (proc-until
      (num-of-divisors-over-n-p limit)
      #'(lambda (i n)
          (setf last-i i
                last-n n)))
    (generator-n (next (make-generator :i last-i :n last-n)))))

;(format t "~A~%" (proc-until (currying #'over-p 100)))
;(format t "~A~%" (divisors-under-sqrt 28))
;(format t "~A~%" (divisors-under-sqrt 25))
;(format t "~A~%" (divisors 28))
;(format t "~A~%" (divisors 25))
;(let ((v)) (proc-until (num-of-divisors-over-n-p 500) #'(lambda (i n) (setf v n))) (format t "~A~%" v))
(format t "~A~%" (highly-divisible-triangular-number 500))

