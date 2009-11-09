(module scanning mzscheme

  (provide scanPrologProg)
  (provide scanPrologProgFromString)
  (provide scanPrologProgFromFile)

(define (pair x y) (cons x y))
(define (fst p) (car p))
(define (snd p) (cdr p))

(define (scanPrologProgFromString str)
  (scanPrologProg (string->list str)))

(define (scanPrologProgFromFile file)
  (let ((port (open-input-file file)))
    (letrec ((read-all-chars (lambda (chrs)
                               (let ((chr (read-char port)))
                                 (if (eof-object? chr)
                                     (reverse chrs)
                                     (read-all-chars (cons chr chrs)))))))
      (let ((chrs (read-all-chars '())))
        (let ((z (close-input-port port)))
          (scanPrologProg chrs))))))

(define (scanPrologProg inp)
  (if (not (list? inp)) #f
      (scanTokens inp '())))

(define (scanTokens inp toks)
  (let ((inp (scanWhiteSpace inp)))
    (if (null? inp) (reverse (cons 'EndMarker toks))
        (let ((st_res (scanToken inp)))
          (if (not st_res) #f
              (let ((tok (fst st_res))
                    (inp (snd st_res)))
                (scanTokens inp (cons tok toks))))))))

(define (scanWhiteSpace inp)
  (if (null? inp) inp
      (let ((chr (car inp)))
        (cond
          ((char-whitespace? chr) (scanWhiteSpace (cdr inp)))
          ((equal? chr #\%)
           (letrec ((finishLineComment (lambda (inp) 
                                         (if (null? inp) inp
                                             (let ((chr (car inp)))
                                               (cond
                                                 ((equal? chr #\newline) (cdr inp))
                                                 (else (finishLineComment (cdr inp)))))))))
             (scanWhiteSpace (finishLineComment (cdr inp)))))
          (else inp)))))

(define (scanToken inp) 
  (if (null? inp) #f
      (let ((chr (car inp))
            (inp (cdr inp)))
        (cond
          ((equal? chr #\.) (pair 'fullstop inp))
          ((equal? chr #\:) 
           (if (null? inp) #f
               (let ((chr (car inp))
                     (inp (cdr inp)))
                 (cond
                   ((equal? chr #\-) (pair 'colon-minus inp))
                   (else #f)))))
          ((equal? chr #\;) (pair 'semicolon inp))
          ((equal? chr #\,) (pair 'comma inp))
          ((equal? chr #\() (pair 'lparen inp))
          ((equal? chr #\)) (pair 'rparen inp))
          ((equal? chr #\=) (pair 'equals inp))
          ((equal? chr #\!) (pair 'exclam inp))
          ((equal? chr #\[) (pair 'lsqbrack inp))
          ((equal? chr #\]) (pair 'rsqbrack inp))
          ((equal? chr #\|) (pair 'vertline inp))
          ((char-lower-case? chr)
           (letrec ((finishAtom (lambda (inp)
                                  (if (null? inp) inp
                                      (let ((chr (car inp)))
                                        (cond
                                          ((or (char-lower-case? chr)
                                               (char-upper-case? chr)
                                               (char-numeric? chr)
                                               (equal? chr #\_))
                                           (finishAtom (cdr inp)))
                                          (else inp)))))))
             (pair 'Atom (finishAtom inp))))
          ((char-numeric? chr)
           (letrec ((finishNum (lambda (inp)
                                 (if (null? inp) inp
                                     (let ((chr (car inp)))
                                       (cond
                                         ((char-numeric? chr)
                                          (finishNum (cdr inp)))
                                         (else inp)))))))
             (pair 'Num (finishNum inp))))
          ((or (equal? chr #\_)
               (char-upper-case? chr))
           (letrec ((finishVar (lambda (inp)
                                 (if (null? inp) inp
                                     (let ((chr (car inp)))
                                       (cond
                                         ((or (char-lower-case? chr)
                                              (char-upper-case? chr)
                                              (char-numeric? chr)
                                              (equal? chr #\_))
                                          (finishVar (cdr inp)))
                                         (else inp)))))))
             (pair 'Var (finishVar inp))))
          (else #f)))))

)
