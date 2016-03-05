;;; Problema dei missionari
;;; 
;;; C        Numero di cannibali
;;; M        Numero dei missionari
;;; B        Posizione della barca (B=0 se è la barca non è sulla riva considerata; B=1 altrimenti.)
;;; LB       Riva sinistra
;;; RB       Riva destra
;;;
;;; Vincoli:
;;; - Il numero dei cannibali su ogni riva non deve superare il numero dei missionari.
;;; - La barca può trasportare al massimo due passeggeri alla volta.
;;;
;;; Regole valide:
;;; LB      RB
;;; C  --> 
;;; CC --> 
;;; M  --> 
;;; MM -->
;;; MC -->

;;;;;;;;;;;;;;;;;;
;;; DEFGLOBALS ;;;
;;;;;;;;;;;;;;;;;;

;;; ?*m* = Numero di missionari.
;;; ?*c* = Numero di cannibali.

(defglobal
  ?*m* = 50
  ?*c* = 30
)

;;;;;;;;;;;;;
;;; FACTS ;;;
;;;;;;;;;;;;;

(deffacts states "stati del problema: configuration LB or RB, M, C, B"
  (configuration LB ?*m* ?*c* 1)
  (configuration RB 0 0 0)
)

;;;;;;;;;;;;;
;;; RULES ;;;
;;;;;;;;;;;;;

(defrule CtoRB "B C -->"
  ?f<-(configuration LB ?a ?b 1)
  ?g<-(configuration RB ?c ?d 0)
  (test(>= ?b 1))
  (test (>= (- ?c ?d) 1))
  =>
  (retract ?f)
  (retract ?g)
  (bind ?x (- ?b 1))
  (bind ?y (+ ?d 1))
  (assert (configuration LB ?a ?x 0 ))
  (assert (configuration RB ?c ?y 1 ))
)


(defrule CCtoRB "B CC -->"
  ?f<-(configuration LB ?a ?b 1)
  ?g<-(configuration RB ?c ?d 0)
  (test (>= ?b 2))
  (test (>= (- ?c ?d) 1))    
  =>
  (retract ?f)
  (retract ?g)
  (bind ?x (- ?b 2))
  (bind ?y (+ ?d 2))
  (assert (configuration LB ?a ?x 0 ))
  (assert (configuration RB ?c ?y 1 ))
)


(defrule MtoRB "B M -->"
  ?f<-(configuration LB ?a ?b 1)
  ?g<-(configuration RB ?c ?d 0)
  (test(>= ?a 1))
  (test (>= (- ?a ?b) 1))
  (test (or (eq ?d 0) (>= (- ?c ?d) -1)))
  =>
  (retract ?f)
  (retract ?g)
  (bind ?x (- ?a 1))
  (bind ?y (+ ?c 1))
  (assert (configuration LB ?x ?b 0 ))
  (assert (configuration RB ?y ?d 1 ))
)


(defrule MMtoRB "B MM -->"
  ?f<-(configuration LB ?a ?b 1)
  ?g<-(configuration RB ?c ?d 0)
  (test(>=  ?a 2))
  (test (or (<= ?b 2)(>= (- ?a ?b) 2)))
  (test (or (eq ?d 0) (>= (- ?c ?d) -2)))
  =>
  (retract ?f)
  (retract ?g)
  (bind ?x (- ?a 2))
  (bind ?y (+ ?c 2))
  (assert (configuration LB ?x ?b 0))
  (assert (configuration RB ?y ?d 1))
)


(defrule MCtoRB "B MC -->"
  ?f<-(configuration LB ?a ?b 1)
  ?g<-(configuration RB ?c ?d 0)
  (test(> ?a 0))
  (test(> ?b 0))
  (test(eq ?a ?b))
  =>
  (retract ?f)
  (retract ?g)
  (bind ?z (- ?a 1))
  (bind ?k (- ?b 1))
  (bind ?x (+ ?c 1))
  (bind ?y (+ ?d 1))
  (assert (configuration LB ?z ?k 0))
  (assert (configuration RB ?x ?y 1))
)


(defrule backEmpty " <-- B "
  ?g<-(configuration RB ?c ?d 1)
  ?f<-(configuration LB ?a ?b 0)
  (test(or (neq ?a 0) (neq ?b 0)))
  =>

  (retract ?g)
  (retract ?f)
  (assert(configuration RB ?c ?d  0))
  (assert(configuration LB ?a ?b  1))
)


(defrule stop
  ?f<-(configuration LB 0 0 0)
  ?g<-(configuration RB ?*m* ?*c* 1)
  =>
  (retract ?f)
  (retract ?g)
  (assert (configuration RB ?*m* ?*c* 1))
)
