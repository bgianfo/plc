: Excerpt from the following checked-in file:
; $Id: parsing.scm,v 1.7 2009/11/04 14:55:51 jeh Exp $

; Scheme parser for a simplified Prolog
; James Heliotis
; November 2009


; These parsing functions take the input stream as an argument and return
; a list consisting of:
; - a modified input stream as the first element, followed by
; - the child nodes for the parse tree.

; That list of child nodes is used by the caller of the parsing function
; and fit as children into a new tree node representing the rule.


; Parse an OBody non-terminal. According to the grammar,
;
;   OBody ::= ABody ; OBody | ABody
;
(define parse-OBody
    (lambda (stream)
        (let*
            (
                (abody (parse-ABody stream)) ; Get the required ABody
                (restStream (car abody)) ; assign stream remnants to local var
            )
            (cond
                        ; If the stream is now empty, we're in trouble.
                ((null? restStream) (list restStream #f))
                        ; If a ';' follows, fetch the OBody after it.
                ((eq? (car restStream) 'semicolon)
                    (let*
                        (
                            (obody (parse-OBody (cdr restStream))) ; Get OBody
                            (rrestStream (car obody)) ; assign stream remnants
                        )
                        ; Return what we've parsed as a list of subtrees
                        (list
                            rrestStream ; (...plus the rest of the stream)
                            (cons 'ABody (cdr abody))
                            'semicolon
                            (cons 'OBody (cdr obody))
                        )
                    )
                )
                ; Otherwise just return the ABody as this OBody (1st rule)
                (else (list restStream (cons 'ABody (cdr abody))))
            )
        )
    )
)

