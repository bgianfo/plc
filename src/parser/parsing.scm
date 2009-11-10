(module parsing mzscheme

  (require "scanning.scm")  
  (require scheme/list)
  (provide parsePrologProg)
  (define (parsePrologProg input)
    (if (equal? (last input) 'EndMarker)
      (cons '(Prog (RuleList) ) (last input)) 
    #f))

  ; Auxilary functions to treat a dotted cons as a pair:
  (define (pair x y) (cons x y))
  (define (fst p) (car p))
  (define (snd p) (cdr p))

;  $$  	'EndMarker
;  . 	'fullstop
;  :- 	'colon-minus
;  ; 	'semicolon
;  , 	'comma
;  ( 	'lparen
;  ) 	'rparen
;  = 	'equals
;  ! 	'exclam
;  Atom 	'Atom
;  Num 	'Num
;  Var 	'Var
;  [ 	'lsqbrack
;  ] 	'rsqbrack
;  | 	'vertline
  

  ; There is one parsing function for each non-terminal in the grammar.
  ; Each such parsing function takes as input a stream of tokens and
  ; returns as a result either: a pair consisting of a parse tree rooted
  ; with the non-terminal and the remaining stream of tokens; or #f.

  ; OBody --> ABody ; OBody
  ; OBody --> ABody
  (define (parseOBody inp)
    (let (; attempt to parse the required ABody
          (pab_res (parseABody inp)) )
      (if (not pab_res)   ; if parsing the ABody failed, 
          #f              ; then parsing the OBody fails 
          ; otherwise, parsing the ABody succeeded
          (let (; extract the ABody parse tree
                (abody (fst pab_res)) 
                ; extract the remaining stream of tokens
                (inp (snd pab_res)) )
            (let (; Peek at the next token
                  (next_tok (peekTerminal inp)) )
              (cond
                (; if the next token is a ';',
                 ; then use the "OBody --> ABody ; OBody" production.
                 (equal? next_tok 'semicolon)
                 (let (; parse the ';' token;
                       ; must succeed given peek token
                       (ptsc_res (parseAndCheckTerminal 'semicolon inp)) )
                   (let (; extract the semicolon token
                         (semicolon (fst ptsc_res)) 
                         ; extract the remaining stream of tokens
                         (inp (snd ptsc_res)) )
                     (let (; Attempt to parse the OBody
                           (pob_res (parseOBody inp)) )
                       (if (not pob_res)   ; if parsing the OBody failed
                           #f              ; then parsing the OBody fails
                           ; otherwise, parsing the OBody succeeded
                           (let (; extract the OBody parse tree
                                 (obody (fst pob_res))
                                 ; extract the remaining stream of tokens
                                 (inp (snd pob_res)))
                             ; return result pair
                             (pair ; "OBody --> ABody ; OBody" parse tree
                                   (list 'OBody abody semicolon obody)
                                   ; remaining input
                                   inp)))))) )
                (; if the next token is in Follow(OBody),
                 ; then use the "OBody --> ABody" production.
                 (member next_tok '(fullstop semicolon comma rparen)) 
                 ; return result pair
                 (pair ; "OBody --> ABody" parse tree
                       (list 'OBody abody) 
                       ; remaining input
                       inp) ) 
                (; otherwise, parsing the OBody fails
                 else #f)))))))

)
