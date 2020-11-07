/* Student: Rojay White
   ID: 1400372 
   Group Project Draft */

/*expert system*/
checkup:-
hypothesis(Disease),
nl,write('Processing....'),nl,
write('System check......patient might have: '),
write(Disease),nl,
nl,write('**********************System Close**********************'),
undo.


/*Hypothesis that should be tested*/
hypothesis(cold) :- cold, !.
hypothesis(flu) :- flu, !.
hypothesis(typhoid) :- typhoid, !.
hypothesis(measles) :- measles, !.
hypothesis(malaria) :- malaria, !.
hypothesis(covid) :- covid, !.
hypothesis(unknown). /* no diagnosis*/

/*Hypothesis Identification Rules*/

covid :-
verify(headache),
verify(fever),
verify(dry_cough),
verify(body_ache),
verify(chest_pain),
verify(shortnes_of_breath),
verify(loss_of_speach_or_movement),

write('Advice and Sugestions: '),nl,
write('Common symptoms of covid'),nl,
nl,write('1: rest'),
nl,write('2: drink plenty of fluid'),
nl,write('3: self isolate'),
nl,write('Please contact Disease specialist Imediately !'),nl.

cold :-
verify(headache),
verify(runny_nose),
verify(sneezing),
verify(sore_throat),
write('Advices and Sugestions:'),nl,
write('1: Tylenol/tab'),
nl,write('2: panadol/tab'),
nl,write('3: Nasal spray'),
nl,write('Please weare warm cloths Because'),nl.

flu :-
verify(fever),
verify(headache),
verify(chills),
verify(body_ache),
write('Advices and Sugestions:'),
nl,write('1: Tamiflu/tab'),
nl,write('2: panadol/tab'),
nl,write('3: Zanamivir/tab'),
nl,write('Please take a warm bath and do salt gargling Because'),nl.

typhoid :-
verify(headache),
verify(abdominal_pain),
verify(poor_appetite),
verify(fever),
write('Advices and Sugestions:'),nl,
write('1: Chloramphenicol/tab'),nl,
write('2: Amoxicillin/tab'),nl,
write('3: Ciprofloxacin/tab'),nl,
write('4: Azithromycin/tab'),nl,
write('Please do complete bed rest and take soft Diet Because'),nl.

measles :-
verify(fever),
verify(runny_nose),
verify(rash),
verify(conjunctivitis),
write('Advices and Sugestions:'),nl,
write('1: Tylenol/tab'),nl,
write('2: Aleve/tab'),nl,
write('3: Advil/tab'),nl,
write('4: Vitamin A'),nl,
write('Please Get rest and use more liquid Because'),nl.

malaria :-
verify(fever),
verify(sweating),
verify(headache),
verify(nausea),
verify(vomiting),
verify(diarrhea),
write('Advices and Sugestions:'),
nl,write('1: Aralen/tab'),
nl,write('2: Qualaquin/tab'),
nl,write('3: Plaquenil/tab'),
nl,write('4: Mefloquine'),
nl,write('Please do not sleep in open air and cover your full skin Because'),nl.

/* how to ask questions */
ask(Question) :-
write('Does the patient have the following symptom/s:'),
write(Question),write('? '),
read(Response),nl,
( (Response == yes ; Response == y)->
/* */
assert(yes(Question)) ; 
assert(no(Question)), fail).
:- dynamic yes/1,no/1.

/*How to verify something */
verify(S) :-
(yes(S)->true ;
(no(S)->fail ;
ask(S))).

/* undo all yes/no assertions*/
undo :- retract(yes(_)),fail.
undo :- retract(no(_)),fail.
undo.
