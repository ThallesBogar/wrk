(ql:quickload '(hunchentoot cl-mongo cl-who))

(defpackage :fazenda
  (:use :cl :hunchentoot :cl-mongo :cl-who))

(in-package :fazenda)

(start (make-instance 'easy-acceptor :port 4242))
(push (create-folder-dispatcher-and-handler "/html/"
					    #p"/home/thalles/wrk/html/")
      *dispatch-table*)

(cl-mongo:db.use "fazenda")

(defparameter *compra-collection* "compra")
(defparameter *venda-collection* "venda")
(defparameter *morte-collection* "morte")
(defparameter *manejo-collection* "manejo")
(defparameter *trato-collection* "trato")
(defparameter *manutencao-collection* "manutencao")

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



(defclass venda ()
  ( (data       :accessor data
	        :initarg :data)
    
    (quantidade :accessor quantidade
		:initarg :quantidade)
    
    (pastosaida :accessor pastosaida
	        :initarg :pastosaida)
    
    (idade      :accessor idade
	        :initarg :idade)
    
    (comprador  :accessor comprador
	        :initarg :comprador)))



(defclass morte ()
  ( (data       :accessor data
	        :initarg :data)
    
    (causa      :accessor causa
	        :initarg :causa)
    
    (quantidade :accessor quantidade
		:initarg :quantidade)
    
    (pastosaida :accessor pastosaida
	        :initarg :pastosaida)
    
    (idade      :accessor idade
	        :initarg :idade)))



(defclass manejo ()
  ( (data         :accessor data
	          :initarg :data)

    (pastodestino :accessor pastodestino
		  :initarg :pastodestino)

    (quantidade   :accessor quantidade
		  :initarg :quantidade)

    (idade        :accessor idade
	          :initarg :idade)

    (pastosaida   :accessor pastosaida
		  :initarg :pastosaida)))


(defclass trato ()
  ( (data  :accessor data
	   :initarg :data)

    (tipo  :accessor tipo
	   :initarg :tipo)

    (pasto :accessor pasto
	   :initarg :pasto))) 


(defclass manutencao ()
  ( (data  :accessor data
	   :initarg :data)

    (tipo  :accessor tipo
	   :initarg :tipo)

    (pasto :accessor pasto
	   :initarg :pasto))) 



(defun compra->doc (compra)
  ($ ($ "data"         (data compra))
     ($ "quantidade"   (quantidade compra))
     ($ "pastodestino" (pastodestino compra))
     ($ "idade"        (idade compra))
     ($ "vendedor"     (vendedor compra))))



(defun venda->doc (venda)
  ($ ($ "data"       (data venda))
     ($ "quantidade" (quantidade venda))
     ($ "pastosaida" (pastosaida venda))
     ($ "idade"      (idade venda))
     ($ "comprador"  (comprador venda))))



(defun morte->doc (morte)
  ($ ($ "data"       (data morte))
     ($ "causa"      (causa morte))
     ($ "quantidade" (quantidade morte))
     ($ "pastosaida" (pastosaida morte))
     ($ "idade"      (idade morte))))



(defun manejo->doc (manejo)
  ($ ($ "data"         (data manejo))
     ($ "pastodestino" (pastodestino manejo))
     ($ "quantidade"   (quantidade manejo))
     ($ "idade"        (idade manejo))
     ($ "pastosaida"   (pastosaida manejo))))



(defun trato->doc (trato)
  ($ ($ "data"  (data trato))
     ($ "tipo"  (tipo trato))
     ($ "pasto" (pasto trato))))



(defun manutencao->doc (trato)
  ($ ($ "data"  (data trato))
     ($ "tipo"  (tipo trato))
     ($ "pasto" (pasto trato))))



(defun add-compra (data quantidade pastodestino idade vendedor)
  (let ( (compra (make-instance 'compra
				:data         data
				:quantidade   quantidade
				:pastodestino pastodestino
 				:idade        idade
				:vendedor     vendedor)))
    (db.insert *compra-collection* (compra->doc compra))))



(defun add-venda (data quantidade pastosaida idade comprador)
  (let ( (venda (make-instance 'venda
			       :data       data
			       :quantidade quantidade
			       :pastosaida pastosaida
			       :idade      idade
			       :comprador  comprador)))
    (db.insert *venda-collection* (venda->doc venda))))



(defun add-morte (data causa quantidade pastosaida idade)
  (let ( (morte (make-instance 'morte
			       :data       data
			       :causa      causa
			       :quantidade quantidade
			       :pastosaida pastosaida
			       :idade      idade)))
    (db.insert *morte-collection* (morte->doc morte))))



(defun add-manejo (data pastodestino quantidade idade pastosaida)
  (let ( (manejo (make-instance 'manejo
				:data         data
				:pastodestino pastodestino
				:quantidade   quantidade
				:idade        idade
				:pastosaida   pastosaida)))
    (db.insert *manejo-collection* (manejo->doc manejo))))



(defun add-trato (data tipo pasto)
  (let ( (trato (make-instance 'trato
			       :data  data
			       :tipo  tipo
			       :pasto pasto)))
    (db.insert *trato-collection* (trato->doc trato))))



(defun add-manutencao (data tipo pasto)
  (let ( (manutencao (make-instance 'manutencao
			       :data  data
			       :tipo  tipo
			       :pasto pasto)))
    (db.insert *manutencao-collection* (manutencao->doc manutencao))))



(define-easy-handler (compraHandler :uri "/compra") (data quantidade pastodestino idade vendedor)
  (add-compra data quantidade pastodestino idade vendedor)
  (redirect "/html/fazenda.html"))



(define-easy-handler (vendaHandler :uri "/venda") (data quantidade pastosaida idade comprador)
  (add-venda data quantidade pastosaida idade comprador)
  (redirect "/html/fazenda.html"))



(define-easy-handler (morteHandler :uri "/morte") (data causa quantidade pastosaida idade)
  (add-morte data causa quantidade pastosaida idade)
  (redirect "/html/fazenda.html"))



(define-easy-handler (manejoHandler :uri "/manejo") (data pastodestino quantidade idade pastosaida)
  (add-manejo data pastodestino quantidade idade pastosaida)
  (redirect "/html/fazenda.html"))



(define-easy-handler (tratoHandler :uri "/trato") (data tipo pasto)
  (add-trato data tipo pasto)
  (redirect "/html/fazenda.html"))



(define-easy-handler (manutencaoHandler :uri "/manutencao") (data tipo pasto)
  (add-manutencao data tipo pasto)
  (redirect "/html/fazenda.html"))
