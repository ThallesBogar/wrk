#lang racket

(require rackunit)
(require racket/class)


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

;Capítulo 03
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
  
;; 
(define dff1 (new dff-class%))
;; Use `send' to call an object's methods
(check-equal? (send dff1 out) 0)
(check-equal? (send dff1 in 1) 0)
(check-equal? (send dff1 out) 1)
(check-equal? (send dff1 reset) #t)
(check-equal? (send dff1 out) 0)



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

#|
> (define b (new bit-class%))
> (send b out)
0
> (send b in 1 0)
0
> (send b out)
0
> (send b in 0 0)
0
> (send b out)
0
> (send b in 1 1)
0
> (send b out)
1
> (send b in 0 1)
1
> (send b out)
0
|#

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
    
#|
> (define r (new register-class%))
> (send r out)
'(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
> (send r in '(1 0 1 0 1 0 1 0
               1 0 1 0 1 0 1 0)
              1)
'(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
> (send r out)
'(1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0)
> (send r in '(1 1 1 1 1 1 1 1
               1 1 1 1 1 1 1 1)
              0)
'(1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0)
> (send r out)
'(1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0)
|#

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

        
#|
> (define ram (new ram8-class%))
> (send ram contents)
'((0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
  (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
  (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
  (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
  (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
  (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
  (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
  (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
> (send ram in (make-list 16 1) 1 1 1 1)
'(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
> (send ram contents)
'((0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
  (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
  (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
  (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
  (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
  (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
  (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
  (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1))
> (send ram in (make-list 16 1) 1 1 0 1)
'(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
> (send ram contents)
'((0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
  (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
  (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
  (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
  (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
  (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
  (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
  (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1))
|#
    
;Exercício 01 criar uma ram de 64 x 16 bits
; com os métodos contrutor, contents e in
; como nos exemplos acima
(define ram64-class% ...)


#| façam os testes:
> (define r64 (new ram64-class%))
> (send r64 contents)
'(((0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
  ((0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
  ((0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
  ((0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
  ((0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
  ((0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
  ((0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
  ((0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)))
> (send r64 in (make-list 16 1) 1 0 0 0 0 0 0)
'(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
> (send r64 contents)
'(((1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
  ((0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
  ((0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
  ((0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
  ((0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
  ((0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
  ((0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
  ((0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
   (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)))
|#

;Exercício 02 criar uma ram de 512 x 16 bits
; com os métodos contrutor, contents e in
; como nos exemplos acima
(define ram512-class% ...)

;Exercício 03 - criar uma ram de 4K x 16 bits
; com os métodos contrutor, contents e in
; como nos exemplos acima
(define ram4k-class% ...)

;Exercício 04 - criar uma ram de 8K x 16 bits
; com os métodos contrutor, contents e in
; como nos exemplos acima
(define ram8k-class% ...)

;Exercício 05 - criar uma ram de 16K x 16 bits
; com os métodos contrutor, contents e in
; como nos exemplos acima
(define ram16k-class% ...)

;Exercício 05 - criar uma ram de 32K x 16 bits
; com os métodos contrutor, contents e in
; como nos exemplos acima
(define ram32k-class% ...)














                   
