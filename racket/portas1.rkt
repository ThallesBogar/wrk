#lang racket
(require rackunit)
(require math/array)


(define (p-nand a b)
  (cond
    [(and (= a 1) (= b 1)) 0]
    [else 1]))

(define (p-not a)
  (p-nand a a))

(define (p-and a b)
  (p-not (p-nand a b)))

(define (p-or a b)
  (p-nand (p-not a) (p-not b)))

(define (p-xor a b)
  (let ( (c (p-nand a b)))
    (p-nand (p-nand a c)
            (p-nand c b))))

(define (p-xnor a b)
  (p-not (p-xor a b)))

(define (p-nor a b)
  (p-not (p-or a b)))

(define (mux in1 in2 sel)
  (p-nand (p-nand in1 (p-not sel)) (p-nand in2 sel)))

(define (demux input sel)
  (list (p-and (p-not sel) input) (p-and sel input)))

(define (mux4way in1 in2 in3 in4 sel1 sel2)
  (mux (mux in1 in2 sel1) (mux in3 in4 sel1) sel2))


(check-equal? (p-nand 0 0) 1)
(check-equal? (p-nand 0 1) 1)
(check-equal? (p-nand 1 0) 1)
(check-equal? (p-nand 1 1) 0)

(check-equal? (p-not 0) 1)
(check-equal? (p-not 1) 0)

(check-equal? (p-xor 0 0) 0)
(check-equal? (p-xor 0 1) 1)
(check-equal? (p-xor 1 0) 1)
(check-equal? (p-xor 1 1) 0)

(check-equal? (p-or 0 0) 0)
(check-equal? (p-or 0 1) 1)
(check-equal? (p-or 1 0) 1)
(check-equal? (p-or 1 1) 1)

(check-equal? (mux 0 0 0) 0)
(check-equal? (mux 0 0 1) 0)
(check-equal? (mux 1 0 0) 1)
(check-equal? (mux 1 0 1) 0)
(check-equal? (mux 0 1 0) 0)
(check-equal? (mux 0 1 1) 1)
(check-equal? (mux 1 1 0) 1)
(check-equal? (mux 1 1 1) 1)

(check-equal? (mux4way 0 0 0 0 0 0) 0)
(check-equal? (mux4way 0 0 0 0 0 1) 0)
(check-equal? (mux4way 0 0 0 0 1 0) 0)
(check-equal? (mux4way 0 0 0 0 1 1) 0)
(check-equal? (mux4way 0 0 0 1 0 0) 0)
(check-equal? (mux4way 0 0 0 1 0 1) 0)
(check-equal? (mux4way 0 0 0 1 1 0) 0)
(check-equal? (mux4way 0 0 0 1 1 1) 1)
(check-equal? (mux4way 0 0 1 0 0 0) 0)
(check-equal? (mux4way 0 0 1 0 0 1) 0)
(check-equal? (mux4way 0 0 1 0 1 0) 1)
(check-equal? (mux4way 0 0 1 0 1 1) 0)
(check-equal? (mux4way 0 1 0 0 0 0) 0)
(check-equal? (mux4way 0 1 0 0 0 1) 1)
(check-equal? (mux4way 0 1 0 0 1 0) 0)
(check-equal? (mux4way 0 1 0 0 1 1) 0)
(check-equal? (mux4way 1 0 0 0 0 0) 1)
(check-equal? (mux4way 1 0 0 0 0 1) 0)
(check-equal? (mux4way 1 0 0 0 1 0) 0)
(check-equal? (mux4way 1 0 0 0 1 1) 0)
