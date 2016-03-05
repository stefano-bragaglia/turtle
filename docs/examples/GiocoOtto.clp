(deffacts stato-iniziale
	(obiettivo non-raggiunto)

	(cella 1 1 2)
	(cella 1 2 8)
	(cella 1 3 1)
	(cella 2 1 0)
	(cella 2 2 4)
	(cella 2 3 3)
	(cella 3 1 7)
	(cella 3 2 6)
	(cella 3 3 5)
)

(defrule sposta-vuoto-sinistra
	(obiettivo non-raggiunto)
	?c1 <- (cella ?x ?y 0)
	(test (> ?y 1))
	?c2 <- (cella ?x ?k ?v)
        (test (eq ?k (- ?y 1)))
        =>

	(retract ?c1 ?c2)
	(assert (cella ?x ?k 0))
	(assert (cella ?x ?y ?v))
)

(defrule sposta-vuoto-destra
	(obiettivo non-raggiunto)
	?c1 <- (cella ?x ?y 0)
	(test (< ?y 3))
	?c2 <- (cella ?x ?k ?v)
        (test (eq ?k (+ ?y 1)))
        =>

	(retract ?c1 ?c2)
	(assert (cella ?x ?k 0))
	(assert (cella ?x ?y ?v))
)

(defrule sposta-vuoto-su
	(obiettivo non-raggiunto)
	?c1 <- (cella ?x ?y 0)
	(test (> ?x 1))
	?c2 <- (cella ?k ?y ?v)
        (test (eq ?k (- ?x 1)))
        =>

	(retract ?c1 ?c2)
	(assert (cella ?k ?y 0))
	(assert (cella ?x ?y ?v))
)

(defrule sposta-vuoto-giu
	(obiettivo non-raggiunto)
	?c1 <- (cella ?x ?y 0)
	(test (< ?x 3))
	?c2 <- (cella ?k ?y ?v)
        (test (eq ?k (+ ?x 1)))
        =>

	(retract ?c1 ?c2)
	(assert (cella ?k ?y 0))
	(assert (cella ?x ?y ?v))
)

(defrule termina-gioco
	(declare (salience 10000))
	?ob <- (obiettivo non-raggiunto)
	(cella 1 1 1)
	(cella 1 2 2)
	(cella 1 3 3)
	(cella 2 1 8)
	(cella 2 2 0)
	(cella 2 3 4)
	(cella 3 1 7)
	(cella 3 2 6)
	(cella 3 3 5)
        =>
	(printout "Obiettivo raggiunto!")
	(retract ?ob)
)
