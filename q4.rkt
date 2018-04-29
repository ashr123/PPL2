#lang racket

; Signature: shift-left(lst)
; Purpose: Evaluates the list that is its' shift-left by one place
; Type: [list -> list]
(define shift-left
  (lambda (lst)
    (cond ((empty? lst) lst)
          (else (append (rest lst) (list (first lst)))))))

; Signature: shift-k-left(lst)
; Purpose: Evaluates the list that is its' shift-left by k places
; Type: [list -> list]
(define shift-k-left
  (lambda (lst k)
    (cond ((zero? k) lst)
          (else (shift-k-left (shift-left lst) (- k 1))))))

; Signature: shift-right(lst)
; Purpose: Evaluates the list that is its' shift-right by one place
; Type: [list -> list]
(define shift-right
  (lambda (lst)
    (cond ((empty? lst) lst)
          (else (append (list (last lst)) (reverse (rest (reverse lst))))))))

; Signature: combine(list1, list2)
; Purpose: Takes two lists and combines them in an alternating manner starting from the 1st list
; Type: [list*list -> list]
(define combine
  (lambda (list1 list2)
    (cond ((empty? list1) list2)
          ((empty? list2) list1)
          (else (append (list (first list1) (first list2)) (combine (rest list1) (rest list2)))))))

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