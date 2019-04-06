#! /bin/env runclisp.sh

(defun sunday-first-of-months ()
  (remove-if-not
    #'sunday-first-of-month-during-century-p
    (to-2000-12-31)))

(defun sunday-first-of-month-during-century-p (date)
  (if
    (and
      (< 1900 (date-year date))
      (> 2001 (date-year date))
      (equal 1 (date-day date))
      (equal 6 (mod (date-since-day date) 7)))
    t
    nil))

(defun to-2000-12-31 ()
  (enumerate-days-while-if #'(lambda (date) (< (date-year date) 2001))))

(defun enumerate-days-while-if (f &optional (accum-list (list (make-date))))
  (let
    ((next (succeed (first accum-list))))
    (if
      (not (funcall f next))
      accum-list
      (enumerate-days-while-if f (cons next accum-list)))))

(defstruct date
  (year  1900)
  (month 1)
  (day   1)
  (since-day 0))

(defun show (date)
  (format nil "~A/~A/~A(~A)" (date-year date) (date-month date) (date-day date) (date-since-day date)))

(defun succeed (date)
  (let
    ((year  (date-year  date))
     (month (date-month date))
     (day   (date-day   date))
     (since-day (date-since-day date)))
    (cond
      ((last-day-of-dec-p   date) (make-date :year  (1+ year)
                                             :month 1
                                             :day   1
                                             :since-day (1+ since-day)))
      ((last-day-of-month-p date) (make-date :year  year
                                             :month (1+ month)
                                             :day   1
                                             :since-day (1+ since-day)))
      (t                          (make-date :year  year
                                             :month month
                                             :day   (1+ day)
                                             :since-day (1+ since-day)))
    )))

(defun last-day-of-dec-p (date)
  (and
    (equal 12 (date-month date))
    (equal 31 (date-day   date))))

(defun last-day-of-month-p (date)
  (equal
    (date-day date)
    (last-day-of (normalize-month date))))

(defun normalize-month (date)
  (if
    (leap-year-feb-p date)
    102
    (date-month date)))

(defun leap-year-feb-p (date)
  (and
    (equal 2 (date-month date))
    (leap-year-p (date-year date))))

(defun leap-year-p (year)
  (cond
    ((zerop (mod year 400)) t)
    ((zerop (mod year 100)) nil)
    ((zerop (mod year   4)) t)
    (t nil)
  ))

(defun last-day-of (month)
  (let
    ((table
       '(
          (  1 . 31)
          (  2 . 28)
          (102 . 29)
          (  3 . 31)
          (  4 . 30)
          (  5 . 31)
          (  6 . 30)
          (  7 . 31)
          (  8 . 31)
          (  9 . 30)
          ( 10 . 31)
          ( 11 . 30)
          ( 12 . 31)
        )))
    (rest (assoc month table))))

;(let ((year 1900) (month  1) (day  1)) (format t "next day of ~A/~A/~A: ~A~%" year month day (succeed (make-date :year year :month month :day day))))
;(let ((year 1900) (month  1) (day 31)) (format t "next day of ~A/~A/~A: ~A~%" year month day (succeed (make-date :year year :month month :day day))))
;(let ((year 1900) (month  2) (day  1)) (format t "next day of ~A/~A/~A: ~A~%" year month day (succeed (make-date :year year :month month :day day))))
;(let ((year 1900) (month  2) (day 28)) (format t "next day of ~A/~A/~A: ~A~%" year month day (succeed (make-date :year year :month month :day day))))
;(let ((year 1904) (month  2) (day 28)) (format t "next day of ~A/~A/~A: ~A~%" year month day (succeed (make-date :year year :month month :day day))))
;(let ((year 1904) (month  2) (day 29)) (format t "next day of ~A/~A/~A: ~A~%" year month day (succeed (make-date :year year :month month :day day))))
;(let ((year 2000) (month  2) (day 28)) (format t "next day of ~A/~A/~A: ~A~%" year month day (succeed (make-date :year year :month month :day day))))
;(let ((year 2000) (month  2) (day 29)) (format t "next day of ~A/~A/~A: ~A~%" year month day (succeed (make-date :year year :month month :day day))))
;(let ((year 1900) (month  3) (day  1)) (format t "next day of ~A/~A/~A: ~A~%" year month day (succeed (make-date :year year :month month :day day))))
;(let ((year 1900) (month  3) (day 31)) (format t "next day of ~A/~A/~A: ~A~%" year month day (succeed (make-date :year year :month month :day day))))
;(let ((year 1900) (month  4) (day  1)) (format t "next day of ~A/~A/~A: ~A~%" year month day (succeed (make-date :year year :month month :day day))))
;(let ((year 1900) (month  4) (day 30)) (format t "next day of ~A/~A/~A: ~A~%" year month day (succeed (make-date :year year :month month :day day))))
;(let ((year 1900) (month  5) (day  1)) (format t "next day of ~A/~A/~A: ~A~%" year month day (succeed (make-date :year year :month month :day day))))
;(let ((year 1900) (month  5) (day 31)) (format t "next day of ~A/~A/~A: ~A~%" year month day (succeed (make-date :year year :month month :day day))))
;(let ((year 1900) (month  6) (day  1)) (format t "next day of ~A/~A/~A: ~A~%" year month day (succeed (make-date :year year :month month :day day))))
;(let ((year 1900) (month  6) (day 30)) (format t "next day of ~A/~A/~A: ~A~%" year month day (succeed (make-date :year year :month month :day day))))
;(let ((year 1900) (month  7) (day  1)) (format t "next day of ~A/~A/~A: ~A~%" year month day (succeed (make-date :year year :month month :day day))))
;(let ((year 1900) (month  7) (day 31)) (format t "next day of ~A/~A/~A: ~A~%" year month day (succeed (make-date :year year :month month :day day))))
;(let ((year 1900) (month  8) (day  1)) (format t "next day of ~A/~A/~A: ~A~%" year month day (succeed (make-date :year year :month month :day day))))
;(let ((year 1900) (month  8) (day 31)) (format t "next day of ~A/~A/~A: ~A~%" year month day (succeed (make-date :year year :month month :day day))))
;(let ((year 1900) (month  9) (day  1)) (format t "next day of ~A/~A/~A: ~A~%" year month day (succeed (make-date :year year :month month :day day))))
;(let ((year 1900) (month  9) (day 30)) (format t "next day of ~A/~A/~A: ~A~%" year month day (succeed (make-date :year year :month month :day day))))
;(let ((year 1900) (month 10) (day  1)) (format t "next day of ~A/~A/~A: ~A~%" year month day (succeed (make-date :year year :month month :day day))))
;(let ((year 1900) (month 10) (day 31)) (format t "next day of ~A/~A/~A: ~A~%" year month day (succeed (make-date :year year :month month :day day))))
;(let ((year 1900) (month 11) (day  1)) (format t "next day of ~A/~A/~A: ~A~%" year month day (succeed (make-date :year year :month month :day day))))
;(let ((year 1900) (month 11) (day 30)) (format t "next day of ~A/~A/~A: ~A~%" year month day (succeed (make-date :year year :month month :day day))))
;(let ((year 1900) (month 12) (day  1)) (format t "next day of ~A/~A/~A: ~A~%" year month day (succeed (make-date :year year :month month :day day))))
;(let ((year 1900) (month 12) (day 31)) (format t "next day of ~A/~A/~A: ~A~%" year month day (succeed (make-date :year year :month month :day day))))
;(let ((year 1900) (month 12) (day 31)) (format t "next day of ~A/~A/~A: ~A~%" year month day (succeed (make-date :year year :month month :day day))))
;(dolist (date (reverse (to-2000-12-31))) (format t "~A~%" (show date)))
;(dolist (date (reverse (sunday-first-of-months))) (format t "~A~%" (show date)))
(format t "~A~%" (length (sunday-first-of-months)))



