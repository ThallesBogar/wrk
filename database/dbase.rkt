#lang racket

(require db)
(define db #f)
(define x #f)
(define y #f)
(define z #f)

(define (writeID i)
  (call-with-output-file ".dbconf"
	 (lambda(out)
	   (write i out))
	 #:exists 'replace)
  )

(define (readID)
  (if (file-exists? ".dbconf")
      (call-with-input-file ".dbconf"
	(lambda(in)
	  (read in))) 1)
  )
		    

(define (createdb)
  (set! db (sqlite3-connect  #:database "fazenda.db"
                 #:mode 'create))
  (disconnect db)
  (set! db #f))

(define (opendb)
  (set! db (sqlite3-connect #:database "fazenda.db"
                   #:mode 'read/write)))

(define (closedb)
  (disconnect db)
  (set! db #f)
  )

(define (createTable)
  (opendb)
  (query-exec db "create table Pasto (IDPasto serial primary key, NomePasto varchar(50), QtdGado int)")
  (query-exec db "create table Compra (CodigoCompra serial primary key, IDPasto int, DataCompra varchar(10), QtdComprada int, Vendedor varchar(50), IdadeGado int, foreign key (IDPasto) references Pasto(IDPasto))")
  (query-exec db "create table Venda (CodigoVenda serial primary key, Idade int, IDPasto int, DataVenda varchar(10), QtdVendida int, Comprador varchar(50), foreign key (IDPasto) references Pasto(IDPasto))")
  (query-exec db "create table Morte (CodigoMorte serial primary key, IDPasto int, QtdMortes int, DataMorte varchar(10), CausaMorte varchar(50), Idade int, foreign key (IDPasto) references Pasto(IDPasto))")
  (query-exec db "create table Manejo (CodigoManejo serial primary key, DataManejo varchar(10), QtdRemanejada int, Idade int, IDPastoOrigem int, IDPastoDestino int, foreign key (IDPastoOrigem) references Pasto(IDPasto), foreign key (IDPastoDestino) references Pasto(IDPasto))")
  (query-exec db "create table Trato (CodigoTrato serial primary key, DataTrato varchar(10), TipoTrato varchar(50), IDPastoOrigem int, foreign key (IDPastoOrigem) references Pasto(IDPasto))")
  (query-exec db "create table Manutencao (CodigoManutencao serial primary key, DataManutencao varchar(10), TipoManutencao varchar(50), IDPastoOrigem int, foreign key (IDPastoOrigem) references Pasto(IDPasto))")
  (closedb)
  )

(define (add! Pastos Qtd)
  (opendb)
  (let [(x (readID))]
  (for ([NomePasto Pastos]
	[contador (in-range x 10000)])
    (query-exec db
		(~a "INSERT INTO Pasto VALUES('" contador "', '" NomePasto "', " Qtd ")")
		)) (writeID (+ x (length Pastos))) )
  
    (closedb)
    )

(define (listdb)
  (opendb)
  (begin0
      (list
       (query-rows db "SELECT * FROM Pasto")
       )
    (closedb)
    )
  )

(define (listdb2)
  (opendb)
  (set! x (query-rows db "SELECT * FROM Pasto"))
  (closedb)
  (list x)
  )


  
	      
