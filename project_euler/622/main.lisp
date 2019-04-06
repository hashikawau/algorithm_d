
(require 'common)
(use-package 'common)

; example: n = 8, s(n) = 3
; l[0] = #(0 1 2 3 4 5 6 7)
; l[1] = #(0 4 1 5 2 6 3 7)
; l[2] = #(0 2 4 6 1 3 5 7)
; l[3] = #(0 1 2 3 4 5 6 7)
; -> l[0][1] = 1,
;    l[1][1(=l[0][1])] = 2,
;    l[2][2(=l[1][1])] = 4,
;    l[3][4(=l[2][4])] = 1 (stop shuffle because returned to 1)
;
; generalized, where n = length-of l
;   l[k+1][p] = 2 l[k][p]         (if l[k][p] < n/2)
;   l[k+1][p] = 2 l[k][p] - (n-1) (otherwise)
; -> whern not considered n and p, l[k][p] is possiblly be
;   l[k][p] = 2^k l[0][p]           or
;   l[k][p] = 2^k l[0][p] - 1 (n-1) or
;   l[k][p] = 2^k l[0][p] - 2 (n-1) or
;      :                            or
;   l[k][p] = 2^k l[0][p] - 2^(n-1) (n-1)
; -> so neccessary condition of returning-to-original-configuration-by-kth-riffle-shuffule is
;    to satisfy following condition
;   l[0][p] = 2^k l[0][p] - i (n-1) (where i is integer that is [1 .. 2^(n-1)])
; -> n = 1/i ((2^k - 1) l[0][p]) + 1 (where n, i is integer)
;
; for example, k=4
; -> n = 2, 4, 6, 16
;  then test
;    s( 2) = 0,
;    s( 4) = 2,
;    s( 6) = 4,
;    s(16) = 4
;
(defun main ()

  (time
  (let*
    ((rot 8)
     (limit (expt 2 rot))
     (candidates (mapcar #'1+ (factors (1- limit))))
     (result (remove-if-not #'(lambda (x) (equal rot (s x))) candidates))
    )
    (format t "~A: ~A~%" rot candidates)
    (format t "    ~A -> ~A~%" result (sum result)) )
  )

)

(defun s (n)
  (do
    ((pos (next-pos n 1) (next-pos n pos))
     (accum 1 (1+ accum)))
    ((equal 1 pos) accum)
    () ))

(defun next-pos (n pos)
  (if (< pos (floor n 2))
    (* 2 pos)
    (- (* 2 pos) (- n 1)) ))

(main)

