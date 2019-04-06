#! /bin/env runclisp.sh

(defstruct pos i j)

(defun pos-go-r (pos)
  (make-pos
    :i (1+ (pos-i pos))
    :j (pos-j pos)))

(defun pos-go-d (pos)
  (make-pos
    :i (pos-i pos)
    :j (1+ (pos-j pos))))

(defstruct grid
  gsize
  patterns-array)

(defun make-grid-with-size (grid-size)
  (let
    ((array-size (1+ grid-size)))
    (make-grid
      :gsize grid-size
      :patterns-array (make-array (list array-size array-size)))))

(defun valid-pos-p (grid pos)
  (let
    ((size (grid-gsize grid))
     (i (pos-i pos))
     (j (pos-j pos)))
    (and
      (<= i size)
      (<= j size))))

(defun goal-p (grid pos)
  (let
    ((size (grid-gsize grid))
     (i (pos-i pos))
     (j (pos-j pos)))
    (and
      (equal i size)
      (equal j size))))

(defun get-grid-patterns (grid pos)
  (let
    ((i (pos-i pos))
     (j (pos-j pos)))
    (aref (grid-patterns-array grid) i j)
  ))

(defun set-grid-patterns (grid pos patterns)
  (let
    ((i (pos-i pos))
     (j (pos-j pos)))
    (setf (aref (grid-patterns-array grid) i j) patterns)
    (setf (aref (grid-patterns-array grid) j i) patterns))
  )
;(defun set-grid-patterns (grid pos patterns)
;  (setf (get-grid-patterns grid pos) patterns)
;  (setf (get-grid-patterns grid pos) patterns))

(defun have-patterns-p (grid pos)
  (not (null (get-grid-patterns grid pos))))

(defun path-patterns (grid &optional (pos (make-pos :i 0 :j 0)) (accum 0))
  (cond
    ((not (valid-pos-p grid pos)) 0)
    ((goal-p grid pos) 1)
    ((have-patterns-p grid pos) (get-grid-patterns grid pos))
    (t
      (let
        ((patterns (+
                     (path-patterns grid (pos-go-r pos) (1+ accum))
                     (path-patterns grid (pos-go-d pos) (1+ accum)))))
        (set-grid-patterns grid pos patterns)
        ;(format t "~A~%" grid)
        patterns
        ))))

(let ((pos (make-pos :i 2 :j 0))) (format t "go right of ~A: ~A~%" pos (pos-go-r pos)))
(let ((pos (make-pos :i 2 :j 0))) (format t "go down  of ~A: ~A~%" pos (pos-go-d pos)))
(let ((grid-size 2) (pos (make-pos :i 2 :j 2))) (format t "patterns of ~A in ~Ax~A: ~A~%" pos grid-size grid-size (path-patterns (make-grid-with-size grid-size) pos)))
(let ((grid-size 2) (pos (make-pos :i 1 :j 2))) (format t "patterns of ~A in ~Ax~A: ~A~%" pos grid-size grid-size (path-patterns (make-grid-with-size grid-size) pos)))
(let ((grid-size 2) (pos (make-pos :i 2 :j 1))) (format t "patterns of ~A in ~Ax~A: ~A~%" pos grid-size grid-size (path-patterns (make-grid-with-size grid-size) pos)))
(let ((grid-size 2) (pos (make-pos :i 0 :j 2))) (format t "patterns of ~A in ~Ax~A: ~A~%" pos grid-size grid-size (path-patterns (make-grid-with-size grid-size) pos)))
(let ((grid-size 2) (pos (make-pos :i 2 :j 0))) (format t "patterns of ~A in ~Ax~A: ~A~%" pos grid-size grid-size (path-patterns (make-grid-with-size grid-size) pos)))
(let ((grid-size 2) (pos (make-pos :i 1 :j 1))) (format t "patterns of ~A in ~Ax~A: ~A~%" pos grid-size grid-size (path-patterns (make-grid-with-size grid-size) pos)))
(let ((grid-size 2) (pos (make-pos :i 0 :j 1))) (format t "patterns of ~A in ~Ax~A: ~A~%" pos grid-size grid-size (path-patterns (make-grid-with-size grid-size) pos)))
(let ((grid-size 2) (pos (make-pos :i 1 :j 0))) (format t "patterns of ~A in ~Ax~A: ~A~%" pos grid-size grid-size (path-patterns (make-grid-with-size grid-size) pos)))
(let ((grid-size 2) (pos (make-pos :i 0 :j 0))) (format t "patterns of ~A in ~Ax~A: ~A~%" pos grid-size grid-size (path-patterns (make-grid-with-size grid-size) pos)))
(let ((grid-size 20) (pos (make-pos :i 0 :j 0))) (format t "patterns of ~A in ~Ax~A: ~A~%" pos grid-size grid-size (path-patterns (make-grid-with-size grid-size) pos)))

