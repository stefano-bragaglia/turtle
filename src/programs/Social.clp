
;Una rete  sociale (social  network) consiste di  un gruppo  di persone connesse tra  loro da diversi legami  sociali. Si pensi  ad esempio ad una rete dipartimentale in cui  esiste una relazione fra due individui se si  scambiano email. Le relazioni sono bidirezionali. Come  ipotesi semplificativa si  consideri una rete sociale consistente di k individui connessi tra loro da una sola relazione r. 

;Rappresentare una semplice rete sociale ed individuare il numero dei seguenti motif:
 
; M1) A e' collegato con B, e B e' collegato con C
; M2) A e' collegato con B, B e' collegato con C, e C e' collegato con A
; M3) A, B e C sono collegati tra loro in modo bidirezionale
; M4) A e' collegato con B, e C e' collegato con B



(deffacts network "Una rete di relazioni r tra k individui"
  (r mario anna)
  (r anna mario)
  (r pippo franco)
  (r franco gianni)
  (r gianni pippo)
  (r gianni franco)
  (r pippo gianni)
  (r franco pippo)
)

(defglobal
  ?*m1* = 0
  ?*m2* = 0
  ?*m3* = 0
  ?*m4* = 0
)

(defrule M1
  (r ?a ?b)
  (r ?b ?c)
  (test (neq ?a ?b ?c))
  =>
  (bind ?*m1* (+ ?*m1* 1))
)

(defrule M2
  (r ?a ?b)
  (r ?b ?c)
  (r ?c ?a)
  (test (neq ?a ?b ?c))
  =>
  (bind ?*m2* (+ ?*m2* 1))
)

(defrule M3
  (r ?a ?b)
  (r ?b ?a)
  (r ?b ?c)
  (r ?c ?b)
  (r ?c ?a)
  (r ?a ?c)
  (test (neq ?a ?b ?c))
  =>
  (bind ?*m3* (+ ?*m3* 1))
)

(defrule M4
  (r ?a ?b)
  (r ?c ?b)
  (test (neq ?a ?b ?c))
  =>
  (bind ?*m4* (+ ?*m4* 1))
)


