
(require 'common)
(use-package 'common)

; -------------------------------------
(defun prime-p (n)
  (cond
    ((< n 2) nil)
    ((equal n 2) t)
    ((evenp n) nil)
    (t (every (p-apply (f-compose #'not #'factor-p) n) (seq 3 (floor (sqrt n)) 2))) ))

(defun factor-p (n x) (zerop (mod n x)))

; -------------------------------------
(defun main ()
  ;(let ((a 1) (b 41) (n 0)) (format t "~A~%" (quadratic a b n)))
  ;(let ((a -79) (b 1601) (n 0)) (format t "~A~%" (quadratic a b n)))
  ;(let ((f (p-apply #'+ 1 -10))) (format t "~A~%" (apply f '(2))))
  ;(let ((a 1) (b 41)) (format t "~A~%" (gen-seq (p-apply #'quadratic a b) (f-compose #'not #'prime-p))))
  ;(let ((a 1) (b 41)) (format t "~A~%" (consecutive-primes a b)))
  ;(let ((a 1) (b 41)) (format t "~A~%" (length (gen-seq (p-apply #'quadratic a b) (f-compose #'not #'prime-p)))))
  ;(let ((limit-a 99) (limit-b 100)) (format t "~A~%" (quadratic-primes limit-a limit-b)))
  (let ((limit-a 999) (limit-b 1000)) (format t "~A~%" (quadratic-primes limit-a limit-b)))
)

; -------------------------------------
(defun quadratic-primes (limit-a limit-b)
  (let
    ((accum nil))
    (do
      ((a (- limit-a) (1+ a)))
      ((> a limit-a) nil)
      (do
        ((b (- limit-b) (1+ b)))
        ((> b limit-b) nil)
        (let
          ((primes (consecutive-primes a b)))
          (if
            (< 10 (length primes))
            (setf accum (cons (list a b (length primes) (* a b)) accum))
            nil ))
      ))
    (sort accum #'> :key #'third)
  ))

(defun consecutive-primes (a b)
  (gen-seq
    (p-apply #'quadratic a b)
    (f-compose #'not #'prime-p) ))

(defun gen-seq (generator stop-cond &optional (i 0) (accum nil))
  (let
    ((v (apply generator (list i))))
    (if
      (apply stop-cond (list v))
      accum
      (gen-seq generator stop-cond (1+ i) (cons v accum)) )))

(defun quadratic (a b n)
  (+ (* n n) (* a n) b))

(main)

