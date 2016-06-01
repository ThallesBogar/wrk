(ql:quickload '(hunchentoot cl-who cl-mongo))
(defpackage :retro-games
  (:use :cl :cl-who :cl-mongo :hunchentoot))

(in-package :retro-games)

(cl-mongo:db.use "fazenda")

(defparameter *compra-collection* "compra")

(defclass compra ()
  ( (data         :accessor data
	          :initarg :data)
    
    (quantidade   :accessor quantidade
		  :initarg :quantidade)
    
    (pastodestino :accessor pastodestino
	          :initarg :pastodestino)
    
    (idade        :accessor idade
	          :initarg :idade)
    
    (vendedor     :accessor vendedor
	          :initarg :vendedor)))

(defun doc->compra (compra-doc)
  (let ( ( compra (make-instance 'compra :quantidade (get-element "quantidade" compra-doc)
				 :data (get-element "data" compra-doc)
				 :pastodestino (get-element "pastodestino" compra-doc)
				 :idade (get-element "idade" compra-doc)
				 :vendedor (get-element "vendedor" compra-doc))))
    (list 
     (data compra)
     (quantidade compra)
     (pastodestino compra)
     (idade compra)
     (vendedor compra))))



(defun compra-from-data (quantidade)
  (let ( (found-compra  (docs (db.find *compra-collection*
				      ($ "quantidade" quantidade)))))
    (when found-compra
      (doc->compra found-compra))))


(defun compra-exists? (quantidade)
  (compra-from-data quantidade))


(defmethod print-object ((object compra) stream)
  (print-unreadable-object (object stream :type t)
			   (with-slots (data quantidade) object
				       (format stream "Data:~s and Quantidade:~s" data quantidade))))


