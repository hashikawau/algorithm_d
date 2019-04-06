;#! /bin/env runclisp.sh

(defun names-scores ()
  (sum (mapcar #'second (each-names-scores))))

(defun sum (lst)
  (reduce #'+ lst))

(defun each-names-scores ()
  (let
    ((lst (name-list)))
    (mapcar
      #'calc-score
      (seq 1 (length lst))
      (sort lst #'string<))))

(defun seq (i-start i-end &optional (accum-list nil))
  (if
    (> i-start i-end)
    accum-list
    (seq i-start (1- i-end) (cons i-end accum-list))))

(defun name-list ()
  (mapcar
    #'trim
    (split-string #\, (load-file "p022_names.txt"))))

(defun load-file (file-path)
  (with-open-file (input-s (make-pathname :name file-path) :direction :input)
    (do
      ((accum-str nil (concatenate 'string accum-str line))
       (line (read-line input-s nil :eof) (read-line input-s nil :eof)))
      ((eq line :eof) accum-str)
    )))

(defun split-string (delimiter target &optional (accum-list nil))
  (let
    ((pos (position delimiter target)))
    (cond
      ((zerop (length target)) accum-list)
      ((null pos) (cons target accum-list))
      ((zerop pos) (split-string delimiter
                                 (subseq target (1+ pos))
                                 accum-list))
      (t           (split-string delimiter
                                 (subseq target (1+ pos))
                                 (cons (subseq target 0 pos) accum-list)))
    )))

(defun trim (target)
  (subseq target 1 (1- (length target))))

(defun calc-score (line-no name)
  (list name
        (* line-no (sum (conv-code name)))))

(defun conv-code (str)
  (mapcar #'alphabetical-no (coerce str 'list)))

(defun alphabetical-no (ch)
  (1+ (- (char-code (char-upcase ch))
         (char-code #\A))))

;(format t "~A~%" (load-file "p022_names.txt"))
;(format t "~A~%" (split-string #\, ""))
;(format t "~A~%" (split-string #\, "string"))
;(format t "~A~%" (split-string #\, "string,str"))
;(format t "~A~%" (split-string #\, "string,str,ss"))
;(format t "~A~%" (split-string #\, (load-file "p022_names.txt")))
;(format t "~A~%" (name-list))
;(format t "~A~%" (length (name-list)))
;(format t "~A~%" (each-names-scores))
(format t "~A~%" (names-scores))

