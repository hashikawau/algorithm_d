
(require 'common)
(use-package 'common)

;--------------------------------------
;
;--------------------------------------
(defun main ()

  (time
  (format t "~A~%" (length (gen-seq 200)))
  )
)

(defun gen-seq (limit &optional (wallet (make-wallet-without-1pence)) (accum nil))
  (let
    ((new-wallet (next-wallet limit wallet)))
    (if (null new-wallet)
      accum
      (gen-seq limit new-wallet (cons wallet accum)) )))

;--------------------------------------
;
;--------------------------------------
(defstruct wallet-without-1pence
  (coin-numbers '(0 0 0 0 0 0 0))
)

(defun count-coins (wallet)
  (cond
    ((wallet-without-1pence-p wallet)
     (sum (mapcar #'* '(200 100 50 20 10 5 2) (wallet-without-1pence-coin-numbers wallet))) )
    (t nil) ))

(defun next-wallet (limit wallet)
  (first
    (remove-if-not
      #'(lambda (new-wallet) (<= (count-coins new-wallet) limit))
      (next-wallet-patterns wallet) )))

; #S(wallet (1 2 3 4))
; -> (
;     #S(wallet (1 2 3 5))
;     #S(wallet (1 2 4 0))
;     #S(wallet (2 3 0 0))
;     #S(wallet (2 0 0 0))
;    )
(defun next-wallet-patterns (wallet)
  (let*
    ((digits (wallet-without-1pence-coin-numbers wallet))
     (num-digits (length digits)))
    (mapcar
      #'(lambda (i)
          (make-wallet-without-1pence :coin-numbers (count-up digits i)))
      (reverse (seq 0 (1- num-digits))) )))

; (1 2 3 4) 3 -> (1 2 3 5)
; (1 2 3 4) 2 -> (1 2 4 0)
; (1 2 3 4) 1 -> (1 3 0 0)
; (1 2 3 4) 0 -> (2 0 0 0)
(defun count-up (digits order)
  (append
    (take order digits)
    (list (1+ (nth order digits)))
    (repeat 0 (- (length digits) order 1))))

;--------------------------------------
;
;--------------------------------------
(main)

