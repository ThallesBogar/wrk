#lang racket

(require rackunit)
(require math/array)
(require racket/class)

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

(define (p-mux in1 in2 sel)
  (p-or (p-and (p-not sel) in1) (p-and sel in2)))

(define (p-demux in sel)
  (list (p-and (p-not sel) in) (p-and sel in)))

(define (p-or8way a b c d e f g h)
  (p-or (p-or (p-or a b) (p-or c d)) (p-or (p-or e f) (p-or g h))))

(define (p-mux4way in1 in2 in3 in4 sel1 sel2)
  (p-or (p-or (p-and (p-and (p-not sel1) (p-not sel2)) in1) (p-and (p-and (p-not sel1) sel2) in2))
	(p-or (p-and (p-and sel1 (p-not sel2)) in3) (p-and (p-and sel1 sel2) in4))))

(define (p-demux4way in sel1 sel2)
  (list (p-and (p-and (p-not sel1) (p-not sel2)) in)
	(p-and (p-and (p-not sel1) sel2) in)
	(p-and (p-and sel1 (p-not sel2)) in)
	(p-and (p-and sel1 sel2) in)))

(define (p-demux8way in sel1 sel2 sel3)
  (list (p-and (p-and (p-and (p-not sel1) (p-not sel2)) (p-not sel3)) in)
	(p-and (p-and (p-and (p-not sel1) (p-not sel2)) sel3) in)
	(p-and (p-and (p-and (p-not sel1) sel2) (p-not sel3)) in)
	(p-and (p-and (p-and (p-not sel1) sel2) sel3) in)
	(p-and (p-and (p-and sel1 (p-not sel2)) (p-not sel3)) in)
	(p-and (p-and (p-and sel1 (p-not sel2)) sel3) in)
	(p-and (p-and (p-and sel1 sel2) (p-not sel3)) in)
	(p-and (p-and (p-and sel1 sel2) sel3) in)))

