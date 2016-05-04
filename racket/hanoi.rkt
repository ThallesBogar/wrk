#lang racket

(define (hanoi n)
  (transfer n 'A 'B 'C)
  )
  
(define (prtmove a b)
  `((set! ,b (cons (car ,a) ,b))
    (set! ,a (append (cdr ,a)))
    (displayln (~a a b c))
    )
  )

(define (transfer n origem destino aux)
  (if (equal? n 1) (prtmove origem destino)
      (append (transfer (- n 1) origem aux destino)
	       (prtmove origem destino)
	       (transfer (- n 1) aux destino origem))
      )
  )

(define (mkhanoi pilha)
  `(let ((a (quote ,pilha))
	 (b, (quote '()))
	 (c, (quote '())))
     ,@(transfer (length pilha) 'a 'b 'c)))
  
	
