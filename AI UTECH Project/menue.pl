:- dynamic symptom/1.

symptom(none).

menu:-nl,write('***************Welcome**************'), 
   			nl, write('1. add symptom'),
            nl, write('2, display symptoms'),
            nl, write('3, check symptom'),
    		nl, write('4, perform checkup),
           	nl, write('Enter choice '),nl, read(Ch),
           (Ch == 1 -> getsymptom;
            Ch == 2 -> dspsymptom;
            Ch == 3 -> checksymptom;
            ch == 4 -> perform patient checkup;
           nl,write('bye')).

getsymptom:- nl,write('Enter symptom: '),nl, read(S),
                       (symptom(S) -> nl,write(' Symptom already recorded');
                       assert(symptom(S))),nl,write('Enter another (y/n)'),
                       nl,read(Ans),(Ans == y -> getsymptom;menu).

dspsymptom:- symptom(S),nl,write('A common covid symptom is '),write(S),fail.


checksymptom :- nl,write('Enter your symptom: '),nl, read(S),
                       (symptom(S) -> nl, write(S),
                        write(' is a symptom of covid ');
                        nl, write(S),
                        write(' is not a symptom of covid ')),menu.

