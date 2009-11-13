(module testing-alt mzscheme

  (require "parsing.scm")
  (provide run-tests)
  (provide run-test)

(provide test01)
(define test01
  (let (
        (test01_name "test01")
        (test01_input '(EndMarker))
        (test01_output '(Prog (RuleList) EndMarker))
       )
    (list test01_name test01_input test01_output)))

(provide test02)
(define test02
  (let (
        (test02_name "test02")
        (test02_input '(Atom fullstop EndMarker))
        (test02_output '(Prog (RuleList (Rule (Term Atom) fullstop) (RuleList)) EndMarker))
       )
    (list test02_name test02_input test02_output)))

(provide test03)
(define test03
  (let (
        (test03_name "test03")
        (test03_input '(Atom fullstop Atom fullstop EndMarker))
        (test03_output '(Prog (RuleList (Rule (Term Atom) fullstop) (RuleList (Rule (Term Atom) fullstop) (RuleList))) EndMarker))
       )
    (list test03_name test03_input test03_output)))

(provide test04)
(define test04
  (let (
        (test04_name "test04")
        (test04_input '(fullstop EndMarker))
        (test04_output '#f)
       )
    (list test04_name test04_input test04_output)))

(provide test05)
(define test05
  (let (
        (test05_name "test05")
        (test05_input '(Atom fullstop Atom EndMarker))
        (test05_output '#f)
       )
    (list test05_name test05_input test05_output)))

(provide test06)
(define test06
  (let (
        (test06_name "test06")
        (test06_input '(Atom fullstop Atom fullstop Atom fullstop Atom fullstop Atom fullstop Atom fullstop Atom fullstop EndMarker))
        (test06_output '(Prog (RuleList (Rule (Term Atom) fullstop) (RuleList (Rule (Term Atom) fullstop) (RuleList (Rule (Term Atom) fullstop) (RuleList (Rule (Term Atom) fullstop) (RuleList (Rule (Term Atom) fullstop) (RuleList (Rule (Term Atom) fullstop) (RuleList (Rule (Term Atom) fullstop) (RuleList)))))))) EndMarker))
       )
    (list test06_name test06_input test06_output)))

(provide test07)
(define test07
  (let (
        (test07_name "test07")
        (test07_input '(Num fullstop Num fullstop Num fullstop Num fullstop Num fullstop Num fullstop EndMarker))
        (test07_output '(Prog (RuleList (Rule (Term Num) fullstop) (RuleList (Rule (Term Num) fullstop) (RuleList (Rule (Term Num) fullstop) (RuleList (Rule (Term Num) fullstop) (RuleList (Rule (Term Num) fullstop) (RuleList (Rule (Term Num) fullstop) (RuleList))))))) EndMarker))
       )
    (list test07_name test07_input test07_output)))

(provide test08)
(define test08
  (let (
        (test08_name "test08")
        (test08_input '(Var fullstop Var fullstop Var fullstop EndMarker))
        (test08_output '(Prog (RuleList (Rule (Term Var) fullstop) (RuleList (Rule (Term Var) fullstop) (RuleList (Rule (Term Var) fullstop) (RuleList)))) EndMarker))
       )
    (list test08_name test08_input test08_output)))

(provide test09)
(define test09
  (let (
        (test09_name "test09")
        (test09_input '(Atom lparen Var rparen fullstop EndMarker))
        (test09_output '(Prog (RuleList (Rule (Term Atom lparen (TermList (Term Var)) rparen) fullstop) (RuleList)) EndMarker))
       )
    (list test09_name test09_input test09_output)))

(provide test10)
(define test10
  (let (
        (test10_name "test10")
        (test10_input '(Atom lparen Var comma Var comma Var rparen fullstop EndMarker))
        (test10_output '(Prog (RuleList (Rule (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen) fullstop) (RuleList)) EndMarker))
       )
    (list test10_name test10_input test10_output)))

(provide test11)
(define test11
  (let (
        (test11_name "test11")
        (test11_input '(Atom lparen Var comma Var comma Var comma Var comma Var comma Var comma Var comma Var rparen fullstop EndMarker))
        (test11_output '(Prog (RuleList (Rule (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var))))))))) rparen) fullstop) (RuleList)) EndMarker))
       )
    (list test11_name test11_input test11_output)))

(provide test12)
(define test12
  (let (
        (test12_name "test12")
        (test12_input '(Atom lparen Atom lparen Num rparen comma Atom lparen Atom comma Atom rparen comma Atom lparen Var comma Var comma Var rparen comma Atom lparen Atom lparen Atom lparen Atom lparen Atom rparen rparen rparen rparen rparen fullstop EndMarker))
        (test12_output '(Prog (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Num)) rparen) comma (TermList (Term Atom lparen (TermList (Term Atom) comma (TermList (Term Atom))) rparen) comma (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen) comma (TermList (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Atom)) rparen)) rparen)) rparen)) rparen))))) rparen) fullstop) (RuleList)) EndMarker))
       )
    (list test12_name test12_input test12_output)))

(provide test13)
(define test13
  (let (
        (test13_name "test13")
        (test13_input '(Atom lparen Var Var Var rparen fullstop EndMarker))
        (test13_output '#f)
       )
    (list test13_name test13_input test13_output)))

(provide test14)
(define test14
  (let (
        (test14_name "test14")
        (test14_input '(Atom lparen Num comma Num comma Num Num rparen fullstop EndMarker))
        (test14_output '#f)
       )
    (list test14_name test14_input test14_output)))

(provide test15)
(define test15
  (let (
        (test15_name "test15")
        (test15_input '(Atom lparen Atom lparen Var rparen fullstop EndMarker))
        (test15_output '#f)
       )
    (list test15_name test15_input test15_output)))

(provide test16)
(define test16
  (let (
        (test16_name "test16")
        (test16_input '(Atom lparen lsqbrack rsqbrack rparen fullstop EndMarker))
        (test16_output '(Prog (RuleList (Rule (Term Atom lparen (TermList (Term (LTerm lsqbrack rsqbrack))) rparen) fullstop) (RuleList)) EndMarker))
       )
    (list test16_name test16_input test16_output)))

(provide test17)
(define test17
  (let (
        (test17_name "test17")
        (test17_input '(Atom lparen lsqbrack Var rsqbrack rparen fullstop EndMarker))
        (test17_output '(Prog (RuleList (Rule (Term Atom lparen (TermList (Term (LTerm lsqbrack (TermList (Term Var)) rsqbrack))) rparen) fullstop) (RuleList)) EndMarker))
       )
    (list test17_name test17_input test17_output)))

(provide test18)
(define test18
  (let (
        (test18_name "test18")
        (test18_input '(Atom lparen lsqbrack Var comma Var rsqbrack rparen fullstop EndMarker))
        (test18_output '(Prog (RuleList (Rule (Term Atom lparen (TermList (Term (LTerm lsqbrack (TermList (Term Var) comma (TermList (Term Var))) rsqbrack))) rparen) fullstop) (RuleList)) EndMarker))
       )
    (list test18_name test18_input test18_output)))

(provide test19)
(define test19
  (let (
        (test19_name "test19")
        (test19_input '(Atom lparen lsqbrack Var comma Var comma Var comma Var comma Var comma Var comma Var comma Var rsqbrack rparen fullstop EndMarker))
        (test19_output '(Prog (RuleList (Rule (Term Atom lparen (TermList (Term (LTerm lsqbrack (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var))))))))) rsqbrack))) rparen) fullstop) (RuleList)) EndMarker))
       )
    (list test19_name test19_input test19_output)))

(provide test20)
(define test20
  (let (
        (test20_name "test20")
        (test20_input '(Atom lparen lsqbrack lsqbrack rsqbrack rsqbrack rparen fullstop EndMarker))
        (test20_output '(Prog (RuleList (Rule (Term Atom lparen (TermList (Term (LTerm lsqbrack (TermList (Term (LTerm lsqbrack rsqbrack))) rsqbrack))) rparen) fullstop) (RuleList)) EndMarker))
       )
    (list test20_name test20_input test20_output)))

(provide test21)
(define test21
  (let (
        (test21_name "test21")
        (test21_input '(Atom lparen lsqbrack lsqbrack lsqbrack lsqbrack lsqbrack lsqbrack lsqbrack lsqbrack rsqbrack rsqbrack rsqbrack rsqbrack rsqbrack rsqbrack rsqbrack rsqbrack rparen fullstop EndMarker))
        (test21_output '(Prog (RuleList (Rule (Term Atom lparen (TermList (Term (LTerm lsqbrack (TermList (Term (LTerm lsqbrack (TermList (Term (LTerm lsqbrack (TermList (Term (LTerm lsqbrack (TermList (Term (LTerm lsqbrack (TermList (Term (LTerm lsqbrack (TermList (Term (LTerm lsqbrack (TermList (Term (LTerm lsqbrack rsqbrack))) rsqbrack))) rsqbrack))) rsqbrack))) rsqbrack))) rsqbrack))) rsqbrack))) rsqbrack))) rparen) fullstop) (RuleList)) EndMarker))
       )
    (list test21_name test21_input test21_output)))

(provide test22)
(define test22
  (let (
        (test22_name "test22")
        (test22_input '(Atom lparen lsqbrack lsqbrack Var rsqbrack comma lsqbrack lsqbrack Var rsqbrack rsqbrack comma lsqbrack lsqbrack lsqbrack Var rsqbrack rsqbrack rsqbrack comma lsqbrack lsqbrack lsqbrack lsqbrack Var rsqbrack rsqbrack rsqbrack rsqbrack rsqbrack rparen fullstop EndMarker))
        (test22_output '(Prog (RuleList (Rule (Term Atom lparen (TermList (Term (LTerm lsqbrack (TermList (Term (LTerm lsqbrack (TermList (Term Var)) rsqbrack)) comma (TermList (Term (LTerm lsqbrack (TermList (Term (LTerm lsqbrack (TermList (Term Var)) rsqbrack))) rsqbrack)) comma (TermList (Term (LTerm lsqbrack (TermList (Term (LTerm lsqbrack (TermList (Term (LTerm lsqbrack (TermList (Term Var)) rsqbrack))) rsqbrack))) rsqbrack)) comma (TermList (Term (LTerm lsqbrack (TermList (Term (LTerm lsqbrack (TermList (Term (LTerm lsqbrack (TermList (Term (LTerm lsqbrack (TermList (Term Var)) rsqbrack))) rsqbrack))) rsqbrack))) rsqbrack)))))) rsqbrack))) rparen) fullstop) (RuleList)) EndMarker))
       )
    (list test22_name test22_input test22_output)))

(provide test23)
(define test23
  (let (
        (test23_name "test23")
        (test23_input '(Atom lparen lsqbrack rsqbrack comma lsqbrack Var rsqbrack comma lsqbrack Var comma Var comma Var rsqbrack comma lsqbrack Var comma Var vertline Var rsqbrack rparen fullstop EndMarker))
        (test23_output '(Prog (RuleList (Rule (Term Atom lparen (TermList (Term (LTerm lsqbrack rsqbrack)) comma (TermList (Term (LTerm lsqbrack (TermList (Term Var)) rsqbrack)) comma (TermList (Term (LTerm lsqbrack (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rsqbrack)) comma (TermList (Term (LTerm lsqbrack (TermList (Term Var) comma (TermList (Term Var))) vertline (Term Var) rsqbrack)))))) rparen) fullstop) (RuleList)) EndMarker))
       )
    (list test23_name test23_input test23_output)))

(provide test24)
(define test24
  (let (
        (test24_name "test24")
        (test24_input '(Atom lparen lsqbrack Atom comma Atom lparen Var rparen comma Atom lparen Var comma Var rparen comma Atom lparen Var comma Var comma Var rparen vertline Atom lparen Var comma Var comma Var comma Var rparen rsqbrack rparen fullstop EndMarker))
        (test24_output '(Prog (RuleList (Rule (Term Atom lparen (TermList (Term (LTerm lsqbrack (TermList (Term Atom) comma (TermList (Term Atom lparen (TermList (Term Var)) rparen) comma (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen) comma (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen))))) vertline (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var))))) rparen) rsqbrack))) rparen) fullstop) (RuleList)) EndMarker))
       )
    (list test24_name test24_input test24_output)))

(provide test25)
(define test25
  (let (
        (test25_name "test25")
        (test25_input '(lsqbrack rsqbrack fullstop EndMarker))
        (test25_output '(Prog (RuleList (Rule (Term (LTerm lsqbrack rsqbrack)) fullstop) (RuleList)) EndMarker))
       )
    (list test25_name test25_input test25_output)))

(provide test26)
(define test26
  (let (
        (test26_name "test26")
        (test26_input '(lsqbrack Num comma Num comma Num comma Num vertline Num comma Num comma Num comma Num rsqbrack fullstop EndMarker))
        (test26_output '#f)
       )
    (list test26_name test26_input test26_output)))

(provide test27)
(define test27
  (let (
        (test27_name "test27")
        (test27_input '(Atom lparen Atom comma Var comma Var rparen fullstop Atom lparen Atom lparen Var rparen comma Var comma Atom lparen Var rparen rparen colon-minus Atom lparen Var comma Var comma Var rparen fullstop EndMarker))
        (test27_output '(Prog (RuleList (Rule (Term Atom lparen (TermList (Term Atom) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var)) rparen) comma (TermList (Term Var) comma (TermList (Term Atom lparen (TermList (Term Var)) rparen)))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen)))) fullstop) (RuleList))) EndMarker))
       )
    (list test27_name test27_input test27_output)))

(provide test28)
(define test28
  (let (
        (test28_name "test28")
        (test28_input '(Atom lparen Var comma Var comma Var comma Var comma Var comma Var comma Var comma Var rparen colon-minus Var comma Var semicolon Var comma Var semicolon Var comma Var semicolon Var comma Var fullstop EndMarker))
        (test28_output '(Prog (RuleList (Rule (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var))))))))) rparen) colon-minus (OBody (ABody (SBody (Term Var)) comma (ABody (SBody (Term Var)))) semicolon (OBody (ABody (SBody (Term Var)) comma (ABody (SBody (Term Var)))) semicolon (OBody (ABody (SBody (Term Var)) comma (ABody (SBody (Term Var)))) semicolon (OBody (ABody (SBody (Term Var)) comma (ABody (SBody (Term Var)))))))) fullstop) (RuleList)) EndMarker))
       )
    (list test28_name test28_input test28_output)))

(provide test29)
(define test29
  (let (
        (test29_name "test29")
        (test29_input '(Atom lparen Var comma Var comma Var comma Var comma Var comma Var comma Var comma Var rparen colon-minus Var equals Var semicolon Var equals Var semicolon Var equals Var semicolon Var equals Var fullstop EndMarker))
        (test29_output '(Prog (RuleList (Rule (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var))))))))) rparen) colon-minus (OBody (ABody (SBody (Term Var) equals (Term Var))) semicolon (OBody (ABody (SBody (Term Var) equals (Term Var))) semicolon (OBody (ABody (SBody (Term Var) equals (Term Var))) semicolon (OBody (ABody (SBody (Term Var) equals (Term Var))))))) fullstop) (RuleList)) EndMarker))
       )
    (list test29_name test29_input test29_output)))

(provide test30)
(define test30
  (let (
        (test30_name "test30")
        (test30_input '(Atom lparen Var comma Var comma Var comma Var comma Var comma Var comma Var comma Var rparen colon-minus Var comma lparen Var semicolon Var rparen comma lparen Var semicolon Var rparen comma lparen Var semicolon Var rparen comma Var fullstop EndMarker))
        (test30_output '(Prog (RuleList (Rule (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var))))))))) rparen) colon-minus (OBody (ABody (SBody (Term Var)) comma (ABody (SBody lparen (OBody (ABody (SBody (Term Var))) semicolon (OBody (ABody (SBody (Term Var))))) rparen) comma (ABody (SBody lparen (OBody (ABody (SBody (Term Var))) semicolon (OBody (ABody (SBody (Term Var))))) rparen) comma (ABody (SBody lparen (OBody (ABody (SBody (Term Var))) semicolon (OBody (ABody (SBody (Term Var))))) rparen) comma (ABody (SBody (Term Var)))))))) fullstop) (RuleList)) EndMarker))
       )
    (list test30_name test30_input test30_output)))

(provide test31)
(define test31
  (let (
        (test31_name "test31")
        (test31_input '(Atom lparen Var comma Var comma Var comma Var comma Var comma Var comma Var comma Var rparen colon-minus Var equals Var comma Var equals Var semicolon Var equals Var comma Var equals Var fullstop EndMarker))
        (test31_output '(Prog (RuleList (Rule (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var))))))))) rparen) colon-minus (OBody (ABody (SBody (Term Var) equals (Term Var)) comma (ABody (SBody (Term Var) equals (Term Var)))) semicolon (OBody (ABody (SBody (Term Var) equals (Term Var)) comma (ABody (SBody (Term Var) equals (Term Var)))))) fullstop) (RuleList)) EndMarker))
       )
    (list test31_name test31_input test31_output)))

(provide test32)
(define test32
  (let (
        (test32_name "test32")
        (test32_input '(Atom lparen Var comma Var comma Var comma Var comma Var comma Var comma Var comma Var rparen colon-minus Var equals Var comma lparen Var equals Var semicolon Var equals Var rparen comma Var equals Var fullstop EndMarker))
        (test32_output '(Prog (RuleList (Rule (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var))))))))) rparen) colon-minus (OBody (ABody (SBody (Term Var) equals (Term Var)) comma (ABody (SBody lparen (OBody (ABody (SBody (Term Var) equals (Term Var))) semicolon (OBody (ABody (SBody (Term Var) equals (Term Var))))) rparen) comma (ABody (SBody (Term Var) equals (Term Var)))))) fullstop) (RuleList)) EndMarker))
       )
    (list test32_name test32_input test32_output)))

(provide test33)
(define test33
  (let (
        (test33_name "test33")
        (test33_input '(Atom lparen Var comma Var comma Var rparen colon-minus lparen Var equals lsqbrack rsqbrack comma Var equals Var rparen semicolon lparen Var equals lsqbrack rsqbrack comma Var equals Var rparen fullstop Atom lparen lsqbrack Var vertline Var rsqbrack comma lsqbrack Var vertline Var rsqbrack comma lsqbrack Var vertline Var rsqbrack rparen colon-minus lparen Atom lparen Var comma Var rparen comma Var equals Var comma Atom lparen Var comma lsqbrack Var vertline Var rsqbrack comma Var rparen rparen semicolon lparen Atom lparen Var comma Var rparen comma Var equals Var comma Atom lparen lsqbrack Var vertline Var rsqbrack comma Var comma Var rparen rparen fullstop EndMarker))
        (test33_output '(Prog (RuleList (Rule (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen) colon-minus (OBody (ABody (SBody lparen (OBody (ABody (SBody (Term Var) equals (Term (LTerm lsqbrack rsqbrack))) comma (ABody (SBody (Term Var) equals (Term Var))))) rparen)) semicolon (OBody (ABody (SBody lparen (OBody (ABody (SBody (Term Var) equals (Term (LTerm lsqbrack rsqbrack))) comma (ABody (SBody (Term Var) equals (Term Var))))) rparen)))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term (LTerm lsqbrack (TermList (Term Var)) vertline (Term Var) rsqbrack)) comma (TermList (Term (LTerm lsqbrack (TermList (Term Var)) vertline (Term Var) rsqbrack)) comma (TermList (Term (LTerm lsqbrack (TermList (Term Var)) vertline (Term Var) rsqbrack))))) rparen) colon-minus (OBody (ABody (SBody lparen (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody (Term Var) equals (Term Var)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term (LTerm lsqbrack (TermList (Term Var)) vertline (Term Var) rsqbrack)) comma (TermList (Term Var)))) rparen)))))) rparen)) semicolon (OBody (ABody (SBody lparen (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody (Term Var) equals (Term Var)) comma (ABody (SBody (Term Atom lparen (TermList (Term (LTerm lsqbrack (TermList (Term Var)) vertline (Term Var) rsqbrack)) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen)))))) rparen)))) fullstop) (RuleList))) EndMarker))
       )
    (list test33_name test33_input test33_output)))

(provide test34)
(define test34
  (let (
        (test34_name "test34")
        (test34_input '(Atom lparen Var comma Var comma Var comma Var comma Var rparen colon-minus Var equals Var equals Var equals Var equals Var fullstop EndMarker))
        (test34_output '#f)
       )
    (list test34_name test34_input test34_output)))

(provide test35)
(define test35
  (let (
        (test35_name "test35")
        (test35_input '(Atom lparen Var comma Var rparen colon-minus Var equals exclam semicolon exclam equals Var fullstop EndMarker))
        (test35_output '#f)
       )
    (list test35_name test35_input test35_output)))

(provide test98)
(define test98
  (let (
        (test98_name "test98")
        (test98_input '(Atom lparen Var comma Var rparen fullstop Atom lparen Var comma Var rparen colon-minus Atom lparen Atom lparen Var comma Var rparen rparen fullstop Atom lparen Var rparen colon-minus Atom lparen Var rparen comma exclam comma Atom fullstop Atom lparen Var rparen fullstop Atom lparen Var comma Var comma Var rparen colon-minus lparen Var equals lsqbrack rsqbrack comma Var equals Var rparen semicolon lparen Var equals lsqbrack rsqbrack comma Var equals Var rparen fullstop Atom lparen lsqbrack Var vertline Var rsqbrack comma lsqbrack Var vertline Var rsqbrack comma lsqbrack Var vertline Var rsqbrack rparen colon-minus lparen Atom lparen Var comma Var rparen comma Var equals Var comma Atom lparen Var comma lsqbrack Var vertline Var rsqbrack comma Var rparen rparen semicolon lparen Atom lparen Var comma Var rparen comma Var equals Var comma Atom lparen lsqbrack Var vertline Var rsqbrack comma Var comma Var rparen rparen fullstop Atom lparen lsqbrack rsqbrack comma lsqbrack rsqbrack comma lsqbrack rsqbrack rparen fullstop Atom lparen lsqbrack Var vertline Var rsqbrack comma lsqbrack Var vertline Var rsqbrack comma Var rparen colon-minus Atom lparen Var comma Var comma Var rparen fullstop Atom lparen Var comma Var rparen colon-minus Var equals lsqbrack rsqbrack semicolon Var equals lsqbrack Var rsqbrack fullstop Atom lparen lsqbrack Var comma Var vertline Var rsqbrack comma Var rparen colon-minus Atom lparen lsqbrack Var comma Var vertline Var rsqbrack comma Var comma Var rparen comma Atom lparen Var comma Var rparen comma Atom lparen Var comma Var rparen comma Atom lparen Var comma Var comma Var rparen fullstop Atom lparen Atom comma lsqbrack rsqbrack rparen fullstop Atom lparen Atom lparen Var rparen comma lsqbrack Var rsqbrack rparen fullstop Atom lparen Atom lparen Var comma Var rparen comma Var rparen colon-minus Atom lparen Var comma Var comma Var rparen comma Atom lparen Var comma Var rparen comma Atom lparen Var comma Var rparen fullstop Atom lparen Atom lparen Var comma Var rparen comma Var rparen colon-minus Atom lparen Var comma Var rparen semicolon Atom lparen Var comma Var rparen fullstop Atom lparen Atom lparen Var rparen comma Var rparen colon-minus Var equals lsqbrack rsqbrack semicolon Atom lparen Atom lparen Var comma Atom lparen Var rparen rparen comma Var rparen fullstop Atom lparen Atom comma lsqbrack rsqbrack rparen fullstop Atom lparen Atom lparen Var rparen comma lsqbrack Var rsqbrack rparen fullstop Atom lparen Atom lparen Var comma Var rparen comma Var rparen colon-minus Atom lparen Var comma Var comma Var rparen comma Atom lparen Var comma Var rparen comma Atom lparen Var comma Var rparen fullstop Atom lparen Atom lparen Var comma Var rparen comma Var rparen colon-minus Atom lparen Var comma Var rparen semicolon Atom lparen Var comma Var rparen fullstop Atom lparen Atom lparen Var rparen comma Var rparen colon-minus Var equals lsqbrack rsqbrack semicolon Atom lparen Var comma Var comma Var rparen comma Atom lparen Var comma lsqbrack rsqbrack rparen comma Atom lparen Var comma Var rparen comma Atom lparen Atom lparen Var rparen comma Var rparen fullstop Atom lparen Var comma Var rparen colon-minus Atom lparen Var comma Var rparen comma Atom lparen Var comma Var rparen fullstop Atom lparen Atom comma lsqbrack rsqbrack rparen fullstop Atom lparen Atom lparen Var rparen comma lsqbrack Var rsqbrack rparen fullstop Atom lparen Atom lparen Var comma Var rparen comma Var rparen colon-minus Atom lparen Var comma Var comma Var rparen comma Atom lparen Var comma Var rparen comma Atom lparen Var comma Var rparen fullstop Atom lparen Atom lparen Var comma Var rparen comma Var rparen colon-minus Atom lparen Var comma Var rparen semicolon Atom lparen Var comma Var rparen fullstop Atom lparen Atom lparen Var rparen comma Var rparen colon-minus Var equals lsqbrack rsqbrack semicolon Atom lparen Var comma Var comma Var rparen comma Atom lparen Var comma lsqbrack rsqbrack rparen comma Atom lparen Var comma Var rparen comma Atom lparen Atom lparen Var rparen comma Var rparen fullstop Atom lparen Var comma Var rparen colon-minus Atom lparen Var comma Var rparen comma Atom lparen Var comma Var comma lsqbrack rsqbrack rparen fullstop Atom lparen Atom comma Var comma Var rparen fullstop Atom lparen Atom lparen Var rparen comma lsqbrack Var vertline Var rsqbrack comma Var rparen fullstop Atom lparen Atom lparen Var comma Var rparen comma Var comma Var rparen colon-minus Atom lparen Var comma Var comma Var rparen comma Atom lparen Var comma Var comma Var rparen fullstop Atom lparen Atom lparen Var comma Var rparen comma Var comma Var rparen colon-minus Atom lparen Var comma Var comma Var rparen semicolon Atom lparen Var comma Var comma Var rparen fullstop Atom lparen Atom lparen Var rparen comma Var comma Var rparen colon-minus Var equals Var semicolon Atom lparen Var comma Var comma Var rparen comma Atom lparen Var comma Var rparen comma Atom lparen Atom lparen Var rparen comma Var comma Var rparen fullstop Atom lparen Var comma Var rparen colon-minus Atom lparen Var comma Var rparen fullstop Atom lparen Atom rparen fullstop Atom lparen Atom lparen Var comma Var comma Var rparen rparen colon-minus Atom lparen Var rparen comma Atom lparen Var rparen fullstop Atom lparen Atom comma lsqbrack rsqbrack rparen fullstop Atom lparen Atom lparen Var comma Var comma Var rparen comma Var rparen colon-minus Atom lparen Var comma Var rparen comma Atom lparen Var comma Var rparen comma Atom lparen Var comma lsqbrack Var vertline Var rsqbrack comma Var rparen fullstop Atom lparen Var comma Var comma Var rparen colon-minus Atom lparen Var comma Var rparen comma exclam fullstop Atom lparen Var comma Var comma Var rparen colon-minus Atom lparen Var comma Var rparen fullstop Atom lparen Atom comma Num rparen fullstop Atom lparen Atom lparen Var comma Var comma Var rparen comma Var rparen colon-minus Atom lparen Var comma Var rparen comma Atom lparen Var comma Var rparen comma Atom lparen Var comma Var comma Var rparen comma Atom lparen Var comma Atom lparen Var comma Num rparen rparen fullstop Atom lparen Atom comma Atom rparen fullstop Atom lparen Atom lparen Var comma Var comma Var rparen comma Atom lparen Var comma Var comma Var rparen rparen colon-minus Atom lparen Var comma Var rparen comma Atom lparen Var comma Var rparen semicolon Atom lparen Atom lparen Var comma Var rparen rparen comma Atom lparen Var comma Var rparen comma Atom lparen Var comma Var rparen fullstop Atom lparen Var comma Var rparen colon-minus Atom lparen Var rparen fullstop Atom lparen Atom lparen Var comma Var comma Var rparen comma Var rparen colon-minus Atom lparen Var comma Var rparen semicolon Atom lparen Var comma Var rparen fullstop EndMarker))
        (test98_output '(Prog (RuleList (Rule (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) rparen)))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Var)) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var)) rparen)) comma (ABody (SBody exclam) comma (ABody (SBody (Term Atom)))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Var)) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen) colon-minus (OBody (ABody (SBody lparen (OBody (ABody (SBody (Term Var) equals (Term (LTerm lsqbrack rsqbrack))) comma (ABody (SBody (Term Var) equals (Term Var))))) rparen)) semicolon (OBody (ABody (SBody lparen (OBody (ABody (SBody (Term Var) equals (Term (LTerm lsqbrack rsqbrack))) comma (ABody (SBody (Term Var) equals (Term Var))))) rparen)))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term (LTerm lsqbrack (TermList (Term Var)) vertline (Term Var) rsqbrack)) comma (TermList (Term (LTerm lsqbrack (TermList (Term Var)) vertline (Term Var) rsqbrack)) comma (TermList (Term (LTerm lsqbrack (TermList (Term Var)) vertline (Term Var) rsqbrack))))) rparen) colon-minus (OBody (ABody (SBody lparen (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody (Term Var) equals (Term Var)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term (LTerm lsqbrack (TermList (Term Var)) vertline (Term Var) rsqbrack)) comma (TermList (Term Var)))) rparen)))))) rparen)) semicolon (OBody (ABody (SBody lparen (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody (Term Var) equals (Term Var)) comma (ABody (SBody (Term Atom lparen (TermList (Term (LTerm lsqbrack (TermList (Term Var)) vertline (Term Var) rsqbrack)) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen)))))) rparen)))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term (LTerm lsqbrack rsqbrack)) comma (TermList (Term (LTerm lsqbrack rsqbrack)) comma (TermList (Term (LTerm lsqbrack rsqbrack))))) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term (LTerm lsqbrack (TermList (Term Var)) vertline (Term Var) rsqbrack)) comma (TermList (Term (LTerm lsqbrack (TermList (Term Var)) vertline (Term Var) rsqbrack)) comma (TermList (Term Var)))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen)))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Var) equals (Term (LTerm lsqbrack rsqbrack)))) semicolon (OBody (ABody (SBody (Term Var) equals (Term (LTerm lsqbrack (TermList (Term Var)) rsqbrack)))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term (LTerm lsqbrack (TermList (Term Var) comma (TermList (Term Var))) vertline (Term Var) rsqbrack)) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term (LTerm lsqbrack (TermList (Term Var) comma (TermList (Term Var))) vertline (Term Var) rsqbrack)) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen))))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom) comma (TermList (Term (LTerm lsqbrack rsqbrack)))) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var)) rparen) comma (TermList (Term (LTerm lsqbrack (TermList (Term Var)) rsqbrack)))) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen))) semicolon (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var)) rparen) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Var) equals (Term (LTerm lsqbrack rsqbrack)))) semicolon (OBody (ABody (SBody (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Atom lparen (TermList (Term Var)) rparen))) rparen) comma (TermList (Term Var))) rparen))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom) comma (TermList (Term (LTerm lsqbrack rsqbrack)))) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var)) rparen) comma (TermList (Term (LTerm lsqbrack (TermList (Term Var)) rsqbrack)))) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen))) semicolon (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var)) rparen) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Var) equals (Term (LTerm lsqbrack rsqbrack)))) semicolon (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term (LTerm lsqbrack rsqbrack)))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var)) rparen) comma (TermList (Term Var))) rparen)))))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom) comma (TermList (Term (LTerm lsqbrack rsqbrack)))) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var)) rparen) comma (TermList (Term (LTerm lsqbrack (TermList (Term Var)) rsqbrack)))) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen))) semicolon (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var)) rparen) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Var) equals (Term (LTerm lsqbrack rsqbrack)))) semicolon (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term (LTerm lsqbrack rsqbrack)))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var)) rparen) comma (TermList (Term Var))) rparen)))))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term (LTerm lsqbrack rsqbrack))))) rparen))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var)) rparen) comma (TermList (Term (LTerm lsqbrack (TermList (Term Var)) vertline (Term Var) rsqbrack)) comma (TermList (Term Var)))) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen))) semicolon (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var)) rparen) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen) colon-minus (OBody (ABody (SBody (Term Var) equals (Term Var))) semicolon (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var)) rparen) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen))))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom)) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen)) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var)) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var)) rparen))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom) comma (TermList (Term (LTerm lsqbrack rsqbrack)))) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term (LTerm lsqbrack (TermList (Term Var)) vertline (Term Var) rsqbrack)) comma (TermList (Term Var)))) rparen)))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody exclam)))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom) comma (TermList (Term Num))) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Num))) rparen))) rparen))))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom) comma (TermList (Term Atom))) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen) comma (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)))) semicolon (OBody (ABody (SBody (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen))))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var)) rparen)))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen))) semicolon (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen))))) fullstop) (RuleList)))))))))))))))))))))))))))))))))))))))))))))) EndMarker))
       )
    (list test98_name test98_input test98_output)))

(provide test99)
(define test99
  (let (
        (test99_name "test99")
        (test99_input '(Atom lparen Var comma Var rparen fullstop Atom lparen Var comma Var rparen colon-minus Atom lparen Atom lparen Var comma Var rparen rparen fullstop Atom lparen Var rparen colon-minus Atom lparen Var rparen comma exclam comma Atom fullstop Atom lparen Var rparen fullstop Atom lparen lsqbrack rsqbrack comma Var comma Var rparen fullstop Atom lparen Var comma lsqbrack rsqbrack comma Var rparen fullstop Atom lparen lsqbrack Var vertline Var rsqbrack comma lsqbrack Var vertline Var rsqbrack comma lsqbrack Var vertline Var rsqbrack rparen colon-minus Atom lparen Var comma Var rparen comma Atom lparen Var comma lsqbrack Var vertline Var rsqbrack comma Var rparen fullstop Atom lparen lsqbrack Var vertline Var rsqbrack comma lsqbrack Var vertline Var rsqbrack comma lsqbrack Var vertline Var rsqbrack rparen colon-minus Atom lparen Var comma Var rparen comma Atom lparen lsqbrack Var vertline Var rsqbrack comma Var comma Var rparen fullstop Atom lparen lsqbrack rsqbrack comma lsqbrack rsqbrack comma lsqbrack rsqbrack rparen fullstop Atom lparen lsqbrack Var vertline Var rsqbrack comma lsqbrack Var vertline Var rsqbrack comma Var rparen colon-minus Atom lparen Var comma Var comma Var rparen fullstop Atom lparen lsqbrack rsqbrack comma lsqbrack rsqbrack rparen fullstop Atom lparen lsqbrack Var rsqbrack comma lsqbrack Var rsqbrack rparen fullstop Atom lparen lsqbrack Var comma Var vertline Var rsqbrack comma Var rparen colon-minus Atom lparen lsqbrack Var comma Var vertline Var rsqbrack comma Var comma Var rparen comma Atom lparen Var comma Var rparen comma Atom lparen Var comma Var rparen comma Atom lparen Var comma Var comma Var rparen fullstop Atom lparen Atom comma lsqbrack rsqbrack rparen fullstop Atom lparen Atom lparen Var rparen comma lsqbrack Var rsqbrack rparen fullstop Atom lparen Atom lparen Var comma Var rparen comma Var rparen colon-minus Atom lparen Var comma Var comma Var rparen comma Atom lparen Var comma Var rparen comma Atom lparen Var comma Var rparen fullstop Atom lparen Atom lparen Var comma Var rparen comma Var rparen colon-minus Atom lparen Var comma Var rparen fullstop Atom lparen Atom lparen Var comma Var rparen comma Var rparen colon-minus Atom lparen Var comma Var rparen fullstop Atom lparen Atom lparen Var rparen comma lsqbrack rsqbrack rparen fullstop Atom lparen Atom lparen Var rparen comma Var rparen colon-minus Atom lparen Atom lparen Var comma Atom lparen Var rparen rparen comma Var rparen fullstop Atom lparen Atom comma lsqbrack rsqbrack rparen fullstop Atom lparen Atom lparen Var rparen comma lsqbrack Var rsqbrack rparen fullstop Atom lparen Atom lparen Var comma Var rparen comma Var rparen colon-minus Atom lparen Var comma Var comma Var rparen comma Atom lparen Var comma Var rparen comma Atom lparen Var comma Var rparen fullstop Atom lparen Atom lparen Var comma Var rparen comma Var rparen colon-minus Atom lparen Var comma Var rparen fullstop Atom lparen Atom lparen Var comma Var rparen comma Var rparen colon-minus Atom lparen Var comma Var rparen fullstop Atom lparen Atom lparen Var rparen comma lsqbrack rsqbrack rparen fullstop Atom lparen Atom lparen Var rparen comma Var rparen colon-minus Atom lparen Var comma Var comma Var rparen comma Atom lparen Var comma lsqbrack rsqbrack rparen comma Atom lparen Var comma Var rparen comma Atom lparen Atom lparen Var rparen comma Var rparen fullstop Atom lparen Var comma Var rparen colon-minus Atom lparen Var comma Var rparen comma Atom lparen Var comma Var rparen fullstop Atom lparen Atom comma lsqbrack rsqbrack rparen fullstop Atom lparen Atom lparen Var rparen comma lsqbrack Var rsqbrack rparen fullstop Atom lparen Atom lparen Var comma Var rparen comma Var rparen colon-minus Atom lparen Var comma Var comma Var rparen comma Atom lparen Var comma Var rparen comma Atom lparen Var comma Var rparen fullstop Atom lparen Atom lparen Var comma Var rparen comma Var rparen colon-minus Atom lparen Var comma Var rparen fullstop Atom lparen Atom lparen Var comma Var rparen comma Var rparen colon-minus Atom lparen Var comma Var rparen fullstop Atom lparen Atom lparen Var rparen comma lsqbrack rsqbrack rparen fullstop Atom lparen Atom lparen Var rparen comma Var rparen colon-minus Atom lparen Var comma Var comma Var rparen comma Atom lparen Var comma lsqbrack rsqbrack rparen comma Atom lparen Var comma Var rparen comma Atom lparen Atom lparen Var rparen comma Var rparen fullstop Atom lparen Var comma Var rparen colon-minus Atom lparen Var comma Var rparen comma Atom lparen Var comma Var comma lsqbrack rsqbrack rparen fullstop Atom lparen Atom comma Var comma Var rparen fullstop Atom lparen Atom lparen Var rparen comma lsqbrack Var vertline Var rsqbrack comma Var rparen fullstop Atom lparen Atom lparen Var comma Var rparen comma Var comma Var rparen colon-minus Atom lparen Var comma Var comma Var rparen comma Atom lparen Var comma Var comma Var rparen fullstop Atom lparen Atom lparen Var comma Var rparen comma Var comma Var rparen colon-minus Atom lparen Var comma Var comma Var rparen fullstop Atom lparen Atom lparen Var comma Var rparen comma Var comma Var rparen colon-minus Atom lparen Var comma Var comma Var rparen fullstop Atom lparen Atom lparen Var rparen comma Var comma Var rparen fullstop Atom lparen Atom lparen Var rparen comma Var comma Var rparen colon-minus Atom lparen Var comma Var comma Var rparen comma Atom lparen Var comma Var rparen comma Atom lparen Atom lparen Var rparen comma Var comma Var rparen fullstop Atom lparen Var comma Var rparen colon-minus Atom lparen Var comma Var rparen fullstop Atom lparen Atom rparen fullstop Atom lparen Atom lparen Var comma Var comma Var rparen rparen colon-minus Atom lparen Var rparen comma Atom lparen Var rparen fullstop Atom lparen Atom comma lsqbrack rsqbrack rparen fullstop Atom lparen Atom lparen Var comma Var comma Var rparen comma Var rparen colon-minus Atom lparen Var comma Var rparen comma Atom lparen Var comma Var rparen comma Atom lparen Var comma lsqbrack Var vertline Var rsqbrack comma Var rparen fullstop Atom lparen Var comma Var comma Var rparen colon-minus Atom lparen Var comma Var rparen comma exclam fullstop Atom lparen Var comma Var comma Var rparen colon-minus Atom lparen Var comma Var rparen fullstop Atom lparen Atom comma Num rparen fullstop Atom lparen Atom lparen Var comma Var comma Var rparen comma Var rparen colon-minus Atom lparen Var comma Var rparen comma Atom lparen Var comma Var rparen comma Atom lparen Var comma Var comma Var rparen comma Atom lparen Var comma Atom lparen Var comma Num rparen rparen fullstop Atom lparen Atom comma Atom rparen fullstop Atom lparen Atom lparen Var comma Var comma Var rparen comma Atom lparen Var comma Var comma Var rparen rparen colon-minus Atom lparen Var comma Var rparen comma Atom lparen Var comma Var rparen fullstop Atom lparen Atom lparen Var comma Var comma Var rparen comma Atom lparen Var comma Var comma Var rparen rparen colon-minus Atom lparen Atom lparen Var comma Var rparen rparen comma Atom lparen Var comma Var rparen comma Atom lparen Var comma Var rparen fullstop Atom lparen Var comma Var rparen colon-minus Atom lparen Var rparen fullstop Atom lparen Atom lparen Var comma Var comma Var rparen comma Var rparen colon-minus Atom lparen Var comma Var rparen fullstop Atom lparen Atom lparen Var comma Var comma Var rparen comma Var rparen colon-minus Atom lparen Var comma Var rparen fullstop EndMarker))
        (test99_output '(Prog (RuleList (Rule (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) rparen)))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Var)) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var)) rparen)) comma (ABody (SBody exclam) comma (ABody (SBody (Term Atom)))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Var)) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term (LTerm lsqbrack rsqbrack)) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Var) comma (TermList (Term (LTerm lsqbrack rsqbrack)) comma (TermList (Term Var)))) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term (LTerm lsqbrack (TermList (Term Var)) vertline (Term Var) rsqbrack)) comma (TermList (Term (LTerm lsqbrack (TermList (Term Var)) vertline (Term Var) rsqbrack)) comma (TermList (Term (LTerm lsqbrack (TermList (Term Var)) vertline (Term Var) rsqbrack))))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term (LTerm lsqbrack (TermList (Term Var)) vertline (Term Var) rsqbrack)) comma (TermList (Term Var)))) rparen))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term (LTerm lsqbrack (TermList (Term Var)) vertline (Term Var) rsqbrack)) comma (TermList (Term (LTerm lsqbrack (TermList (Term Var)) vertline (Term Var) rsqbrack)) comma (TermList (Term (LTerm lsqbrack (TermList (Term Var)) vertline (Term Var) rsqbrack))))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term (LTerm lsqbrack (TermList (Term Var)) vertline (Term Var) rsqbrack)) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term (LTerm lsqbrack rsqbrack)) comma (TermList (Term (LTerm lsqbrack rsqbrack)) comma (TermList (Term (LTerm lsqbrack rsqbrack))))) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term (LTerm lsqbrack (TermList (Term Var)) vertline (Term Var) rsqbrack)) comma (TermList (Term (LTerm lsqbrack (TermList (Term Var)) vertline (Term Var) rsqbrack)) comma (TermList (Term Var)))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen)))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term (LTerm lsqbrack rsqbrack)) comma (TermList (Term (LTerm lsqbrack rsqbrack)))) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term (LTerm lsqbrack (TermList (Term Var)) rsqbrack)) comma (TermList (Term (LTerm lsqbrack (TermList (Term Var)) rsqbrack)))) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term (LTerm lsqbrack (TermList (Term Var) comma (TermList (Term Var))) vertline (Term Var) rsqbrack)) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term (LTerm lsqbrack (TermList (Term Var) comma (TermList (Term Var))) vertline (Term Var) rsqbrack)) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen))))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom) comma (TermList (Term (LTerm lsqbrack rsqbrack)))) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var)) rparen) comma (TermList (Term (LTerm lsqbrack (TermList (Term Var)) rsqbrack)))) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var)) rparen) comma (TermList (Term (LTerm lsqbrack rsqbrack)))) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var)) rparen) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Atom lparen (TermList (Term Var)) rparen))) rparen) comma (TermList (Term Var))) rparen)))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom) comma (TermList (Term (LTerm lsqbrack rsqbrack)))) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var)) rparen) comma (TermList (Term (LTerm lsqbrack (TermList (Term Var)) rsqbrack)))) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var)) rparen) comma (TermList (Term (LTerm lsqbrack rsqbrack)))) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var)) rparen) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term (LTerm lsqbrack rsqbrack)))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var)) rparen) comma (TermList (Term Var))) rparen))))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom) comma (TermList (Term (LTerm lsqbrack rsqbrack)))) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var)) rparen) comma (TermList (Term (LTerm lsqbrack (TermList (Term Var)) rsqbrack)))) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var)) rparen) comma (TermList (Term (LTerm lsqbrack rsqbrack)))) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var)) rparen) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term (LTerm lsqbrack rsqbrack)))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var)) rparen) comma (TermList (Term Var))) rparen))))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term (LTerm lsqbrack rsqbrack))))) rparen))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var)) rparen) comma (TermList (Term (LTerm lsqbrack (TermList (Term Var)) vertline (Term Var) rsqbrack)) comma (TermList (Term Var)))) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen)))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen)))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var)) rparen) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var)) rparen) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var)) rparen) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen)))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom)) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen)) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var)) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var)) rparen))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom) comma (TermList (Term (LTerm lsqbrack rsqbrack)))) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term (LTerm lsqbrack (TermList (Term Var)) vertline (Term Var) rsqbrack)) comma (TermList (Term Var)))) rparen)))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody exclam)))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom) comma (TermList (Term Num))) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Num))) rparen))) rparen))))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom) comma (TermList (Term Atom))) rparen) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen) comma (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen) comma (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)) comma (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)))))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var)) rparen)))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)))) fullstop) (RuleList (Rule (Term Atom lparen (TermList (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var) comma (TermList (Term Var)))) rparen) comma (TermList (Term Var))) rparen) colon-minus (OBody (ABody (SBody (Term Atom lparen (TermList (Term Var) comma (TermList (Term Var))) rparen)))) fullstop) (RuleList))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) EndMarker))
       )
    (list test99_name test99_input test99_output)))

(define tests
(list
 test01
 test02
 test03
 test04
 test05
 test06
 test07
 test08
 test09
 test10
 test11
 ;test12
 test13
 test14
 test15
 test16
 test17
 test18
 test19
 test20
 test21
 test22
 test23
 test24
 test25
 test26
 test27
 test28
 test29
 test30
 test31
 test32
 test33
 test34
 test35
 test98
 test99
))

(define (run-test test)
  (let ((name (car test))
        (input (cadr test))
        (output (caddr test)))
    (if (equal? (parsePrologProg input) output)
        (display (string-append "Test " name " passed.\n"))
        (display (string-append "Test " name " failed.\n")))))
(define (run-tests) (for-each run-test tests))

(run-tests)

)
