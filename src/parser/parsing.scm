;; Author: Brian Gianforcaro (bjg1955@rit.edu)
;; Prolog parsing in scheme
(module parsing mzscheme

  (require "scanning.scm")
  (require scheme/list)
  (require mzlib/trace)
  (require errortrace)
  (provide parsePrologProg)

  ; Auxilary functions to treat a dotted cons as a pair:
  (define [pair x y] 
    (cons x y))
  (define [get-result p] 
    (car p))
  (define [get-next p]
    (cdr p))
  (define [peek-term i]
    "grap the first character of the i"
    (car i))

  (define [pop-back i]
    (reverse (cdr (reverse i))))

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

  (define punc 
    (list exclamation pipe equals right-paren left-paren comma fullstop colon-minus))
  ; There is one parsing function for each non-terminal in the grammar.
  ; Each such parsing function takes as i a stream of tokens and
  ; returns as a result either: a pair consisting of a parse tree rooted
  ; with the non-terminal and the remaining stream of tokens; or #f.

  (define [parsePrologProg i]
    (parse-prog i))

  ; Prog → RuleList $$
  (define [parse-prog i]
    (if (equal? (length i) 1)
      (if (not (equal? (get-result i) end-marker)) #f
        (list 'Prog '(RuleList) 'EndMarker))
      (if (not (equal? (last i) end-marker)) #f
        (let ([i (pop-back i)])
          (let ([result (parse-rule-list i)])
            (if (not result) #f
              (let ([rl (get-result result)] [inp (get-next result)])
                (if (not (empty? inp)) #f
                  (list 'Prog rl 'EndMarker)))))))))

  ; RuleList → ε
  ; RuleList → Rule RuleList
  (define [parse-rule-list i]
    (if (empty? i) (pair (list 'RuleList) '())
      (let ([res (parse-rule i)])
        (if (not res) #f
          (if (equal? (length res) 1)
            (pair (list 'RuleList (get-result res) '(RuleList)) '() )
            (let ([rule (get-result res)] [i (get-next res)])
              (let ([list-res (parse-rule-list i)])
                (if (not list-res) #f 
                  (let ([rule-list (get-result list-res)] [i (get-next list-res)])
                    (pair (list 'RuleList rule rule-list) i))))))))))


  ; Rule → Term.
  ; Rule → Term :- OBody.
  (define [parse-rule i]
    (let ([parse-result (parse-term i)])
      (if (not parse-result) #f
        (let ([term (get-result parse-result)] [i (get-next parse-result)])
          (if (empty? i) #f
            (let ([next-token (peek-term i)])
              (cond
                ((equal? next-token fullstop)
                  (pair (list 'Rule term fullstop) (get-next i)))           
                ((equal? next-token colon-minus)
                  (let ([col-min next-token] [i (get-next i)]) 
                    (let ([parse-o-body-res (parse-o-body i)])
                      (if (not parse-o-body-res) #f
                        (let ([obody (get-result parse-o-body-res)] [i (get-next parse-o-body-res)]) ; *
                          (let ([next-token (peek-term i)])
                            (if (not (equal? next-token fullstop)) #f
                              ; XXX: Might  need to change this back to empty list
                              (let ([i (get-next i)])                                            ; *
                                (pair (list 'Rule term col-min obody fullstop) i)))))))))
                  (else #f))))))))

  ; ABody → SBody,ABody
  ; ABody → SBody
  (define [parse-a-body i]
    (let ([parse-result (parse-s-body i)])
      (if (not parse-result) #f
        (let ([sbody (get-result parse-result)] [i (get-next parse-result)])
          (let ([next-token (peek-term i)])
            (cond
              ((equal? next-token comma)
                (let ([com next-token] [i (get-next i)])
                  (let ([parse-a-body-res (parse-a-body i)])
                    (if (not parse-a-body-res) #f
                      (let ([abody (get-result parse-a-body-res)] [i (get-next parse-a-body-res)])
                        (pair (list 'ABody sbody com abody) i))))))
              ((member next-token '(fullstop semicolon comma right-paren))
                (pair (list 'ABody sbody) i))
              (else #f)))))))

  ; OBody → ABody;OBody
  ; OBody → ABody
  (define [parse-o-body i]
    (let ([parse-result (parse-a-body i)])
      (if (not parse-result) #f
        (let ([abody (get-result parse-result)] [i (get-next parse-result)])
          (let ([next-token (peek-term i)])
            (cond
              ((equal? next-token semicolon)
                  (let ([semicol (peek-term i)] [inp (get-next i)])
                    (let ([parse-o-body-res (parse-o-body inp)])
                      (if (not parse-o-body-res) #f
                        (let ([obody (get-result parse-o-body-res)] [inp (get-next parse-o-body-res)])
                          (pair (list 'OBody abody semicol obody) inp))))))
              ((member next-token '(fullstop semicolon comma right-paren))
                (pair (list 'OBody abody) i))
              (else #f)))))))


  ; SBody → ( OBody )
  ; SBody → Term = Term
  ; SBody → !
  ; SBody → Term
  (define [parse-s-body i]
    (let ([first-tok (peek-term i)])
      (cond 
        ((equal? first-tok exclamation)
          (pair (list 'SBody exclamation) (get-next i)))
        ((equal? first-tok left-paren)
          (let ([lp (get-result i)] [i (get-next i)])
            (let ([parse-result (parse-o-body i)])
              (if (not parse-result) #f
                (let ([obody (get-result parse-result)] [i (get-next parse-result)])
                  (if (not (equal? (peek-term i) right-paren)) #f
                    (let ([rp (get-result i)] [i (get-next i)])
                      (pair (list 'SBody lp obody rp) i))))))))
        (else 
          (let ([term-parse-result (parse-term i)])
            (if (not term-parse-result) #f
              (let ([term (get-result term-parse-result)] [i (get-next i)])
                (if (not (equal? (peek-term i) equals))
                  (pair (list 'SBody term) i)
                  (let ([eq-tok (get-result i)] [i (get-next i)])
                    (let ([parse-result (parse-term i)])
                      (if (not parse-result) #f
                        (pair (list 'SBody term eq-tok (get-result parse-result)) (get-next parse-result)))))))))))))



  ; Term → Atom ✓
  ; Term → Num  ✓
  ; Term → Var  ✓
  ; Term → Atom ( TermList ) ✓
  ; Term → LTerm
  (define [parse-term i]
    (if (empty? i) #f
      (let ([term (get-result i)] [i (get-next i)])
        (cond
          ((equal? lbrack term)
            (let ([parse-result (parse-lterm (cons lbrack i))])
              (if (not parse-result) #f
                (pair (list 'Term (get-result parse-result)) (get-next parse-result)))))
          ((member term punc) #f)
          ((member term (list num var))
            (pair (list 'Term term) i))
          ((equal? prolog-atom term)
            (if (empty? i)
              (pair (list 'Term term) i)
              (let ([next-tok (peek-term i)])
                (if (not (equal? next-tok left-paren))
                  (pair (list 'Term prolog-atom) i)
                  (let ([lp (get-result i)] [i (get-next i)])
                    (let ([parse-result (parse-termlist i)])
                      (if (not parse-result) #f
                        (let ([tlist (get-result parse-result)] [i (get-next parse-result)])
                          (if (not (equal? (peek-term i) right-paren)) #f
                            (pair (list 'Term term left-paren tlist right-paren) (get-next i)))))))))))
            (else #f)))))

  ; TermList → Term
  ; TermList → TermList , Term
  (define [parse-termlist i]
    (let ([parse-res (parse-term i)]) 
      (if (and parse-res (not (equal? comma (peek-term (get-next parse-res)))))
        (let ([term (get-result parse-res)] [i (get-next parse-res)])
          (pair (list 'TermList term) i))
        (if (empty? i) #f
          (let ([tl-parse-res (parse-termlist (get-next i))]) ; throw away the comma
            (if (not tl-parse-res) #f
              (let ([tlist (get-result tl-parse-res)] [i (get-next tl-parse-res)])
                (if (equal? (peek-term i) comma) #f
                  (if (not parse-res) (pair (list tlist) i)
                    (pair (append '(TermList) (list (get-result parse-res)) '(comma) tlist ) i))))))))))

  ; LTerm → [ ]
  ; LTerm → [ TermList ]
  ; LTerm → [ TermList | Term ]
  (define [parse-lterm i]
    (let ([next-token (get-result i)] [i (get-next i)])
      (if (not (equal? next-token lbrack)) #f
        (if (equal? (peek-term i) rbrack)
          (pair (list 'LTerm lbrack rbrack) (get-next i))
          (let ([parse-result (parse-termlist i)])
            (if (not parse-result) #f
              (let ([term-list (get-result parse-result)] [i (get-next parse-result)])
                (let ([next-token (peek-term i)])
                  (cond
                    ((equal? next-token rbrack)
                      (pair (list 'LTerm lbrack term-list rbrack) (get-next i)))
                    ((equal? next-token pipe)
                      (let ([the-pipe (get-result i)] [i (get-next i)])
                        (let ([parse-result (parse-term i)])
                          (if (not parse-result) #f
                            (let ([term (get-result parse-result)] [i (get-next parse-result)])
                              (pair (list 'LTerm lbrack term-list the-pipe term rbrack) i))))))
                     (else #f))))))))))


#|
 (trace parse-prog)
 (trace parse-a-body)
 (trace parse-o-body)
 (trace parse-s-body)
 (trace parse-termlist)
 (trace parse-term)
 (trace parse-rule-list)
 (trace parse-rule)
 (trace parse-lterm)
|#
)
