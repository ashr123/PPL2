#lang racket

(define shift-left
  (lambda (list)
    (cond ((empty? list) list)
          ((equal? (length list) 1) list)
          (else (append (rest list) (cons (first list) '()))))))

(define shift-k-left
  (lambda (list k)
    (cond ((zero? k) list)
          (else (shift-k-left (shift-left list) (- k 1))))))

(define shift-right
  (lambda (list)
    (cond ((empty? list) list)
          ((equal? (length list) 1) list)
          (else (append (cons (last list) '()) (reverse (rest (reverse list))))))))

(define combine
  (lambda (list1 list2)
    (cond ((empty? list1) list2)
          ((empty? list2) list1)
          (else (append (cons (first list1) (cons (first list2) '())) (combine (rest list1) (rest list2)))))))

(define sum-tree
  (lambda (tree)
    (foldl + 0 (flatten tree))))

(define inverse-tree
  (lambda (tree)
    (map (lambda (element)
           (cond ((list? element) (inverse-tree element))
                 ((real? element) (- element))
                 (else (not element))))
         tree)))