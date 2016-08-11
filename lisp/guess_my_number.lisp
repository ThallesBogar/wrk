(defparameter *small* 1)
(defparameter *big* 100)

(defun guess_my_number ()
  (ash (+ *big* *small*) -1))

(defun smaller ()
  (setf *big* (- (guess_my_number) 1))
  (guess_my_number))

(defun bigger ()
  (setf *small* (+ (guess_my_number) 1))
  (guess_my_number))

(defun start_over ()
  (defparameter *big* 100)
  (defparameter *small* 1)
  (guess_my_number))