(define (p-not16 a)
  (for/list ( (i '(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)))
    (p-not (list-ref a i))))

(define (p-and16 a b)
  (for/list ( (i '(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)))
    (p-and (list-ref a i) (list-ref b i))))

(define (p-or16 a b)
  (for/list ( (i '(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)))
    (p-or (list-ref a i) (list-ref b i))))

(define (p-mux16 in1 in2 sel)
  (for/list ( (i '(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)))
    (p-mux (list-ref in1 i) (list-ref in2 i) sel)))
  
(define (p-mux4way16 in1 in2 in3 in4 sel1 sel2)
  (for/list ( (i '(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)))
    (p-mux4way (list-ref in1 i) (list-ref in2 i) (list-ref in3 i) (list-ref in4 i) sel1 sel2)))

(define (p-mux8way16 in1 in2 in3 in4 in5 in6 in7 in8 sel3 sel2 sel1)
  (p-mux16 (p-mux4way16 in1 in2 in3 in4 sel2 sel1) (p-mux4way16 in5 in6 in7 in8 sel2 sel1) sel3))

(define dff-class%
  (class object%
    (field (state 0))
    (define/public (out)
      state)
    (define/public (reset)
     (set! state 0)
      #t)
    (define/public (in value)
      (let ([out state])
          (set! state value)
          out))
    (super-new)))

(define bit-class%
  (class object%
    (super-new)
    (define dff (new dff-class%))
    (define/public (in input load)
        (if (= load 1)
            (send dff in input)
            (send dff out)))
    (define/public (out)
         (send dff out))))

(define register-class%
  (class object%
    (super-new)
    (define b0  (new bit-class%))
    (define b1  (new bit-class%))
    (define b2  (new bit-class%))
    (define b3  (new bit-class%))
    (define b4  (new bit-class%))
    (define b5  (new bit-class%))
    (define b6  (new bit-class%))
    (define b7  (new bit-class%))
    (define b8  (new bit-class%))
    (define b9  (new bit-class%))
    (define b10 (new bit-class%))
    (define b11 (new bit-class%))
    (define b12 (new bit-class%))
    (define b13 (new bit-class%))
    (define b14 (new bit-class%))
    (define b15 (new bit-class%))
    (define/public (out)
      (list
         (send b0 out) (send b1 out) (send b2 out)
         (send b3 out) (send b4 out) (send b5 out)
         (send b6 out) (send b7 out) (send b8 out)
         (send b9 out) (send b10 out) (send b11 out)
         (send b12 out) (send b13 out) (send b14 out)
         (send b15 out)))
    (define/public (in b load)
      (list
       (send b0 in (list-ref b 0) load) (send b1 in (list-ref b 1) load) (send b2 in (list-ref b 2) load)
       (send b3 in (list-ref b 3) load) (send b4 in (list-ref b 4) load) (send b5 in (list-ref b 5) load)
       (send b6 in (list-ref b 6) load) (send b7 in (list-ref b 7) load) (send b8 in (list-ref b 8) load)
       (send b9 in (list-ref b 9) load) (send b10 in (list-ref b 10) load) (send b11 in (list-ref b 11) load)
       (send b12 in (list-ref b 12) load) (send b13 in (list-ref b 13) load) (send b14 in (list-ref b 14) load)
       (send b15 in (list-ref b 15) load)))))

(define ram8-class%
  (class object%
    (super-new)
    (define r0  (new register-class%))
    (define r1  (new register-class%))
    (define r2  (new register-class%))
    (define r3  (new register-class%))
    (define r4  (new register-class%))
    (define r5  (new register-class%))
    (define r6  (new register-class%))
    (define r7  (new register-class%))
    (define/public (in bits load sel0 sel1 sel2)
      (let ([aux (p-demux8way load sel0 sel1 sel2)])
        (p-mux8way16 
           (send r0 in bits (list-ref aux 0))
           (send r1 in bits (list-ref aux 1))
           (send r2 in bits (list-ref aux 2))
           (send r3 in bits (list-ref aux 3))
           (send r4 in bits (list-ref aux 4))
           (send r5 in bits (list-ref aux 5))
           (send r6 in bits (list-ref aux 6))
           (send r7 in bits (list-ref aux 7))
           sel0 sel1 sel2)))
    (define/public (contents)
      (list (send r0 out) (send r1 out)
            (send r2 out) (send r3 out)
            (send r4 out) (send r5 out)
            (send r6 out) (send r7 out)))))

(define ram64-class%
  (class object%
    (super-new)
    (define ram0 (new ram8-class%))
    (define ram1 (new ram8-class%))
    (define ram2 (new ram8-class%))
    (define ram3 (new ram8-class%))
    (define ram4 (new ram8-class%))
    (define ram5 (new ram8-class%))
    (define ram6 (new ram8-class%))
    (define ram7 (new ram8-class%))
    (define/public (in bits load sel5 sel4 sel3 sel2 sel1 sel0)
      (let ( (aux (p-demux8way load sel5 sel4 sel3)))
	(p-mux8way16
	 (send ram0 in bits (list-ref aux 0) sel2 sel1 sel0)
	 (send ram1 in bits (list-ref aux 1) sel2 sel1 sel0)
	 (send ram2 in bits (list-ref aux 2) sel2 sel1 sel0)
	 (send ram3 in bits (list-ref aux 3) sel2 sel1 sel0)
	 (send ram4 in bits (list-ref aux 4) sel2 sel1 sel0)
	 (send ram5 in bits (list-ref aux 5) sel2 sel1 sel0)
	 (send ram6 in bits (list-ref aux 6) sel2 sel1 sel0)
	 (send ram7 in bits (list-ref aux 7) sel2 sel1 sel0)
	 sel5 sel4 sel3)))
    (define/public (contents)
      (list
       (send ram0 contents)
       (send ram1 contents)
       (send ram2 contents)
       (send ram3 contents)
       (send ram4 contents)
       (send ram5 contents)
       (send ram6 contents)
       (send ram7 contents)))))

(define ram512-class%
  (class object%
    (super-new)
    (define ram0 (new ram64-class%))
    (define ram1 (new ram64-class%))
    (define ram2 (new ram64-class%))
    (define ram3 (new ram64-class%))
    (define ram4 (new ram64-class%))
    (define ram5 (new ram64-class%))
    (define ram6 (new ram64-class%))
    (define ram7 (new ram64-class%))
    (define/public (in bits load sel8 sel7 sel6 sel5 sel4 sel3 sel2 sel1 sel0)
      (let ( (aux (p-demux8way load sel8 sel7 sel6)))
	(p-mux8way16
	 (send ram0 in bits (list-ref aux 0) sel5 sel4 sel3 sel2 sel1 sel0)
	 (send ram1 in bits (list-ref aux 1) sel5 sel4 sel3 sel2 sel1 sel0)
	 (send ram2 in bits (list-ref aux 2) sel5 sel4 sel3 sel2 sel1 sel0)
	 (send ram3 in bits (list-ref aux 3) sel5 sel4 sel3 sel2 sel1 sel0)
	 (send ram4 in bits (list-ref aux 4) sel5 sel4 sel3 sel2 sel1 sel0)
	 (send ram5 in bits (list-ref aux 5) sel5 sel4 sel3 sel2 sel1 sel0)
	 (send ram6 in bits (list-ref aux 6) sel5 sel4 sel3 sel2 sel1 sel0)
	 (send ram7 in bits (list-ref aux 7) sel5 sel4 sel3 sel2 sel1 sel0)
	 sel8 sel7 sel6)))
    (define/public (contents)
      (list
       (send ram0 contents)
       (send ram1 contents)
       (send ram2 contents)
       (send ram3 contents)
       (send ram4 contents)
       (send ram5 contents)
       (send ram6 contents)
       (send ram7 contents)))))

(define ram4K-class%
  (class object%
   (super-new)
   (define ram0 (new ram512-class%))
   (define ram1 (new ram512-class%))
   (define ram2 (new ram512-class%))
   (define ram3 (new ram512-class%))
   (define ram4 (new ram512-class%))
   (define ram5 (new ram512-class%))
   (define ram6 (new ram512-class%))
   (define ram7 (new ram512-class%))
   (define/public (in bits load sel11 sel10 sel9 sel8 sel7 sel6 sel5 sel4 sel3 sel2 sel1 sel0)
     (let ( (aux (p-demux8way load sel11 sel10 sel9)))
       (p-mux8way16
	(send ram0 in bits (list-ref aux 0) sel8 sel7 sel6 sel5 sel4 sel3 sel2 sel1 sel0)
	(send ram1 in bits (list-ref aux 1) sel8 sel7 sel6 sel5 sel4 sel3 sel2 sel1 sel0)
	(send ram2 in bits (list-ref aux 2) sel8 sel7 sel6 sel5 sel4 sel3 sel2 sel1 sel0)
	(send ram3 in bits (list-ref aux 3) sel8 sel7 sel6 sel5 sel4 sel3 sel2 sel1 sel0)
	(send ram4 in bits (list-ref aux 4) sel8 sel7 sel6 sel5 sel4 sel3 sel2 sel1 sel0)
	(send ram5 in bits (list-ref aux 5) sel8 sel7 sel6 sel5 sel4 sel3 sel2 sel1 sel0)
	(send ram6 in bits (list-ref aux 6) sel8 sel7 sel6 sel5 sel4 sel3 sel2 sel1 sel0)
	(send ram7 in bits (list-ref aux 7) sel8 sel7 sel6 sel5 sel4 sel3 sel2 sel1 sel0)
        sel11 sel10 sel9)))
   (define/public (contents)
     (list
      (send ram0 contents)
      (send ram1 contents)
      (send ram2 contents)
      (send ram3 contents)
      (send ram4 contents)
      (send ram5 contents)
      (send ram6 contents)
      (send ram7 contents)))))

(define ram8K-class%
  (class object%
    (super-new)
    (define ram0 (new ram4K-class%))
    (define ram1 (new ram4K-class%))
    (define/public (in bits load sel12 sel11 sel10 sel9 sel8 sel7 sel6 sel5 sel4 sel3 sel2 sel1 sel0)
      (let ( (aux (p-demux load sel12)))
	(p-mux16
	 (send ram0 in bits (list-ref aux 0) sel11 sel10 sel9 sel8 sel7 sel6 sel5 sel4 sel3 sel2 sel1 sel0)
	 (send ram1 in bits (list-ref aux 1) sel11 sel10 sel9 sel8 sel7 sel6 sel5 sel4 sel3 sel2 sel1 sel0)
	 sel12)))
    (define/public (contents)
      (list
       (send ram0 contents)
       (send ram1 contents)))))

(define ram16K-class%
  (class object%
    (super-new)
    (define ram0 (new ram8K-class%))
    (define ram1 (new ram8K-class%))
    (define/public (in bits load sel sel13 sel12 sel11 sel10 sel9 sel8 sel7 sel6 sel5 sel4 sel3 sel2 sel1 sel0)
      (let ( (aux (p-demux load sel13)))
	(p-mux16
	 (send ram0 in bits (list-ref aux 0) sel12 sel11 sel10 sel9 sel8 sel7 sel6 sel5 sel4 sel3 sel2 sel1 sel0)
	 (send ram1 in bits (list-ref aux 1) sel12 sel11 sel10 sel9 sel8 sel7 sel6 sel5 sel4 sel3 sel2 sel1 sel0)
	 sel13)))
    (define/public (contents)
      (list
       (send ram0 contents)
       (send ram1 contents)))))

(define ram32K-class%
  (class object%
    (super-new)
    (define ram0 (new ram16K-class%))
    (define ram1 (new ram16K-class%))
    (define/public (in bits load sel)
      (let ( (aux (p-demux load sel14 sel13 sel12 sel11 sel10 sel9 sel8 sel7 sel6 sel5 sel4 sel3 sel2 sel1 sel0)))
	(p-mux16
	 (send ram0 in bits (list-ref aux 0) sel13 sel12 sel11 sel10 sel9 sel8 sel7 sel6 sel5 sel4 sel3 sel2 sel1 sel0)
	 (send ram1 in bits (list-ref aux 1) sel13 sel12 sel11 sel10 sel9 sel8 sel7 sel6 sel5 sel4 sel3 sel2 sel1 sel0)
	 sel14)))
    (define/public (contents)
      (list
       (send ram0 contents)
       (send ram1 contents)))))	              
