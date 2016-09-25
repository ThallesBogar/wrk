#lang racket
(require rackunit)
(require racket/class)


(define (p-nand a b)
  (cond
    [(and (= a 1) (= b 1)) 0]
    [else 1]))
; nand usando λ (lambda)
;(define pnand2
;  (λ (a b)
;    (cond
;      [(and (= a 1) (= b 1)) 1]
;      [else 0])))

;testes pnand
(check-equal? (p-nand 0 0) 1)
(check-equal? (p-nand 0 1) 1)
(check-equal? (p-nand 1 0) 1)
(check-equal? (p-nand 1 1) 0)

; definicao da porta not (p-not) usando pnand somente
(define (p-not a)
  (p-nand a a))
(check-equal? (p-not 1) 0)
(check-equal? (p-not 0) 1)


;definicao da porta and (p-nand) usando pnand somente
(define (p-and a b)
  (p-nand (p-nand a b) (p-nand a b)))
;testes pnand
(check-equal? (p-and 0 0) 0)
(check-equal? (p-and 0 1) 0)
(check-equal? (p-and 1 0) 0)
(check-equal? (p-and 1 1) 1)


;definicao da porta or (p-or) usando pnand somente
(define (p-or a b)
  (p-nand (p-nand a a) (p-nand b b)))
;testes por
(check-equal? (p-or 0 0) 0)
(check-equal? (p-or 0 1) 1)
(check-equal? (p-or 1 0) 1)
(check-equal? (p-or 1 1) 1)

;XOR = (a and not b) or (not a and b)
;~(~(~(a & b) & a) & ~(~(a & b) & b))
(define (p-xor a b)
  (p-nand (p-nand (p-nand a b) a)
         (p-nand (p-nand a b) b)))
;testes pxor
(check-equal? (p-xor 0 0) 0)
(check-equal? (p-xor 0 1) 1)
(check-equal? (p-xor 1 0) 1)
(check-equal? (p-xor 1 1) 0)


;pmux 
(define (p-mux a b sel)
  (p-nand (p-nand a (p-not sel)) (p-nand b sel)))

;testes pxor
(check-equal? (p-mux 0 0 0) 0)
(check-equal? (p-mux 0 1 0) 0)
(check-equal? (p-mux 1 0 0) 1)
(check-equal? (p-mux 1 1 0) 1)
(check-equal? (p-mux 0 0 1) 0)
(check-equal? (p-mux 0 1 1) 1)
(check-equal? (p-mux 1 0 1) 0)
(check-equal? (p-mux 1 1 1) 1)

;pdmux
(define (p-dmux input sel)
    (list (p-and (p-not sel) input) (p-and sel input)))

