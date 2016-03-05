
;;; Missionaries and cannibals 
;;; 
;;; C        cannibals
;;; M        missionaries with M >= C
;;; B        boat 
;;; LB       left bank
;;; RB       right bank
;;;
;;; example:
;;; initial state MMMCCCB
;;; goal    state BMMMCCC
;;;
;;; constraints: not(C>M) on each bank, boat maximum of two passengers
;;;
;;; valid rules:
;;; LB      RB
;;; C  --> 
;;; CC --> 
;;; M  --> 
;;; MM -->
;;; MC -->


;;;;;;;;;;;;;;;;;;
;;; DEFGLOBALS ;;;
;;;;;;;;;;;;;;;;;;

(defglobal
  ?*mc* = 150
)


;;;;;;;;;;;;;
;;; FACTS ;;;
;;;;;;;;;;;;;

(deffacts states "stati del problema: configuration LB or RB, M, C, B"
  (configuration LB ?*mc* ?*mc* 1)
  (configuration RB 0 0 0)
)
;;;; GOAL --> RB ?*mc* ?*mc* 1


;;;;;;;;;;;;;
;;; RULES ;;;
;;;;;;;;;;;;;

(defrule CtoRB "B C -->"
  ?f<-(configuration LB ?a ?b 1)
  ?g<-(configuration RB ?c ?d 0)
  (test(>= ?b 1))
  (test (or (>= (- ?c ?d) 1) (and (eq ?c 0)(<= ?d 1))))
  =>
  (printout "B(C) --> RB")
  (retract ?f)
  (retract ?g)
  (bind ?x (- ?b 1))
  (bind ?y (+ ?d 1))
  (assert (configuration LB ?a ?x 0 ))
  (assert (configuration RB ?c ?y 1 ))
  (printout " Bank LB: Missionaries=" ?a " Cannibals="?x)
  (printout " Bank RB: Missionaries=" ?c " Cannibals="?y)
)


(defrule CCtoRB "B CC -->"
  (declare (salience 1000))
  ?f<-(configuration LB ?a ?b 1)
  ?g<-(configuration RB ?c ?d 0)
  (test (>= ?b 2))
  (test (or (>= (- ?c ?d) 1) 
            (and (eq ?c 0)(eq ?d 0))))    
  =>
  (printout "B(C,C) --> RB")
  (retract ?f)
  (retract ?g)
  (bind ?x (- ?b 2))
  (bind ?y (+ ?d 2))
  (assert (configuration LB ?a ?x 0 ))
  (assert (configuration RB ?c ?y 1 ))
  (printout " Bank LB: Missionaries=" ?a " Cannibals="?x)
  (printout " Bank RB: Missionaries=" ?c " Cannibals="?y)
)


(defrule MtoRB "B M -->"
  ?f<-(configuration LB ?a ?b 1)
  ?g<-(configuration RB ?c ?d 0)
  (test(>= ?a 1))
  (test (or (<= ?b 1) (>= (- ?a ?b) 1)))
  (test (or (eq ?d 0) (>= (- ?c ?d) -1)))
  =>
  (printout "B(M) --> RB")
  (retract ?f)
  (retract ?g)
  (bind ?x (- ?a 1))
  (bind ?y (+ ?c 1))
  (assert (configuration LB ?x ?b 0 ))
  (assert (configuration RB ?y ?d 1 ))
  (printout " Bank LB: Missionaries=" ?x " Cannibals="?b)
  (printout " Bank RB: Missionaries=" ?y " Cannibals="?d)
)


(defrule MMtoRB "B MM -->"
  (declare (salience 2000))
  ?f<-(configuration LB ?a ?b 1)
  ?g<-(configuration RB ?c ?d 0)
  (test(>=  ?a 2))
  (test (or (<= ?b 2)(>= (- ?a ?b) 2)))
  (test (or (eq ?d 0) (>= (- ?c ?d) -2)))
  =>
  (printout "B(M,M) --> RB")
  (retract ?f)
  (retract ?g)
  (bind ?x (- ?a 2))
  (bind ?y (+ ?c 2))
  (assert (configuration LB ?x ?b 0))
  (assert (configuration RB ?y ?d 1))
  (printout " Bank LB: Missionaries=" ?x " Cannibals="?b)
  (printout " Bank RB: Missionaries=" ?y " Cannibals="?d)
)


(defrule MCtoRB "B MC -->"
  (declare (salience 10))
  ?f<-(configuration LB ?a ?b 1)
  ?g<-(configuration RB ?c ?d 0)
  (test(> ?a 0))
  (test(> ?b 0))
  (test(eq ?a ?b))
  =>
  (printout "B(M,C) --> RB")
  (retract ?f)
  (retract ?g)
  (bind ?z (- ?a 1))
  (bind ?k (- ?b 1))
  (bind ?x (+ ?c 1))
  (bind ?y (+ ?d 1))
  (assert (configuration LB ?z ?k 0))
  (assert (configuration RB ?x ?y 1))
  (printout " Bank LB: Missionaries=" ?z " Cannibals="?k)
  (printout " Bank RB: Missionaries=" ?x " Cannibals="?y)
)


(defrule backEmpty " <-- B "
  ?g<-(configuration RB ?c ?d 1)
  ?f<-(configuration LB ?a ?b 0)
  (test(or (neq ?a 0) (neq ?b 0)))
  =>
  (printout "LB <-- B()")
  (retract ?g)
  (retract ?f)
  (assert(configuration RB ?c ?d  0))
  (assert(configuration LB ?a ?b  1))
)


(defrule stop
  ?f<-(configuration LB 0 0 0)
  ?g<-(configuration RB ?*mc* ?*mc* 1)
  =>
  (printout "GOAL!")
  (retract ?f)
  (retract ?g)
  (assert (configuration RB ?*mc* ?*mc* 1))
  (printout " Bank LB: Missionaries=0" " Cannibals=0")
  (printout " Bank RB: Missionaries=" ?*mc* " Cannibals=" ?*mc*)
  (printout "END")
)
