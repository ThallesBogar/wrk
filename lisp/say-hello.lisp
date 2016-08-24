(defun say-hello ()
  (print "Please enter your name: ")
  (let ((name (read)))
    (print "Nice to meet you, ")
    (print name)))

(defun say-hello2 ()
  (princ "Please enter your name: ")
  (let ( (name (read-line)))
    (princ "Nice to meet you, ")
    (princ name)))


