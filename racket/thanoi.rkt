#lang racket

(define (hanoi n)
  (transfer n 'A 'B 'C)
  )

(define (move a b)
  (list 'MOVE a 'TO b))

(define (transfer n origem destino aux)
  (if (equal? n 1) (move origem destino)
      (append (transfer (- n 1) origem aux destino)
	(move origem destino)
	(transfer (- n 1) aux destino origem)
	)
      )
  )