(check-equal? (p-dmux 0 0) '(0 0))
(check-equal? (p-dmux 0 1) '(0 0))
(check-equal? (p-dmux 1 0) '(1 0))
(check-equal? (p-dmux 1 1) '(0 1))

;pdmux4way

(define (p-dmux4way input sel1 sel2)
  (let ([notsel1 (p-not sel1)] [notsel2 (p-not sel2)])
    (list
         (p-and (p-and notsel1 notsel2) input)
         (p-and (p-and notsel1 sel2) input)
         (p-and (p-and sel1 notsel2) input)
         (p-and (p-and sel1 sel2) input)
         )))

(check-equal? (p-dmux4way 1 0 0) (list 1 0 0 0))
(check-equal? (p-dmux4way 1 0 1) (list 0 1 0 0))
(check-equal? (p-dmux4way 1 1 0) (list 0 0 1 0))
(check-equal? (p-dmux4way 1 1 1) (list 0 0 0 1))
(check-equal? (p-dmux4way 0 0 0) (list 0 0 0 0))
(check-equal? (p-dmux4way 0 0 1) (list 0 0 0 0))
(check-equal? (p-dmux4way 0 1 0) (list 0 0 0 0))
(check-equal? (p-dmux4way 0 1 1) (list 0 0 0 0))



(define (p-dmux4way2 input list-sel)
  (let* ([sel1 (first list-sel)]
         [sel2 (second list-sel)]
         [notsel1 (p-not sel1)]
         [notsel2 (p-not sel2)])
    (list
         (p-and (p-and notsel1 notsel2) input)
         (p-and (p-and notsel1 sel2) input)
         (p-and (p-and sel1 notsel2) input)
         (p-and (p-and sel1 sel2) input)
         )))


(check-equal? (p-dmux4way2 1 '(0 0)) (list 1 0 0 0))
(check-equal? (p-dmux4way2 1 '(0 1)) (list 0 1 0 0))
(check-equal? (p-dmux4way2 1 '(1 0)) (list 0 0 1 0))
(check-equal? (p-dmux4way2 1 '(1 1)) (list 0 0 0 1))
(check-equal? (p-dmux4way2 0 '(0 0)) (list 0 0 0 0))
(check-equal? (p-dmux4way2 0 '(0 1)) (list 0 0 0 0))
(check-equal? (p-dmux4way2 0 '(1 0)) (list 0 0 0 0))
(check-equal? (p-dmux4way2 0 '(1 1)) (list 0 0 0 0))


;pdmux8way
(define (p-dmux8way input sel0 sel1 sel2)
  (let* ([aux (p-dmux input sel2)]
         [aux1 (p-dmux (first aux) sel1)]
         [aux2 (p-dmux (second aux) sel1)]
         [aux3 (p-dmux (first aux1) sel0)]
         [aux4 (p-dmux (second aux1) sel0)]
         [aux5 (p-dmux (first aux2) sel0)]
         [aux6 (p-dmux (second aux2) sel0)])
    (list (first aux3) (first aux5) (first aux4) (first aux6)
          (second aux3) (second aux5)
          (second aux4) (second aux6))))

       
           
(check-equal? (p-dmux8way 1 0 0 0) (list 1 0 0 0 0 0 0 0))
(check-equal? (p-dmux8way 1 0 0 1) (list 0 1 0 0 0 0 0 0))
(check-equal? (p-dmux8way 1 0 1 0) (list 0 0 1 0 0 0 0 0))
(check-equal? (p-dmux8way 1 0 1 1) (list 0 0 0 1 0 0 0 0))
(check-equal? (p-dmux8way 1 1 0 0) (list 0 0 0 0 1 0 0 0))
(check-equal? (p-dmux8way 1 1 0 1) (list 0 0 0 0 0 1 0 0))
(check-equal? (p-dmux8way 1 1 1 0) (list 0 0 0 0 0 0 1 0))
(check-equal? (p-dmux8way 1 1 1 1) (list 0 0 0 0 0 0 0 1))


;p-or-n-way n entradas em uma porta or
(define (p-or-n-way list-n-bits)
  (foldr p-or 0 list-n-bits))

(check-equal? (p-or-n-way '(0 0 1 0 1)) 1)
(check-equal? (p-or-n-way '(0 0 0 0 0)) 0)

;p-or8way 
(define (p-or8way b1 b2 b3 b4 b5 b6 b7 b8)
  (p-or (p-or (p-or b1 b2) (p-or b3 b4))
       (p-or (p-or b5 b6) (p-or b7 b8))))

;p-or16way
(define (p-or16way b16)
  (p-or-n-way b16))

(define (p-or16way2 b16)
  (p-or (p-or8way (take b16 8)) (p-or8way (drop b16 8))))

(check-equal? (p-or-n-way '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)) 0)
(check-equal? (p-or-n-way '(0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0)) 1)

;p-or16 or de 2 bytes 2 a 2
(define (p-or16 a1 a2 a3 a4 a5 a6 a7 a8
                b1 b2 b3 b4 b5 b6 b7 b8)
  (list (p-or a1 b1)
        (p-or a2 b2)
        (p-or a3 b3)
        (p-or a4 b4)
        (p-or a5 b5)
        (p-or a6 b6)
        (p-or a7 b7)
        (p-or a8 b8)))

(check-equal? (p-or16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0) '(0 0 0 0 0 0 0 0))
(check-equal? (p-or16 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0) '(0 0 0 0 0 1 0 0))

;p-or-n generalizacao do p-or  
(define (p-or-n list1 list2)
  (map p-or list1 list2))

(check-equal? (p-or-n '(0 0 0 0 0 1 0 0) '(0 0 0 0 0 0 0 0)) '(0 0 0 0 0 1 0 0))

;p-and8
(define (p-and8 a1 a2 a3 a4 a5 a6 a7 a8
                 b1 b2 b3 b4 b5 b6 b7 b8)
  (list (p-and a1 b1)
        (p-and a2 b2)
        (p-and a3 b3)
        (p-and a4 b4)
        (p-and a5 b5)
        (p-and a6 b6)
        (p-and a7 b7)
        (p-and a8 b8)))
(check-equal? (p-and8 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0) '(0 0 0 0 0 0 0 0))
(check-equal? (p-and8 1 0 0 0 0 1 0 0 1 0 0 0 0 0 0 0) '(1 0 0 0 0 0 0 0))



;p-and-n 
(define (p-and-n list1 list2)
  (map p-and list1 list2))

(check-equal? (p-and-n '(1 0 0 0 0 1 0 0) '(1 0 0 0 0 0 0 0)) '(1 0 0 0 0 0 0 0))


;p-and16
(define (p-and16 a b)
  (p-and-n a b))

;p-not16
(define (p-not16 a16)
  (map p-not a16))

(check-equal? (p-not16 '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)) '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1))
(check-equal? (p-not16 '(1 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0)) '(0 1 1 1 1 0 1 1 1 1 1 1 1 1 1 1))

;p-not-n 
(define (p-not-n list1)
 (map p-not list1))

(check-equal? (p-not-n '(1 0 0 0 0 1 0 0)) '(0 1 1 1 1 0 1 1))

;p-mux16
(define (p-mux16 a16 b16 sel)
  (map p-mux a16 b16 (make-list 16 sel)))

(check-equal? (p-mux16 '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
                       '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
                       0)
              '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
(check-equal? (p-mux16 '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
                       '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
                       1)
              '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1))

;p-mux4way16
(define (p-mux4way16 a16 b16 c16 d16 sel1 sel2)
  (p-mux16 (p-mux16 a16 b16 sel2)
           (p-mux16 c16 d16 sel2)
           sel1))

(check-equal? (p-mux4way16
               '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
               '(0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1)
               '(1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0)
               '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
                 0 0)
               '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
(check-equal? (p-mux4way16
               '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
               '(0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1)
               '(1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0)
               '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
                 0 1)
               '(0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1))
(check-equal? (p-mux4way16
               '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
               '(0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1)
               '(1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0)
               '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
                 1 0)
               '(1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0))
(check-equal? (p-mux4way16
               '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
               '(0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1)
               '(1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0)
               '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
                 1 1)
               '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1))

;p-mux8way16
(define (p-mux8way16 a16 b16 c16 d16
                     e16 f16 g16 h16
                     sel1 sel2 sel3)
  (p-mux16 (p-mux4way16 a16 b16 c16 d16 sel2 sel3)
           (p-mux4way16 e16 f16 g16 h16 sel2 sel3)
           sel1))

(check-equal? (p-mux8way16
               '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
               '(0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1)
               '(1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0)
               '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
               '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
               '(0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 0)
               '(1 1 1 1 1 1 1 1 0 0 0 0 0 0 1 1)
               '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0)
                 0 0 0)
               '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
(check-equal? (p-mux8way16
               '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
               '(0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1)
               '(1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0)
               '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
               '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
               '(0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 0)
               '(1 1 1 1 1 1 1 1 0 0 0 0 0 0 1 1)
               '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0)
                 0 0 1)
               '(0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1))
(check-equal? (p-mux8way16
               '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
               '(0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1)
               '(1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0)
               '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
               '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
               '(0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 0)
               '(1 1 1 1 1 1 1 1 0 0 0 0 0 0 1 1)
               '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0)
                 0 1 0)
               '(1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0))
(check-equal? (p-mux8way16
               '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
               '(0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1)
               '(1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0)
               '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
               '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
               '(0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 0)
               '(1 1 1 1 1 1 1 1 0 0 0 0 0 0 1 1)
               '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0)
                 0 1 1)
               '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1))
(check-equal? (p-mux8way16
               '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
               '(0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1)
               '(1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0)
               '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
               '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
               '(0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 0)
               '(1 1 1 1 1 1 1 1 0 0 0 0 0 0 1 1)
               '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0)
                 1 0 0)
               '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))
(check-equal? (p-mux8way16
               '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
               '(0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1)
               '(1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0)
               '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
               '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
               '(0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 0)
               '(1 1 1 1 1 1 1 1 0 0 0 0 0 0 1 1)
               '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0)
                 1 0 1)
               '(0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 0))
(check-equal? (p-mux8way16
               '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
               '(0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1)
               '(1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0)
               '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
               '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
               '(0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 0)
               '(1 1 1 1 1 1 1 1 0 0 0 0 0 0 1 1)
               '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0)
                 1 1 0)
               '(1 1 1 1 1 1 1 1 0 0 0 0 0 0 1 1))
(check-equal? (p-mux8way16
               '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
               '(0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1)
               '(1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0)
               '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
               '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
               '(0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 0)
               '(1 1 1 1 1 1 1 1 0 0 0 0 0 0 1 1)
               '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0)
                 1 1 1)
               '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0))

;;; capítulo 2

;p-halfadder
(define (p-halfadder a b)
  (list (p-xor a b) (p-and a b)))

(check-equal? (p-halfadder 0 0) (list 0 0))
(check-equal? (p-halfadder 0 1) (list 1 0))
(check-equal? (p-halfadder 1 0) (list 1 0))
(check-equal? (p-halfadder 1 1) (list 0 1))

;p-fulladder 2 bits para serem somados (a b) com um 1 bit carry (c)
(define (p-fulladder a b c)
  (let* ([p1 (p-halfadder b c)]
         [p2 (p-halfadder a (first p1))])
    (list (first p2) (p-or (second p2) (second p1)))))

(check-equal? (p-fulladder 0 0 0) (list 0 0))
(check-equal? (p-fulladder 0 0 1) (list 1 0))
(check-equal? (p-fulladder 0 1 0) (list 1 0))
(check-equal? (p-fulladder 0 1 1) (list 0 1))
(check-equal? (p-fulladder 1 0 0) (list 1 0))
(check-equal? (p-fulladder 1 0 1) (list 0 1))
(check-equal? (p-fulladder 1 1 0) (list 0 1))
(check-equal? (p-fulladder 1 1 1) (list 1 1))

;p-add16
(define (p-add16 a16 b16)
  (reverse (add16aux (reverse a16) (reverse b16) 0)))
(define (add16aux a b c)
  (if (empty? a)
      empty
      (let ([aux (p-fulladder (car a) (car b) c)])
        (cons (car aux) (add16aux (cdr a) (cdr b) (second aux))))))    

(check-equal? (p-add16 (make-list 16 0) (make-list 16 0)) (make-list 16 0) )
(check-equal? (p-add16 (make-list 16 0) (make-list 16 1)) (make-list 16 1) )
(check-equal? (p-add16 (make-list 16 1) (make-list 16 1)) '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0) )
(check-equal? (p-add16
                  '(1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0)
                  '(0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1))
                  '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1))
(check-equal? (p-add16
                  '(0 0 1 1 1 1 0 0 1 1 0 0 0 0 1 1)
                  '(0 0 0 0 1 1 1 1 1 1 1 1 0 0 0 0))
              '(0 1 0 0 1 1 0 0 1 0 1 1 0 0 1 1))
(check-equal? (p-add16
                  '(0 0 0 1 0 0 1 0 0 0 1 1 0 1 0 0)
                  '(1 0 0 1 1 0 0 0 0 1 1 1 0 1 1 0))
              '(1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0))

;p-inc16
(define (p-inc16 a16)
  (p-add16 a16 '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1)))

(check-equal? (p-inc16 '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
              '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))
(check-equal? (p-inc16 '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1))
              '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
(check-equal? (p-inc16 '(0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 1))
              '(0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0))
(check-equal? (p-inc16 '(1 1 1 1 1 1 1 1 1 1 1 1 1 0 1 1))
              '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0))



;p-alu
(define (alu x16 y16 zx nx zy ny f no)
  (let* ([xa16  (p-mux16 x16 (make-list 16 0) zx)]
         [xb16  (p-not16 xa16)]
         [xc16  (p-mux16 xa16 xb16 nx)]
         [ya16  (p-mux16 y16 (make-list 16 0) zy)]
         [yb16  (p-not16 ya16)]
         [yc16  (p-mux16 ya16 yb16 ny)]
         [sxy16 (p-add16 xc16 yc16)]
         [axy16 (p-and16 xc16 yc16)]
         [fo16  (p-mux16 axy16 sxy16 f)]
         [nfo16 (p-not16 fo16)]
         [out16 (p-mux16 fo16 nfo16 no)]
         [zr    (p-not (p-or16way out16))]
         [ng    (car out16)]
         )
    (append out16 (list zr ng))))


(check-equal? (alu (make-list 16 0)
                   (make-list 16 1)
                   1 0 1 0 1 0)
              (append (make-list 16 0) '(1 0)))
(check-equal? (alu (make-list 16 0)
                   (make-list 16 1)
                   1 1 1 0 1 0)
              (append (make-list 16 1) '(0 1)))
(check-equal? (alu (make-list 16 0)
                   (make-list 16 1)
                   0 0 1 1 0 0)
              (append (make-list 16 0) '(1 0)))
(check-equal? (alu (make-list 16 0)
                   (make-list 16 1)
                   1 1 0 0 0 0)
              (append (make-list 16 1) '(0 1)))
(check-equal? (alu (make-list 16 0)
                   (make-list 16 1)
                   0 0 1 1 0 1)
              (append (make-list 16 1) '(0 1)))
(check-equal? (alu (make-list 16 0)
                   (make-list 16 1)
                   1 1 0 0 0 1)
              (append (make-list 16 0) '(1 0)))
(check-equal? (alu (make-list 16 0)
                   (make-list 16 1)
                   0 0 1 1 1 1)
              (append (make-list 16 0) '(1 0)))
(check-equal? (alu (make-list 16 0)
                   (make-list 16 1)
                   1 1 0 0 1 1)
              (append (make-list 15 0) '(1 0 0)))
(check-equal? (alu (make-list 16 0)
                   (make-list 16 1)
                   0 1 1 1 1 1)
              (append (make-list 15 0) '(1 0 0)))
(check-equal? (alu (make-list 16 0)
                   (make-list 16 1)
                   1 1 0 1 1 1)
              (append (make-list 16 0) '(1 0)))
(check-equal? (alu (make-list 16 0)
                   (make-list 16 1)
                   0 0 1 1 1 0)
              (append (make-list 16 1) '(0 1)))
(check-equal? (alu (make-list 16 0)
                   (make-list 16 1)
                   1 1 0 0 1 0)
              (append (make-list 15 1) '(0 0 1)))
(check-equal? (alu (make-list 16 0)
                   (make-list 16 1)
                   0 0 0 0 1 0)
              (append (make-list 16 1) '(0 1)))
(check-equal? (alu (make-list 16 0)
                   (make-list 16 1)
                   0 1 0 0 1 1)
              (append (make-list 15 0) '(1 0 0)))
(check-equal? (alu (make-list 16 0)
                   (make-list 16 1)
                   0 1 0 0 1 1)
              (append (make-list 15 0) '(1 0 0)))
(check-equal? (alu (make-list 16 0)
                   (make-list 16 1)
                   0 0 0 1 1 1)
              (append (make-list 16 1) '(0 1)))
(check-equal? (alu (make-list 16 0)
                   (make-list 16 1)
                   0 0 0 0 0 0)
              (append (make-list 16 0) '(1 0)))
(check-equal? (alu (make-list 16 0)
                   (make-list 16 1)
                   0 1 0 1 0 1)
              (append (make-list 16 1) '(0 1)))
(check-equal? (alu '(0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1)
                   '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1)
                   1 0 1 0 1 0)
              (append (make-list 16 0) '(1 0)))
(check-equal? (alu '(0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1)
                   '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1)
                   1 1 1 1 1 1)
              (append (make-list 15 0) '(1 0 0)))
(check-equal? (alu '(0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1)
                   '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1)
                   1 1 1 0 1 0)
              (append (make-list 16 1) '(0 1)))
(check-equal? (alu '(0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1)
                   '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1)
                   0 0 1 1 0 0)
              (append '(0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1) '(0 0)))
(check-equal? (alu '(0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1)
                   '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1)
                   1 1 0 0 0 0)
              (append '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1) '(0 0)))
(check-equal? (alu '(0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1)
                   '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1)
                   0 0 1 1 0 1)
              (append '(1 1 1 1 1 1 1 1 1 1 1 0 1 1 1 0) '(0 1)))
(check-equal? (alu '(0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1)
                   '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1)
                   1 1 0 0 0 1)
              (append '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0) '(0 1)))
(check-equal? (alu '(0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1)
                   '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1)
                   0 0 1 1 1 1)
              (append '(1 1 1 1 1 1 1 1 1 1 1 0 1 1 1 1) '(0 1)))
(check-equal? (alu '(0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1)
                   '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1)
                   1 1 0 0 1 1)
              (append '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 1) '(0 1)))
(check-equal? (alu '(0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1)
                   '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1)
                   0 1 1 1 1 1)
              (append '(0 0 0 0 0 0 0 0 0 0 0 1 0 0 1 0) '(0 0)))
(check-equal? (alu '(0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1)
                   '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1)
                   1 1 0 1 1 1)
              (append '(0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0) '(0 0)))
(check-equal? (alu '(0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1)
                   '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1)
                   0 0 1 1 1 0)
              (append '(0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0) '(0 0)))
(check-equal? (alu '(0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1)
                   '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1)
                   1 1 0 0 1 0)
              (append '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0) '(0 0)))
(check-equal? (alu '(0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1)
                   '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1)
                   0 0 0 0 1 0)
              (append '(0 0 0 0 0 0 0 0 0 0 0 1 0 1 0 0) '(0 0)))
(check-equal? (alu '(0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1)
                   '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1)
                   0 1 0 0 1 1)
              (append '(0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 0) '(0 0)))
(check-equal? (alu '(0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1)
                   '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1)
                   0 0 0 1 1 1)
              (append '(1 1 1 1 1 1 1 1 1 1 1 1 0 0 1 0) '(0 1)))
(check-equal? (alu '(0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1)
                   '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1)
                   0 0 0 0 0 0)
              (append '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1) '(0 0)))
(check-equal? (alu '(0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1)
                   '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1)
                   0 1 0 1 0 1)
              (append '(0 0 0 0 0 0 0 0 0 0 0 1 0 0 1 1) '(0 0)))


#|
The construction of the multi-bit adder presented in this chapter was standard,
although no attention was paid to efficiency. In fact, our suggested adder implementation
is rather inefficient, due to the long delays incurred while the carry bit propagates
from the least significant bit pair to the most significant bit pair. This problem
can be alleviated using logic circuits that effect so-called carry look-ahead techniques.
Since addition is one of the most prevalent operations in any given hardware platform,
any such low-level improvement can result in dramatic and global performance
gains throughout the computer.
In any given computer, the overall functionality of the hardware/software platform
is delivered jointly by the ALU and the operating system that runs on top of it.
Thus, when designing a new computer system, the question of how much functionality
the ALU should deliver is essentially a cost/performance issue. The general rule
is that hardware implementations of arithmetic and logical operations are usually
more costly, but achieve better performance. The design trade-off that we have
chosen in this book is to specify an ALU hardware with a limited functionality and
then implement as many operations as possible in software. For example, our ALU
features neither multiplication nor division nor floating point arithmetic. We will
implement some of these operations (as well as more mathematical functions) at the
operating system level, described in chapter 12.
|#
