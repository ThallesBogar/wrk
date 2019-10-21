(ql:quickload '(hunchentoot cl-mongo cl-who html-template))

(defpackage :fazenda
  (:use :cl :hunchentoot :cl-mongo :cl-who))

(in-package :fazenda)


#|(start (make-instance 'easy-acceptor :port 8080))
(push (create-folder-dispatcher-and-handler "/html/"
					    #p"/home/thalles/wrk/html/")
      *dispatch-table*)|#

(cl-mongo:db.use "fazenda")

(defvar *compra-collection* "compra")
(defvar *venda-collection* "venda")
(defvar *morte-collection* "morte")
(defvar *manejo-collection* "manejo")
(defvar *trato-collection* "trato")
(defvar *manutencao-collection* "manutencao")
(defvar *mr-compra-collection* "mr.compra")
(defvar *mr-venda-collection* "mr.venda")
(defvar *mr-morte-collection* "mr.morte")
(defvar *mr-manejos-collection* "mr.manejo.saida")
(defvar *mr-manejoe-collection* "mr.manejo.entrada")
(defvar *acceptor* NIL)

(defun start-server (port)
  (setf *acceptor* (make-instance 'easy-acceptor :port port))
  (start *acceptor*)
  (push (create-folder-dispatcher-and-handler "/html/"
					      #p"/home/thalles/wrk/html/")
	*dispatch-table*))

(defun stop-server ()
  (stop *acceptor* :soft NIL))


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

(defclass mr ()
  ( (_id   :accessor idade
	   :initarg :idade)

    (value :accessor quantidade
	   :initarg :quantidade)))



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

(defun mr->doc (mr)
  ($ ($ "idade" (idade mr))
     ($ "quantidade" (quantidade mr))))


(defun add-compra (data quantidade pastodestino idade vendedor)
  (let ( (compra (make-instance 'compra
				:data         data
				:quantidade   quantidade
				:pastodestino pastodestino
 				:idade        idade
				:vendedor     vendedor)))
    (db.insert *compra-collection* (compra->doc compra))))

(defun add-compra2 ()
  (let ( (compra (make-instance 'compra
				:data         "teste"
				:quantidade   10
				:pastodestino "teste2"
 				:idade        "teste3"
				:vendedor     "teste4")))
    (compra->doc compra)))

(defun teste ()
  (let ( (teste (make-instance 'compra
			       :data "10/12/2018"
			       :quantidade 50
			       :pastodestino "pastoteste"
			       :idade "18meses"
			       :vendedor "thalles")))
    (list :data (data teste)
	  :quantidade (quantidade teste)
	  :pastodestino (pastodestino teste)
	  :idade (idade teste)
	  :vendedor (vendedor teste))))



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



(defun fill-compra-template ()
  (let ( (found-compra (docs (db.find *compra-collection* :all))))
    (with-output-to-string (stream)
			   (html-template:fill-and-print-template
			    #P"/home/thalles/wrk/html/compraTable.html"
			    (list :historicoCompra
				  (loop for compra in found-compra collect
					(let ( (compra-object (make-instance 'compra
									     :data         (get-element "data" compra)
									     :quantidade   (get-element "quantidade" compra)
									     :pastodestino (get-element "pastodestino" compra)
									     :idade        (get-element "idade" compra)
									     :vendedor     (get-element "vendedor" compra))))
					  (list :data         (data compra-object)
						:quantidade   (quantidade compra-object)
						:pastodestino (pastodestino compra-object)
						:idade        (idade compra-object)
						:vendedor     (vendedor compra-object)))))
			    :stream stream))))



(defun fill-venda-template ()
  (let ( (found-venda (docs (db.find *venda-collection* :all))))
    (with-output-to-string (stream)
			   (html-template:fill-and-print-template
			    #P"/home/thalles/wrk/html/vendaTable.html"
			    (list :historicoVenda
				  (loop for venda in found-venda collect
					(let ( (venda-object (make-instance 'venda
									     :data          (get-element "data" venda)
									     :quantidade    (get-element "quantidade" venda)
									     :pastosaida    (get-element "pastosaida" venda)
									     :idade         (get-element "idade" venda)
									     :comprador     (get-element "comprador" venda))))
					  (list :data          (data venda-object)
						:quantidade    (quantidade venda-object)
						:pastosaida    (pastosaida venda-object)
						:idade         (idade venda-object)
						:comprador     (comprador venda-object)))))
			    :stream stream))))



(defun fill-manejo-template ()
  (let ( (found-manejo (docs (db.find *manejo-collection* :all))))
    (with-output-to-string (stream)
			   (html-template:fill-and-print-template
			    #P"/home/thalles/wrk/html/manejoTable.html"
			    (list :historicoManejo
				  (loop for manejo in found-manejo collect
					(let ( (manejo-object (make-instance 'manejo
									     :data            (get-element "data" manejo)
									     :pastodestino    (get-element "pastodestino" manejo)
									     :quantidade      (get-element "quantidade" manejo)
									     :idade           (get-element "idade" manejo)
									     :pastosaida      (get-element "pastosaida" manejo))))
					  (list :data            (data manejo-object)
						:pastodestino    (pastodestino manejo-object)
						:quantidade      (quantidade manejo-object)
						:idade           (idade manejo-object)
						:pastosaida      (pastosaida manejo-object)))))
			    :stream stream))))



(defun fill-morte-template ()
  (let ( (found-morte (docs (db.find *morte-collection* :all))))
    (with-output-to-string (stream)
			   (html-template:fill-and-print-template
			    #P"/home/thalles/wrk/html/morteTable.html"
			    (list :historicoMorte
				  (loop for morte in found-morte collect
					(let ( (morte-object (make-instance 'morte
									     :data       (get-element "data" morte)
									     :causa      (get-element "causa" morte)
									     :quantidade (get-element "quantidade" morte)
									     :pastosaida (get-element "pastosaida" morte)
									     :idade      (get-element "idade" morte))))
					  (list :data       (data morte-object)
						:causa      (causa morte-object)
						:quantidade (quantidade morte-object)
						:pastosaida (pastosaida morte-object)
						:idade      (idade morte-object)))))
			    :stream stream))))



(defun fill-trato-template ()
  (let ( (found-trato (docs (db.find *trato-collection* :all))))
    (with-output-to-string (stream)
			   (html-template:fill-and-print-template
			    #P"/home/thalles/wrk/html/tratoTable.html"
			    (list :historicoTrato
				  (loop for trato in found-trato collect
					(let ( (trato-object (make-instance 'trato
									     :data  (get-element "data" trato)
									     :tipo  (get-element "tipo" trato)
									     :pasto (get-element "pasto" trato))))
					  (list :data  (data trato-object)
						:tipo  (tipo trato-object)
						:pasto (pasto trato-object)))))
			    :stream stream))))



(defun fill-manutencao-template ()
  (let ( (found-manutencao (docs (db.find *manutencao-collection* :all))))
    (with-output-to-string (stream)
			   (html-template:fill-and-print-template
			    #P"/home/thalles/wrk/html/manutencaoTable.html"
			    (list :historicoManutencao
				  (loop for manutencao in found-manutencao collect
					(let ( (manutencao-object (make-instance 'manutencao
									     :data  (get-element "data" manutencao)
									     :tipo  (get-element "tipo" manutencao)
									     :pasto (get-element "pasto" manutencao))))
					  (list :data  (data manutencao-object)
						:tipo  (tipo manutencao-object)
						:pasto (pasto manutencao-object)))))
			    :stream stream))))

(defun fill-mr-template ()
  (let ( (found-mr-compra (docs (db.find *mr-compra-collection*   :all)))
	 (found-mr-venda (docs (db.find *mr-venda-collection*     :all)))
	 (found-mr-morte (docs (db.find *mr-morte-collection*     :all)))
	 (found-mr-manejos (docs (db.find *mr-manejos-collection* :all)))
	 (found-mr-manejoe (docs (db.find *mr-manejoe-collection* :all))))
    (with-output-to-string (stream)
			   (html-template:fill-and-print-template
			    #P"/home/thalles/wrk/html/pastoTable.html"
			    (list :pastoTable
				  (loop for mr-compra in found-mr-compra collect
					(let( (mr-compra-object (make-instance 'mr
									       :idade      (doc-id mr-compra)
									       :quantidade (get-element "value" mr-compra))))
					  (list :idade      (idade mr-compra-object)
						:quantidade (quantidade mr-compra-object)))))
			    :stream stream))))

(defun inspect-teste ()
  (let ( (found-mr-compra (docs (db.find *mr-compra-collection* :all))))
    (inspect found-mr-compra)))
  
  

(define-easy-handler (compraHandler :uri "/compra") (data quantidade pastodestino idade vendedor)
  (when (and data quantidade pastodestino idade vendedor)
    (add-compra data (read-from-string quantidade) pastodestino idade vendedor)
    (redirect "/html/fazenda.html")))



(define-easy-handler (vendaHandler :uri "/venda") (data quantidade pastosaida idade comprador)
  (add-venda data (read-from-string quantidade) pastosaida idade comprador)
  (redirect "/html/fazenda.html"))



(define-easy-handler (morteHandler :uri "/morte") (data causa quantidade pastosaida idade)
  (add-morte data causa (read-from-string quantidade) pastosaida idade)
  (redirect "/html/fazenda.html"))



(define-easy-handler (manejoHandler :uri "/manejo") (data pastodestino quantidade idade pastosaida)
  (add-manejo data pastodestino (read-from-string quantidade) idade pastosaida)
  (redirect "/html/fazenda.html"))



(define-easy-handler (tratoHandler :uri "/trato") (data tipo pasto)
  (add-trato data tipo pasto)
  (redirect "/html/fazenda.html"))



(define-easy-handler (manutencaoHandler :uri "/manutencao") (data tipo pasto)
  (add-manutencao data tipo pasto)
  (redirect "/html/fazenda.html"))



(define-easy-handler (compraTableHandler :uri "/compraTable.html") ()
  (fill-compra-template))



(define-easy-handler (vendaTableHandler :uri "/vendaTable.html") ()
  (fill-venda-template))



(define-easy-handler (manejoTableHandler :uri "/manejoTable.html") ()
  (fill-manejo-template))



(define-easy-handler (morteTableHandler :uri "/morteTable.html") ()
  (fill-morte-template))



(define-easy-handler (tratoTableHandler :uri "/tratoTable.html") ()
  (fill-trato-template))



(define-easy-handler (manutencaoTableHandler :uri "/manutencaoTable.html") ()
  (fill-manutencao-template))



(defjs map-func ()
  (emit this.idade this.quantidade))

(defjs reduce-func (k vals)
  (let ((sum 0))
    (dolist (c vals)
      (incf sum c))
    (return sum)))


(defun mr-compra ()
  (pp (mr.p ($map-reduce *compra-collection* map-func reduce-func
			 :out "mr.compra"
			 :query ($ "pastodestino" "Alto Zé Doroteia")))))

;   Pasto_Total_Gado = (Pasto_Compra_Gado + Pasto_Manejo_Entrada_Gado) - (Pasto_Venda_Gado + Pasto_Morte_Gado + Pasto_Manejo_Saída_Gado)

(defun mr-venda ()
  (pp (mr.p ($map-reduce *venda-collection* map-func reduce-func
			 :out "mr.venda"
			 :query ($ "pastosaida" "Alto Zé Doroteia")))))
(defun mr-venda ()
  (pp (mr.p ($map-reduce *venda-collection* map-func reduce-func
			 :out "mr.venda"
			 :query ($ "pastosaida" "Alto Zé Doroteia")))))

(defun mr-morte ()
  (pp (mr.p ($map-reduce *morte-collection* map-func reduce-func
			 :out "mr.morte"
			 :query ($ "pastosaida" "Alto Zé Doroteia")))))

(defun mr-manejo-entrada ()
  (pp (mr.p ($map-reduce *manejo-collection* map-func reduce-func
			 :out "mr.manejo.entrada"
			 :query ($ "pastodestino" "Alto Zé Doroteia")))))

(defun mr-manejo-saida ()
  (pp (mr.p ($map-reduce *manejo-collection* map-func reduce-func
			 :out "mr.manejo.saida"
			 :query ($ "pastosaida" "Alto Zé Dorotéia")))))
