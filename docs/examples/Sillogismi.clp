;;; Sillogismi

;;; FATTI
(deffacts facts
    (alcuni uomini malvagi)
    (tutti uomini mortali)
)

;;; REGOLE

(defrule r1 "Tutti A sono B, Tutti B sono C => Tutti A sono C"
  (tutti ?a ?b)
  (tutti ?b ?c)
  =>
  (assert (tutti ?a ?c))
  (printout "Tutti" ?a "sono" ?b)
  (printout "Tutti" ?b "sono" ?c)
  (printout "==>")
  (printout "Tutti" ?a "sono" ?c)
)

(defrule r2 "Tutti A sono B, Alcuni A sono C => Tutti C sono B"
  (tutti ?a ?b)
  (alcuni ?a ?c)
  =>
  (assert (tutti ?c ?b))
  (printout "Tutti" ?a "sono" ?b)
  (printout "Alcuni" ?a "sono" ?c)
  (printout "==>")
  (printout "Tutti" ?c "sono" ?b)
)

(defrule r3 "Tutti A sono B, Nessun C e' B => Nessun C e' A"
  (tutti ?a ?b)
  (nessuno ?c ?b)
  =>
  (assert (nessuno ?c ?a))
  (printout "Tutti" ?a "sono" ?b)
  (printout "Nessun" ?c "e'" ?b)
  (printout "==>")
  (printout "Nessun" ?c "e'" ?a)
)

