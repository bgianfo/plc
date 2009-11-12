;; Author: Brian Gianforcaro (bjg1955@rit.edu)
;; Prolog parsing in scheme
(module parsing mzscheme

  (require "scanning.scm")
  (require scheme/list)
  (require mzlib/trace)
  (provide parsePrologProg)

  ; Auxilary functions to treat a dotted cons as a pair:
  (define [pair x y] 
    (cons x y))
  (define [get-result p] 
    (car p))
  (define [get-next p]
    (cdr p))
  (define [peek-term input]
    "grap the first character of the input"
    (car input))

  (define [pop-back input]
    (reverse (cdr (reverse input))))

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
    (list exclamation pipe rbrack lbrack equals right-paren left-paren comma fullstop colon-minus))
  ; There is one parsing function for each non-terminal in the grammar.
  ; Each such parsing function takes as input a stream of tokens and
  ; returns as a result either: a pair consisting of a parse tree rooted
  ; with the non-terminal and the remaining stream of tokens; or #f.

  (define [parsePrologProg input]
    (parse-prog input))

  ; Prog → RuleList $$
  (define [parse-prog input]
    (if (equal? (length input) 1)
      (if (not (equal? (get-result input) end-marker)) #f
        (list 'Prog '(RuleList) 'EndMarker))
      (if (not (equal? (last input) end-marker)) #f
        (let ([input (pop-back input)])
          (let ([result (parse-rule-list input)])
            (if (not result) #f
              (let ([rl (get-result result)] [inp (get-next result)])
                (if (not (empty? inp)) #f
                  (list 'Prog rl 'EndMarker)))))))))

  ; RuleList → ε
  ; RuleList → Rule RuleList
  (define [parse-rule-list input]
    (if (empty? input) (pair (list 'RuleList) '())
      (let ([res (parse-rule input)])
        (if (not res) #f
          (let ([rule (get-result res)] [input (get-next res)])
            (let ([list-res (parse-rule-list input)])
              (if (not list-res) #f 
                (let ([rule-list (get-result list-res)] [input (get-next list-res)])
                  (pair (list 'RuleList rule rule-list) input)))))))))


  ; Rule → Term.
  ; Rule → Term :- OBody.
  (define [parse-rule input]
    (let ([parse-result (parse-term input)])
      (if (not parse-result) #f
        (let ([term (get-result parse-result)] [input (get-next parse-result)])
          (if (empty? input) #f
            (let ([next-token (peek-term input)])
              (cond
                ((equal? next-token fullstop)
                  (pair (list 'Rule term fullstop) (get-next input)))
                ((equal? next-token colon-minus)
                    (let ([col-min next-token] [input (get-next input)])
                      (let ([parse-o-body-res (parse-o-body input)])
                        (if (not parse-o-body-res) #f
                          (let ([obody (get-result parse-o-body-res)] [input (get-next parse-o-body-res)])
                            (let ([next-token (peek-term input)])
                              (if (equal? next-token fullstop) #f
                                ; XXX: Might  need to change this back to empty list
                                (let ([input (get-next input)])
                                  (pair (list 'Rule term col-min obody fullstop) input))))))))))))))))

  ; ABody → SBody,ABody
  ; ABody → SBody
  (define [parse-a-body input]
    (let ([parse-result (parse-s-body input)])
      (if (not parse-result) #f
        (let ([sbody (get-result parse-result)] [input (get-next parse-result)])
          (let ([next-token (peek-term input)])
            (cond
              ((equal? next-token comma)
                (let ([com next-token] [input (get-next input)])
                  (let ([parse-a-body-res (parse-a-body input)])
                    (if (not parse-a-body-res) #f
                      (let ([abody (get-result parse-a-body-res)] [input (get-next parse-a-body-res)])
                        (pair (list 'ABody sbody com abody) input))))))
              ((member next-token '(fullstop semicolon comma right-paren))
                (pair (list 'ABody sbody) input))
              (else #f)))))))

  ; OBody → ABody;OBody
  ; OBody → ABody
  (define [parse-o-body input]
    (let ([parse-result (parse-a-body input)])
      (if (not parse-result) #f
        (let ([abody (get-result parse-result)] [input (get-next parse-result)])
          (let ([next-token (peek-term input)])
            (cond
              ((equal? next-token semicolon)
                  (let ([semicol (peek-term input)] [inp (get-next input)])
                    (let ([parse-o-body-res (parse-o-body inp)])
                      (if (not parse-o-body-res) #f
                        (let ([obody (get-result parse-o-body-res)] [inp (get-next parse-o-body-res)])
                          (pair (list 'OBody abody semicol obody) inp))))))
              ((member next-token '(fullstop semicolon comma right-paren))
                (pair (list 'OBody abody) input))
              (else #f)))))))


  ; SBody → ( OBody )
  ; SBody → Term = Term
  ; SBody → !
  ; SBody → Term
  (define [parse-s-body input]
    (let ([first-tok (peek-term input)])
      (cond 
        ((equal? first-tok exclamation)
          (pair (list 'SBody exclamation) (get-next input)))
        ((equal? first-tok left-paren)
          (let ([lp (get-result input)] [input (get-next input)])
            (let ([parse-result (parse-o-body input)])
              (if (not parse-result) #f
                (let ([obody (get-result parse-result)] [input (get-next parse-result)])
                  (if (not (equal? (peek-term input) right-paren)) #f
                    (let ([rp (get-result input)] [input (get-next input)])
                      (pair (list 'SBody lp obody rp) input))))))))
        (else 
          (let ([term-parse-result (parse-term input)])
            (if (not term-parse-result) #f
              (let ([term (get-result term-parse-result)] [input (get-next input)])
                (if (not (equal? (peek-term input) equals))
                  (pair (list 'SBody term) input)
                  (let ([eq-tok (get-result input)] [input (get-next input)])
                    (let ([parse-result (parse-term input)])
                      (if (not parse-result) #f
                        (pair (list 'SBody term eq-tok (get-result parse-result)) (get-next parse-result)))))))))))))

  ; Term → Atom ✓
  ; Term → Num  ✓
  ; Term → Var  ✓
  ; Term → Atom ( TermList ) ✓
  ; Term → LTerm
  (define [parse-term input]
    (let ([term (get-result input)] [input (get-next input)])
      (cond
        ((member term punc) #f)
        ((member term (list num var))
            (pair (list 'Term term) input))
        ((equal? prolog-atom term)
          (if (empty? input)
            (pair (list 'Term term) input)
            (let ([next-tok (peek-term input)])
              (if (not (equal? next-tok left-paren))
                (pair (list 'Term prolog-atom) input)
                (let ([lp (get-result input)] [input (get-next input)])
                  (let ([parse-result (parse-termlist input)])
                    (if (not parse-result) #f
                      (let ([tlist (get-result parse-result)] [input (get-next parse-result)])
                        (if (not (equal? (peek-term input) right-paren)) #f
                          (pair (list 'Term term left-paren tlist right-paren) (get-next input)))))))))))
        (else 
          (let ([parse-result (parse-lterm input)])
            (if (not parse-result) #f
              (pair (list 'Term (get-result parse-result)) (get-next parse-result))))))))


  ; TermList → Term
  ; TermList → TermList , Term
   
  (define [parse-termlist input]
    (let ([res-tml (parse-termlist input)])
      (if (not res-tml) 
        (let ([res-term (parse-term input)]) 
          (if (not res-term) #f
            (pair (list 'TermList (get-result res-term)) (get-next res-term))))
        (let ([tlist (get-result res-tml)] [input (get-next res-tml)])
          (if (not (equal? (peek-term input) comma)) #f
            (let ([com (get-result input)] [input (get-next input)])
              (let ([parse-result (parse-term input)])
                (if (not parse-result) #f
                  (let ([term (get-result parse-result)] [input (get-next parse-result)])
                    (pair (list 'TermList tlist com term) input))))))))))

  ; LTerm → [ ]
  ; LTerm → [ TermList ]
  ; LTerm → [ TermList | Term ]
  (define [parse-lterm input]
    (let ([next-token (get-result input)] [input (get-next input)])
      (if (not (equal? next-token lbrack)) #f
        (if (equal? (peek-term input) rbrack)
          (pair (list 'LTerm lbrack rbrack) (get-next input))
          (let ([parse-result (parse-termlist input)])
            (if (not parse-result) #f
              (let ([term-list (get-result parse-result)] [input (get-next parse-result)])
                (let ([next-token (peek-term input)])
                  (cond
                    ((equal? next-token rbrack)
                      (pair (list 'LTerm lbrack term-list rbrack) (get-next input)))
                    ((equal? next-token pipe)
                      (let ([the-pipe (get-result input)] [input (get-next input)])
                        (let ([parse-result (parse-term input)])
                          (if (not parse-result) #f
                            (let ([term (get-result parse-result)] [input (get-next parse-result)])
                              (pair (list 'LTerm lbrack term-list the-pipe term rbrack) input)))))))))))))))



  (trace parse-prog)
  (trace parse-a-body)
  (trace parse-o-body)
  (trace parse-s-body)
  (trace parse-termlist)
  (trace parse-term)
  (trace parse-rule-list)
  (trace parse-rule)
  (trace parse-lterm)
)
