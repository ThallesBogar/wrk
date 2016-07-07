(ql:quickload '(hunchentoot html-template cl-mongo))

(defpackage :teste
  (:use :cl :hunchentoot :html-template :cl-mongo))

(in-package :teste)

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


(defun fill-compra-template ()
  (let ( (found-compra (docs (db.find *compra-collection* :all))))
    (with-output-to-string (stream)
			   (html-template:fill-and-print-template
			    #P"/home/thalles/wrk/html/teste.html"
			    (list :historicoCompra
				  (loop for compra in found-compra collect
					(let ( (compra-object (make-instance 'compra :data (get-element "data" compra)
									     :quantidade (get-element "quantidade" compra)
									     :pastodestino (get-element "pastodestino" compra)
									     :idade (get-element "idade" compra)
									     :vendedor (get-element "vendedor" compra))))
					  (list :data (data compra-object)
						:quantidade (quantidade compra-object)
						:pastodestino (pastodestino compra-object)
						:idade (idade compra-object)
						:vendedor (vendedor compra-object)))))
			    :stream stream))))
