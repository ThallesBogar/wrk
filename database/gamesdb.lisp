(ql:quickload '(hunchentoot cl-who cl-mongo parenscript))
(defpackage :retro-games
  (:use :cl :cl-who :cl-mongo :hunchentoot :parenscript))

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

(defun findCompra ()
  (let ( (found-compra (docs (db.find *compra-collection* :all))))
    (list-length found-compra)))



(defun printCompraAll ()
  (let ( (found-compra (docs (db.find *compra-collection* :all))))
    (loop for compra in found-compra do (format t "~a~%" (doc->compra compra)))))


(defjs map-idade ()
  (emit this.idade 1))



;;(defjs reduce-idade (c vals)
  ;;(return ((@ Array sum vals))))



(defun map-reduce ()
  (pp (mr.p ($map-reduce "compra" map-idade reduce-idade))))


(defun compra-exists? (quantidade)
  (compra-from-data quantidade))
