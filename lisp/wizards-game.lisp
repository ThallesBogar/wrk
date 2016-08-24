(defparameter *nodes* '( (living-room (you are in the living-room. A wizard is snoring loudly on the couch.))
			 (garden (you are in a beautiful garden. There is a well in front of you.))
			 (attic (you are in the attic. There is a giant welding torch in the corner.))))

(defparameter *edges* '( (living-room (garden west door)
				      (attic upstairs ladder))
			 (garden (living-room east door))
			 (attic (living-room downstairs ladder))))

(defparameter *objects* '(whiskey bucket frog chain))

(defparameter *objects-locations* '( (whiskey living-room)
				     (bucket living-room)
				     (chain garden)
				     (frog garden)))

(defparameter *location* 'living-room)


(defun describe-location (location nodes)
  (cadr (assoc location nodes)))

(defun describe-path (edge)
  `(there is a ,(caddr edge) going ,(cadr edge) from here.))

(defun describe-paths (location edges)
  (apply #'append (mapcar #'describe-path (cdr (assoc location edges)))))


(defun objects-at (loc objs obj-locs)
  (labels ( (at-loc-p (obj)
		      (eq (cadr (assoc obj obj-locs)) loc)))
	  (remove-if-not #'at-loc-p objs)))

(defun describe-objects (loc objs obj-loc)
  (labels ( (describe-obj (obj)
			     `(you see a ,obj on the floor.)))
	  (apply #'append (mapcar #'describe-obj (objects-at loc objs obj-loc)))))

(defun look ()
  (append (describe-location *location* *nodes*)
	  (describe-paths *location* *edges*)
	  (describe-objects *location* *objects* *objects-locations*)))

(defun walk (direction)
  (let ( (next (find direction (cdr (assoc *location* *edges*))
		     :key #'cadr)))
    (if next 
	(progn (setf *location* (car next))
	       (look))
	'(you can not go that way))))

(defun pickup (object)
  (cond ( (member object (objects-at *location* *objects* *objects-locations*))
	  (push (list object 'body) *objects-locations*)
	  `(you are now carrying the ,object))
	(t '(you can not get that))))

(defun pickup2 (object)
  (cond ( (member (car object) (objects-at *location* *objects* *objects-locations*))
	  (push (list (car object) 'body) *objects-locations*)
	  (print "You are now carrying the ")
	  (print (car object))
	  (pickup2 (cdr object)))
	(t `(you can not get the ,(car object)))
	(t (pickup2 (cdr object)))))

(defun inventory ()
  (cons 'items- (objects-at 'body *objects* *objects-locations*)))

(defun game-repl ()
  (let ( (cmd (game-read)))
    (unless (eq (car cmd) 'quit)
      (game-print (game-eval cmd))
      (game-repl))))

(defun game-read ()
  (let ( (cmd (read-from-string (concatenate 'string "(" (read-line) ")"))))
    (flet ( (quote-it (x)
		      (list 'quote x)))
      (cons (car cmd) (mapcar #'quote-it (cdr cmd))))))