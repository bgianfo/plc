#!/usr/bin/env mzscheme

#lang scheme

;; #lang rnrs
;; (import (rnrs))

;;;; Author: Brian Gianforcaro
;;;; PLC Lab #1 - Merge sort in scheme 
;;;; Tested and developed with MzScheme v4.2.1

;;; method: The main interface to the mergesort algorithm
;;; param: f? - Function to use when sorting
;;; param: lst - list to sort via the "p" predicate function.
;;; return: the resulting sorted list.
(define (mergesort f? lst)
  (cond
    ((not (procedure? f?))
      (error "error: 'megesort' requires the first arg to be a procedure."))
    ((not (list? lst))
      (error "error: 'mergesort' requires the second arg to be a list."))
    ((or (null? lst) (null? (cdr lst))) lst)
    (else (merge f?
      (mergesort f? (car (slice! lst))) (mergesort f? (cdr (slice! lst)))))))

;;; method: Merge to lists together with a given predicate function.
;;; param: f? - Function to use when sorting the merge.
;;; param: list-one - First list of the two to merge.
;;; param: list-two - Second list to merge of the two.
;;; return: The product of both lists sorted per the predicate.
(define (merge f? lst-one lst-two)
  (cond
    ((not (procedure? f?))
      (error "error: 'merge' requires first arg to be a procedure"))
    ((not (and (list? lst-one) (list? lst-two)))
      (error "error: 'merge' requires second and third arg's to be list's"))
    ((null? lst-one) lst-two)
    ((null? lst-two) lst-one)
    ((f? (car lst-one) (car lst-two))
      (cons (car lst-one) (merge f? (cdr lst-one) lst-two)))
    (else (cons (car lst-two) (merge f? lst-one (cdr lst-two))))))

;;; method: The main API function to slice a list in to two parts.
;;; param: list - The full list to slice 
;;; return: The input list split to pieces
(define (slice! lst)
  (if (not (list? lst))
    (error "error: 'slice!' requires it's argument to be a list")
  (dice! lst lst '())))

;;; method: Mergesort API function to recursively dice a list.
;;; param: list - The full list for book keeping
;;; param: list-one - The first half of the split into two (for recur)
;;; param: list-two - The second half of the split list (for recur)
;;; return: 
(define (dice! lst lst-one lst-two)
  (cond
    ((not (and (list? lst) (list? lst-one) (list? lst-two)))
      (error "error: 'dice!' requires all arguments to be list's"))
    ((or (null? lst ) (null? (cdr lst)))
      (cons (reverse lst-two) lst-one))
    (else (dice! (cdr lst) (cdr lst-one) (cons (car lst-one) lst-two)))))


;------ All algorithm tests  ------;

;;; All test cases for 'mergesort'
(define test-null '())
(define test-onesie '(9))
(define test-sorted '(1 2 3 4 5 6))
(define test-unsort '(9 2 3 8 7 1))
;;; All test cases for 'merge'
(define test-merge-one (cons (list 2) (list 1)))
(define test-merge-couple (cons (list 1234 3 6) (list 2 39 8 1)))
(define test-merge-null (cons '() (list 2 3 4)))
(define test-merge-null2 (cons (list 2 3 4) '()))
  
;;; Helper function to make defining/calling tests easier and more sane.
(define (merge-test-helper lst)
  (if (not (list? lst))
    (error "error 'merge-test-helper' requires it's argument to be a list")
  (merge <= (car lst) (cdr lst))))

;;; Define all the 'merge' test cases
(define (run-all-tests)
  (cond
    ((not (equal? (merge-test-helper test-merge-one) '(1 2)))
      (error "Test-merge-one failed!"))
    ((not (equal? (merge-test-helper test-merge-couple) '(2 39 8 1 1234 3 6)))
      (error "Test-merge-couple failed!"))
    ((not (equal? (merge-test-helper test-merge-null) '(2 3 4)))
      (error "Test-merge-null failed!"))
    ((not (equal? (merge-test-helper test-merge-null2) '(2 3 4)))
      (error "Test-merge-null2 failed!"))
    ((not (equal? (mergesort <= test-null) '()))
      (error "Test-null failed!"))
    ((not (equal? (mergesort <= test-onesie) '(9)))
      (error "Test-onesie failed!"))
    ((not (equal? (mergesort <= test-sorted) '(1 2 3 4 5 6)))
      (error "Test-sorted failed!"))
    ((not (equal? (mergesort <= test-unsort) '(1 3 2 7 8 9)))
      (error "Test-unsorted failed!"))))


; Run all tests cases, no output is good output
; (run-all-tests)
