#lang racket

;; This is a comment line

#|This is a
comment line
block!!|#

;;Declarando variavel global com define:
(define *foo* 5)

;;Criando uma struct
(struct person (name age gender))

;;Criando uma hash table:
(define m (hash 'a 1 'b 2 'c 3))

;;Variavel criada a partir de uma struct:
(define me (person "Thalles" "22" "male"))

(define hello-world (lambda () "Hello, World"))
;;Funcao para concatenar 2 strings:
(define (add-strings str1 str2)
  (string-append str1 str2))

;;Funcao para formatar uma string:
(define (format-strings str1 str2)
  (format "~a o ~a" str1 str2))

;;Funcao para imprimir:
(define (hello)
  (printf "Hello!!"))

;;Funcao para somar 5 a partir de uma variavel global:
(define (somar5-global x)
  (+ x *foo*))

;;Funcao para somar 5 a partir de uma variavel local:
(define (somar5-local x)
  (let ( (y 5))
    (+ x y)))

;;Funcao para fazer algumas manipulacoes basicas com listas:
(define (lists x)
  (list
   (map add1 x)
   (filter even? x)
   (count even? x)
   (take x 2)
   (drop x 2)))

;;Funcao para concatenar vetores:
(define (add-vectors v1 v2)
  (vector-append v1 v2))

;;Funcao para acessar um valor na hash table:
(define (access-hash)
  (hash-ref m 'a))

;;Funcao para adicionar um valor na hash table (retorna a hash table resultante, nao modifica a hash table atual):
(define (set-hash)
  (hash-set m 'd 4))

;;Funcao para remover um valor na hash table:
(define (remove-hash)
  (hash-remove m 'a))

(define hello2
  (lambda (name)
    (string-append "Hello " name)))

(define (loop i)
  (when (< i 10)
    (printf "i=~a\n" i)
    (loop (add1 i))))
