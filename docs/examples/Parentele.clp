;;; Relazioni di parentela

(deffacts famiglia "alcune relazioni date"
  (padre P Q)
  (padre P V)
  (madre K Q)
  (madre K V)
  (sesso V maschio)
  (sesso Q femmina)

  (padre A Q)
  (padre A B)
  (madre C Q)
  (madre C B)
  (sesso B maschio)

  (padre D J)
  (padre D E)
  (madre F J)
  (madre F E)
  (sesso E maschio)

  (padre G J)
  (padre G H)
  (madre I J)
  (madre I H)
  (sesso H maschio)

  (padre L Q)
  (padre L M)
  (madre N Q)
  (madre N M)
  (sesso M maschio)
  
  (padre R P)
  (sesso R maschio)
)


(defrule fratello
  (sesso ?x maschio)
  (padre ?y ?x)
  (madre ?k ?x)    
  (padre ?y ?z)
  (madre ?k ?z)
  (test (neq ?z ?x))
  =>
  (assert (fratello ?z ?x))
)

(defrule sorella
  (sesso ?x femmina)
  (padre ?y ?x)
  (madre ?k ?x)
  (padre ?y ?z)
  (madre ?k ?z)
  (test (neq ?z ?x))
  =>
  (assert (sorella ?z ?x))
)

(defrule nonno
  (sesso ?x maschio)
  (padre ?x ?y)
  (padre ?y ?z)
  =>
  (assert (nonno ?x ?z))
)

(defrule nonna
  (sesso ?x femmina)
  (padre ?x ?y)
  (padre ?y ?z)
  =>
  (assert (nonno ?x ?z))
)

(defrule zio
  (sesso ?x maschio)
  (fratello ?x ?y)
  (padre ?y ?z)
  =>
  (assert (zio ?x ?z))
)

(defrule zio1
  (sesso ?x maschio)
  (fratello ?x ?y)
  (madre ?y ?z)
  =>
  (assert (zio ?x ?z))
)

(defrule zia
  (sesso ?x femmina)
  (sorella ?x ?y)
  (madre ?y ?z)
  =>
  (assert (zia ?x ?z))
)

(defrule zia1
  (sesso ?x femmina)
  (sorella ?x ?y)
  (padre ?y ?z)
  =>
  (assert (zia ?x ?z))
)

(defrule stampa_fratello
  (fratello ?y ?x)
  =>
  (printout  ?y "ha un fratello che si chiama" ?x)
)

(defrule stampa_sorella
  (sorella ?y ?x)
  =>
  (printout  ?y "ha una sorella che si chiama" ?x)
)

(defrule stampa_nonno
  (nonno ?x ?y)
  =>
  (printout  ?x "e' nonno di" ?y)
)

(defrule stampa_nonna
  (nonna ?x ?y)
  =>
  (printout  ?x "e' nonna di" ?y)
)

(defrule stampa_zio
  (zio ?x ?y)
  =>
  (printout  ?x "e' zio di" ?y)
)

(defrule stampa_zia
  (zia ?x ?y)
  =>
  (printout  ?x "e' zia di" ?y)
)

