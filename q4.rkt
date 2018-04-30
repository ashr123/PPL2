#lang racket
(provide (all-defined-out))

; Signature: shift-left(lst)
; Purpose: Evaluates the list that is its' shift-left by one place
; Type: [list -> list]
(define shift-left
  (lambda (ls)
    (cond ((empty? ls) ls)
          (else (append (rest ls) (list (first ls)))))))

; Signature: shift-k-left(lst)
; Purpose: Evaluates the list that is its' shift-left by k places
; Type: [list -> list]
(define shift-k-left
  (lambda (ls k)
    (cond ((zero? k) ls)
          (else (shift-k-left (shift-left ls) (- k 1))))))

; Signature: shift-right(lst)
; Purpose: Evaluates the list that is its' shift-right by one place
; Type: [list -> list]
(define shift-right
  (lambda (ls)
    (cond ((empty? ls) ls)
          (else (append (list (last ls)) (reverse (rest (reverse ls))))))))

; Signature: combine(list1, list2)
; Purpose: Takes two lists and combines them in an alternating manner starting from the 1st list
; Type: [list*list -> list]
(define combine
  (lambda (ls1 ls2)
    (cond ((empty? ls1) ls2)
          ((empty? ls2) ls1)
          (else (append (list (first ls1) (first ls2)) (combine (rest ls1) (rest ls2)))))))

; Signature: sum-tree(tree)
; Purpose: Receives a tree whose nodes' data values are all numbers 0 and returns the sum of numbers present
;          in all tree nodes
; Type: [list -> list]
(define sum-tree
  (lambda (tree)
    (foldl + 0 (flatten tree))))

; Signature: inverse-tree(tree)
; Purpose: receives a tree whose nodes data values are numbers and booleans and returns the equivalent tree
;          whose nodes satisfy the following:
;              * If the equivalent node of the original tree is a number, then the resulting tree's node is
;                -1 that node value.
;              * If the equivalent node of the original tree is a boolean, then the resulting tree's node is
;                the logical not of that node value.
; Type: [list -> list]
(define inverse-tree
  (lambda (tree)
    (map (lambda (element)
           (cond ((list? element) (inverse-tree element))
                 ((real? element) (- element))
                 (else (not element))))
         tree)))