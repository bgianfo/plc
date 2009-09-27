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
;;; ex: (mergesort < '(2 1 4 4)) => (1 2 4 4)
(define (mergesort f? ls)
  (cond
    ((not (procedure? f?))
      (error "error: 'megesort' requires the first arg to be a procedure."))
    ((not (list? ls))
      (error "error: 'mergesort' requires the second arg to be a list."))
    ((or (null? ls) (null? (cdr ls))) ls)
    (else (merge f?
      (mergesort f? (car (sep ls))) (mergesort f? (cdr (sep ls)))))))

;;; method: Merge to lists together with a given predicate function.
;;; param: f? - Function to use when sorting the merge.
;;; param: list-one - First list of the two to merge.
;;; param: list-two - Second list to merge of the two.
;;; return: The product of both lists sorted per the predicate.
;;; ex: (merge < '(1 2) '(3 4)) => (1 2 3 4)
(define (merge f? l-one l-two)
  (cond
    ((not (procedure? f?))
      (error "error: 'merge' requires first arg to be a procedure"))
    ((not (and (list? l-one) (list? l-two)))
      (error "error: 'merge' requires second and third arg's to be list's"))
    ((null? l-one) l-two)
    ((null? l-two) l-one)
    ((f? (car l-one) (car l-two))
      (cons (car l-one) (merge f? (cdr l-one) l-two)))
    (else (cons (car l-two) (merge f? l-one (cdr l-two))))))

;;; method: Seperate a list in two parts, basically like a reverse 'car'.
;;; param: list - The list to seperate
;;; return: The input list seperated into two pieces
;;; ex: (sep '(1 2 3)) => ((1 2) 3)
(define (sep ls) 
  (if (not (list? ls))
    (error "error: 'sep' requires first arg to be a procedure")
  (cons (reverse (cdr (reverse ls))) (list (car (reverse ls))))))

;------ All Algorithm Tests  ------;

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

;;; Define all the test cases
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
    ((not (equal? (sep '(1 2 3)) '((1 2) 3)))
      (error "Test-sep #1 failed!"))
    ((not (equal? (sep '(1)) '(() 1)))
      (error "Test-sep #2 failed!"))
    ((not (equal? (mergesort <= test-null) '()))
      (error "Test-null failed!"))
    ((not (equal? (mergesort <= test-onesie) '(9)))
      (error "Test-onesie failed!"))
    ((not (equal? (mergesort <= test-sorted) '(1 2 3 4 5 6)))
      (error "Test-sorted failed!"))
    ((not (equal? (mergesort <= test-unsort) '(1 2 3 7 8 9)))
      (error "Test-unsorted failed!"))))

; Run all tests cases, no output is good output
(run-all-tests)
