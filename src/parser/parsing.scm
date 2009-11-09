;; Brian Gianforcaro (bjg1955@rit.edu)
;; Prolog parsing in scheme
(module parsing mzscheme

  (require "scanning.scm")
  (require scheme/list)
  (provide parsePrologProg)
   
  (define (parse-var input) #f)

  (define (peek-term input) 'EndMarker)

  (define (parse-and-check input) 'EndMarker)

  ; Auxilary functions to treat a dotted cons as a pair:
  (define (pair x y) (cons x y))
  (define (fst p) (car p))
  (define (snd p) (cdr p))

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
 
  (define (parsePrologProg input)
    (parse-prog input))
 
  ; Prog → RuleList $$
  (define (parse-prog input)
    (let ((parse-result (parse-rule-list input)))
      (if (not parse-result) #f
        (let ((rulelist (fst parse-result)) (inp (snd parse-result)))
          (let ((next-token (peek-term inp)))
            (if (not (equal? next-token end-marker)) #f
              (list 'Prog rulelist end-marker)))))))

  ; RuleList → ε
  ; RuleList → Rule RuleList
  (define (parse-rule-list input) 
    (if (empty? input) '()
      (let ((rule (parse-rule (fst input))) (rulelist (parse-reul-list (snd input))))
        (list rule rulelist))))

  ; Rule → Term.
  ; Rule → Term :- OBody.
  (define (parse-rule input)


  ; ABody → SBody,ABody
  ; ABody → SBody
  (define (parse-a-body input)
    (let ((parse-result (parse-s-body input)))
      (if (not parse-result) #f
        (let ((sbody (fst parse-result)) (input (snd parse-result)))
          (let ((next-token (peek-term input)))
            (cond
              ((equal? next-token comma)
                (let ((ptsc_res (parse-and-check semicolon input)))
                  (let ((com (fst ptsc_res)) (inp (snd ptsc_res)))
                    (let ((parse-a-body-res (parse-a-body inp)))
                      (if (not parse-a-body-res) #f          
                        (let ((abody (fst parse-a-body-res)) (inp (snd parse-a-body-res)))
                          (pair (list 'OBody sbody com abody) inp)))))))
              ((member next-token '(fullstop semicolon comma rparen))
                (pair (list 'OBody sbody) input))
              (else #f)))))))

  ; OBody → ABody;OBody
  ; OBody → ABody
  (define (parse-o-body input)
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
  (define (parse-s-body input) #f)
  ;    (let ((term-parse-result (parse-term input)

)
