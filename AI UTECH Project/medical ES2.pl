/* Student: Rojay White
   Medical Expert System Draft
   ____________________________________________________________________________________________________________________*/

:- dynamic symptom/1.

symptom(none).

menu:- nl,nl, write('1 => add symptom: '),
            nl, write('2 => display symptoms.'),
            nl, write('3 => check symptom.'),
    		nl, write('4 => do temperature check *C'),
            nl, write('5 => perform checkup.'),
           nl,nl, write('Enter choice: '),nl, read(Ch),
           (Ch == 1 -> getsymptom;
            Ch == 2 -> dspsymptom;
            Ch == 3 -> checksymptom;
            Ch == 4 ->  tempcheck;
            Ch == 5 -> checkup;
           nl,write('bye')).

getsymptom:- nl,write('Enter symptom: '),nl, read(S),
                       (symptom(S) -> nl,write(' Symptom already recorded');
                       assert(symptom(S))),nl,write('Enter another (y/n)'),
                       nl,read(Ans),(Ans == y -> getsymptom;menu).

dspsymptom:- symptom(S),nl,write('A covid symptom is '),write(S),fail.


checksymptom :- nl,write('Enter your symptom: '),nl, read(S),
                       (symptom(S) -> nl, write(S),
                        write(' is a symptom of covid ');
                        nl, write(S),
                        write(' is not a symptom of covid ')),menu.

tempcheck:-
    nl,write(' Enter current temperature *c: '),nl,read(C_Temp),
    F_Temp is (C_Temp * 9//5) + 32,
    write(' temperature: '),write(F_Temp),write('*F'),
    C_Temp >= 38 -> nl,write('patient has a fever !'),menu; nl,write('no fever detected'),nl.



checkup:- analyse(Disease),
          nl,write('Processing....'),nl,
          write('System check......patient has: '),
          write(Disease),nl,
          nl,write('**********************System Close**********************'),
          undo.

          /*Diseases that are tested based on Rules*/
          analyse(flu) :- flu, !.
          analyse(covid) :- covid, !.
		  analyse(unknown).

          /*Disease Rules*/
          covid :-
                verify(headache),
                verify(fever),
                verify(dry_cough),
                verify(body_ache),
                verify(chest_pain),
                verify(shortnes_of_breath),
                verify(loss_of_speach_or_movement),
			write('Advice and Sugestions: '),nl,
            write('Common symptoms of covid.'),nl,
            nl,write('1: get some rest.'),
            nl,write('2: drink plenty of fluids.'),
            nl,write('3: self isolate now.'),
            nl,write('Please contact Disease specialist Imediately !'),nl.
                           
flu :-
    verify(fever),
    verify(headache),
    verify(chills),
    verify(body_ache),
    write('Advices and Sugestions: '),nl,
    write('Common symptoms of a flu.'),nl,
    nl,write('1: Tamiflu/tab'),
    nl,write('2: panadol/tab'),
    nl,write('3: Zanamivir/tab'),
    nl,write('Please take a warm bath and do salt gargling Because'),nl.

/* how to ask a questions during call for checkups */
ask(Question) :-
                write('Does the patient have the following symptom:'),
                write(Question),write('? '),
                read(Response),nl,
                ( (Response == yes ; Response == y)->
                assert(yes(Question)) ;
                assert(no(Question)), fail).
                :- dynamic yes/1,no/1.

/*How to verify */
verify(S) :-
            (yes(S)->true ;
            (no(S)->fail ;
            ask(S))).

/* undo all yes, no assertions*/
undo :- retract(yes(_)),fail.
undo :- retract(no(_)),fail.
undo.

/** <RUN>
?- menu.
*/