;; Author: Brian Gianforcaro (bjg1955@rit.edu)
;; Prolog parsing in scheme
(module parsing mzscheme

  (require "scanning.scm")
  (require scheme/list)
  (provide parsePrologProg)

  (define [parse-and-check input] 'EndMarker)

  ; Auxilary functions to treat a dotted cons as a pair:
  (define [pair x y] (cons x y))
  (define [fst p] (car p))
  (define [snd p] (cdr p))

  (define end-marker  'EndMarker)     ;  $$
  (define fullstop    'fullstop)      ;  .
  (define colon-minus 'colon-minus)   ;  :-
  (define semicolon   'semicolon)     ;  ;
  (define comma       'comma)         ;  ,
  (define left-paren  'lparen)        ;  (
  (define right-paren 'rparen)        ;  )
  (define equals      'equals)        ;  =
  (define exclamation 'exclam)        ;  !
  (define prolog-atom 'Atom)          ;  Atom
  (define num         'Num)           ;  Num
  (define var         'Var)           ;  Var
  (define lbrack      'lsqbrack)      ;  [
  (define rbrack      'rsqbrack)      ;  ]
  (define pipe        'vertline)      ;  |

  ; There is one parsing function for each non-terminal in the grammar.
  ; Each such parsing function takes as input a stream of tokens and
  ; returns as a result either: a pair consisting of a parse tree rooted
  ; with the non-terminal and the remaining stream of tokens; or #f.

  (define [parsePrologProg input]
    (parse-prog input))

  ; Baby helper function
  (define [peek-term input]
    (fst input))
    ;(if (or (empty? input) (equal? (first input) (list))) '()
    ;  (second input)))

  ; Prog → RuleList $$
  (define [parse-prog input]
    (let ((parse-result (parse-rule-list input)))
      (if (not parse-result) #f
        (let ((rulelist (fst parse-result)) (inp (snd parse-result)))
          (let ((next-token (peek-term inp)))
            (if (not (equal? next-token end-marker)) #f
              (list 'Prog rulelist end-marker)))))))

  ; RuleList → ε
  ; RuleList → Rule RuleList
  (define [parse-rule-list input]
    (if (empty? (fst input)) (pair '() (snd input))
      (let ((rule (parse-rule (fst input))) (rulelist (parse-rule-list (snd input))))
        (list rule rulelist))))

  ; Rule → Term.
  ; Rule → Term :- OBody.
  (define [parse-rule input]
    (let ((parse-result (parse-term input)))
      (if (not parse-result) #f
        (let ((term (fst (parse-result))) (input (snd parse-result)))
          (let ((next-token (peek-term input)))
            (cond
              ((equal? next-token fullstop)
                (pair (list 'Rule term fullstop) input))
              ((equal? next-token colon-minus)
                (let ((parse-check-res (parse-and-check colon-minus input)))
                  (let ((col-min (fst parse-check-res)) (input (snd parse-check-res)))
                    (let ((parse-o-body-res (parse-o-body input)))
                      (if (not parse-o-body-res) #f
                        (let ((obody (fst parse-o-body-res)) (input (snd parse-o-body-res)))
                          (let ((next-token (peek-term input)))
                            (if (equal? next-token fullstop) #f
                              (pair (list 'Rule term col-min obody fullstop))))))))))))))))

  ; ABody → SBody,ABody
  ; ABody → SBody
  (define [parse-a-body input]
    (let ((parse-result (parse-s-body input)))
      (if (not parse-result) #f
        (let ((sbody (fst parse-result)) (input (snd parse-result)))
          (let ((next-token (peek-term input)))
            (cond
              ((equal? next-token comma)
                (let ((parse-check-res (parse-and-check semicolon input)))
                  (let ((com (fst parse-check-res)) (inp (snd parse-check-res)))
                    (let ((parse-a-body-res (parse-a-body inp)))
                      (if (not parse-a-body-res) #f
                        (let ((abody (fst parse-a-body-res)) (inp (snd parse-a-body-res)))
                          (pair (list 'ABody sbody com abody) inp)))))))
              ((member next-token '(fullstop semicolon comma rparen))
                (pair (list 'ABody sbody) input))
              (else #f)))))))

  ; OBody → ABody;OBody
  ; OBody → ABody
  (define [parse-o-body input]
    (let ((parse-result (parse-a-body input)))
      (if (not parse-result) #f
        (let ((abody (fst parse-result)) (input (snd parse-result)))
          (let ((next-token (peek-term input)))
            (cond
              ((equal? next-token semicolon)
                (let ((ptsc_res (parse-and-check semicolon input)))
                  (let ((semicol (fst ptsc_res)) (inp (snd ptsc_res)))
                    (let ((parse-o-body-res (parse-o-body inp)))
                      (if (not parse-o-body-res) #f
                        (let ((obody (fst parse-o-body-res)) (inp (snd parse-o-body-res)))
                          (pair (list 'OBody abody semicol obody) inp)))))))
              ((member next-token '(fullstop semicolon comma rparen))
                (pair (list 'OBody abody) input) )
              (else #f)))))))


  ; SBody → ( OBody )
  ; SBody → Term = Term
  ; SBody → !
  ; SBody → Term
  (define [parse-s-body input] #f)
  ;    (let ((term-parse-result (parse-term input)

  ; Term → Atom
  ; Term → Num
  ; Term → Var
  ; Term → Atom ( TermList )
  ; Term → LTerm
  (define [parse-term input] #f)
#|    (let ((term (fst input)) (input (snd input)))
      (cond
        ((member term (list prolog-atom num var))
          (pair (list 'Term term) input))
        ((equals?

           |#


; TermList → Term
; TermList → TermList , Term
 
  (define [parse-termlist input]
    (let ((parse-result-term (parse-term input)) (parse-result-tml (parse-termlist input)))
      (cond 
        (parse-result-term 
          (pair (list 'TermList (fst parse-result-term)) (snd parse-result-term)))
        (parse-result-tml
          (let ((tlist (fst parse-result-tml)) (input (snd parse-result-tml)))
            (if (not (equal? (peek-term input) comma)) #f
              (let ((com (fst input)) (input (snd input)))
                (let ((parse-result (parse-term input)))
                  (if (not parse-result) #f
                    (let ((term (fst parse-result)) (input (snd parse-result)))
                      (pair (list 'TermList tlist com term) input))))))))
        (else #f))))

; LTerm → [ ]
; LTerm → [ TermList ]
; LTerm → [ TermList | Term ]
  (define [parse-lterm input]
    (let ((next-token (fst input)) (input (snd input)))
      (if (not (equal? next-token lbrack)) #f
        (if (equal? (peek-term input) rbrack)
          (pair (list 'LTerm lbrack rbrack) (snd input))
          (let ((parse-result (parse-termlist input)))
            (if (not parse-result) #f
              (let ((term-list (fst parse-result)) (input (snd parse-result)))
                (let ((next-token (peek-term input)))
                  (cond
                    ((equal? next-token rbrack)
                      (pair (list 'LTerm lbrack term-list rbrack) (snd input)))
                    ((equal? next-token pipe)
                      (let ((the-pipe (fst input)) (input (snd input)))
                        (let ((parse-result (parse-term input)))
                          (if (not parse-result) #f
                            (let ((term (fst parse-result)) (input (snd parse-result)))
                              (pair (list 'LTerm lbrack term-list the-pipe term rbrack) input)))))))))))))))



)
