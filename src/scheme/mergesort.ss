;#lang scheme

;;;; Author: Brian Gianforcaro
;;;; PLC Lab #1 - Merge sort in scheme 

;;; method: Auxiliary recursive dice function.
;;; param: list - The full list for book keeping
;;; param: list-one - The first half of the split into two
;;; param: list-two - The second half of the split list
;;; return: 
(define (dice! lst lst-one lst-two)
  (cond 
    ((or (null? lst ) (null? (cdr lst)))
     (cons (reverse lst-two) lst-one))
    (else (dice! (cdr lst) (cdr lst-one) (cons (car lst-one) lst-two)))))

;;; method: The main API function to slice a list in to two parts.
;;; param: list - The full list to slit 
;;; return: The input list split to pieces
(define (slice! lst)
  (dice! lst lst '()))

;;; method: Merge to lists togeather with a given preddicate function. 
;;; param: f? - Predicate function to use when sorting the meger.
;;; param: list-one - First list of the two to merge.
;;; param: list-two - Second list to merge of the two.
;;; return: The product of both lists sorted per the predicate.
(define (merge f? lst-one lst-two)
  (cond
    ((null? lst-one) lst-two)
    ((null? lst-two) lst-one)   
    ((f? (car lst-one) (car lst-two))
     (cons (car lst-one) (merge f? (cdr lst-one) lst-two)))
    (else (cons (car lst-two) (merge f? lst-one (cdr lst-two))))))


;;; method: The main interface
;;; param: f? - predicate to use when sorting
;;; param: lst - list to sort via the "p" preddicate function.
;;; return: the resulting sorted list.
(define (mergesort f? lst)
  (cond
    ((not (procedure? f?))
     (error "error: megesort requries the first arg to be a procedure."))
    ((not (list? lst))
     (error "error: mergesort requires the second arg to be a list.")) 
    ((or (null? lst) (null? (cdr lst))) lst)
    (else (merge f? 
            (mergesort f? (car (slice! lst))) (mergesort f? (cdr (slice! lst)))))))



;------ All algorithm testing  ------;

;;; All test cases for mergesort
(define (test-null) '())
(define (test-onesie) '(9))
(define (test-sorted) '(1 2 3 4 5 6))
(define (test-unsort) '(9 2 3 8 7 1))
;;; All test cases for merge
(define (test-merge-one) (cons (list 2) (list 1)))
(define (test-merge-couple) (cons (list 1234 3 6) (list 2 39 8 1)))
(define (test-merge-null) (cons '() (list 2 3 4)))
(define (test-merge-null2)(cons (list 2 3 4) '()))
  
;;; Define all the 'merge' test cases
(define (merge-test-helper lst)
  (merge <= (car lst) (cdr lst)))
(define (run-all-merge-tests)
  (cond 
    ((not (equal? (merge-test-helper (test-merge-one)) '(1 2)))
         (merge-test-helper (test-merge-one)(error "Test-merge-one failed!"))
    ((not (equal? (merge-test-helper (test-merge-couple)) '(2 39 8 1 1234 3 6)))
         (error "Test-merge-couple failed!"))
    ((not (equal? (merge-test-helper (test-merge-null)) '(2 3 4)))
         (error "Test-merge-null failed!"))
    ((not (equal? (merge-test-helper (test-merge-null2)) '(2 3 4)))
         (error "Test-merge-null2 failed!")))))

;;; Define all the 'mergesort' test cases 
(define (run-all-tests)
  (cond
    ((not (equal? (mergesort <= (test-null)) (sort (test-null) <)))
     (error "Test-null failed!")) 
    ((not (equal? (mergesort <= (test-onesie)) (sort (test-onesie) <)))
     (error "Test-onesie failed!"))
    ((not (equal? (mergesort <= (test-sorted)) (sort (test-sorted) <)))
     (error "Test-sorted failed!"))
    ((not (equal? (mergesort <= (test-unsort)) (sort (test-unsort) <)))
     (error "Test-unsorted failed!"))))


; Run all tests cases ;
(run-all-merge-tests)
(run-all-tests)
