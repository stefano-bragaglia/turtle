; Si vuole implementare un sistema a regole per la 
; risoluzione di un problema del mondo dei blocchi.
; Supponiamo di avere la seguente configurazione iniziale
;
;  A  D
;  B  E
;  C  F
;
; e di voler mettere il blocco C su blocco F.
; ********************************************************
   
(defrule sposta "Sposta un blocco libero su un altro blocco libero"
   ?obiettivo <- (obiettivo sposta ?blocco1 sopra-a ?blocco2)
   (blocco ?blocco1)
   (blocco ?blocco2)
   (sopra niente sotto ?blocco1)
   ?pila1 <- (sopra ?blocco1 sotto ?blocco3)
   ?pila2 <- (sopra niente sotto ?blocco2)
   =>
   (retract ?obiettivo)
   (retract ?pila1)
   (retract ?pila2)
   (assert (sopra ?blocco1 sotto ?blocco2))
   (assert (sopra niente sotto ?blocco3))
   (printout "Sposta " ?blocco1 " sopra a " ?blocco2 "."))

(defrule sposta-sul-piano "Sposta un blocco libero sul piano"
   ?obiettivo <- (obiettivo sposta ?blocco1 sopra-a piano)
   (blocco ?blocco1)
   (sopra niente sotto ?blocco1)
   ?pila <- (sopra ?blocco1 sotto ?blocco2)
   =>
   (retract ?obiettivo)
   (retract  ?pila)
   (assert (sopra ?blocco1 sotto piano))
   (assert (sopra niente sotto ?blocco2))
   (printout "Sposta " ?blocco1 " sul piano."))

(defrule libera-blocco-partenza 
	"Stabilisce l'obiettivo di liberare il blocco di partenza"
   (obiettivo sposta ?blocco1 sopra-a ?wild)
   (blocco ?blocco1)
   (sopra ?blocco2 sotto ?blocco1)
   (blocco ?blocco2)
   =>
   (assert (obiettivo sposta ?blocco2 sopra-a piano)))

(defrule libera-blocco-arrivo
	 "Stabilisce l'obiettivo di liberare il blocco d'arrivo"
   (obiettivo sposta ?wildcard sopra-a ?blocco1)
   (blocco ?blocco1)
   (sopra ?blocco2 sotto ?blocco1)
   (blocco ?blocco2)
   =>
   (assert (obiettivo sposta ?blocco2 sopra-a piano)))

(deffacts stato-iniziale "A/B/C, D/E/F, e vogliamo mettere C su F."
   (blocco A)
   (blocco B)
   (blocco C)
   (blocco D)
   (blocco E)
   (blocco F)
   (sopra niente sotto A)
   (sopra A sotto B)
   (sopra B sotto C)
   (sopra C sotto piano)
   (sopra niente sotto D)
   (sopra D sotto E)
   (sopra E sotto F)
   (sopra F sotto piano)
   (obiettivo sposta C sopra-a F))
