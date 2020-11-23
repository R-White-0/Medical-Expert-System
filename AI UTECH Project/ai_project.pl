:- use_module(library(pce)).

:- dynamic stat/2.
:- dynamic high_risk_area/1.

/*for the first part of the the argument, it keeps the statistics of the persons diagnosed
for the second argument, it keeps the persons at risk */
stat(0,0).
high_risk_area(kingston).


%main function
menu:-
    new(M,dialog('Covid 19 Expert System Menu')),send(M,append,new(label)),
    send(M,append,button(add_fact, message(@prolog,addfact))),
    send(M,append,button(diagnose_patient, message(@prolog, mainmenu))),
    send(M,append,button(statistics, message(@prolog,displaystats))),
    send(M,open).


 displaystats:- stat(TC,CD),nl,write('Number of persons tested overall: '),write(TC),nl,
                write('Number tested positive for Corona: '),write(CD),nl,nl,nl.


 addfact:-
    new(X,dialog('Add Location')),send(X,append,new(label)),
    send(X,append,new(Location1, text_item(location1))),
    send(X,append,button(accept,message(@prolog,savelocation,Location1?selection))),
    send(X,open).

%assets high_risk_area fact with location entered as argument
savelocation(C):- assert(high_risk_area(C)),nl,write('Location:'),write(C),write(' added to system knowledge').

%Diagnostics dialog
 mainmenu:-
    new(D,dialog('Diagnostics System')),send(D,append,new(label)),
    send(D,append,new(Name, text_item(name))),
    send(D,append,new(Celcius, text_item(celcius))),
    send(D,append,new(Age, text_item(age))),
    send(D,append,new(Sex, menu(sex,marked))),
    send(D,append,new(Asthma,menu('Have asthma',marked))),
    send(D,append,new(Fatigueness,menu('Easily fatigued',marked))),
    send(D,append,new(Drycough,menu('Have a dry cough',marked))),
    send(D,append,new(Diabetes,menu('Have diabetes',marked))),
    send(D,append,new(Fever,menu('Have fever',marked))),


    send(Asthma, append, yes),   send(Asthma, append, no),
    send(Fatigueness, append, yes),   send(Fatigueness, append, no),
    send(Drycough, append, yes),       send(Drycough, append, no),
    send(Diabetes, append, yes),        send(Diabetes, append, no),
    send(Fever, append, yes),      send(Fever, append, no),
    send(Sex, append, female),       send(Sex, append, male),

    send(Age, type, int),
    send(Celcius, type, int),

    send(D,append,new(Location, text_item(location))),

    send(D,append,button(accept,message(@prolog,save_main,   Name?selection, Fever?selection, Asthma?selection,
                                        Fatigueness?selection, Drycough?selection,
                                        Diabetes?selection , Sex?selection,
                                        Location?selection,   Celcius?selection))),

    send(D,open).


save_main(Name,Fever,Asthma,Fatigueness,Drycough,Diabetes,Sex,Location,Celcius):-

        new(A,dialog('Dianosis of Results')),
        send(A,append,new(Lbl1234,label)),send(Lbl1234,append,'Person Name :'),
        send(A,append,new(Lbl1,label)),   send(Lbl1,append,Name),


        send(A,append,new(Lbl41,label)),send(Lbl41,append,'Gender :'),
        send(A,append,new(Lbl4,label)), send(Lbl4,append,Sex),


        Temperature is (Celcius*(9/5))+32,
        (Temperature >=100.4 -> Tempval is 1; Tempval is 0),
        send(A,append,new(Lbl511,label)), send(Lbl511,append,'Temperature in farenheit : '),
        send(A,append,new(Lbl512,label)), send(Lbl512,append,Temperature),

        (Fever == 'yes' -> Fevervalue is 1;Fevervalue is 0),

        (Asthma == 'yes' -> Asthmavalue is 1;Asthmavalue is 0),

        (Fatigueness==  'yes' -> Fatiguevalue is 1;Fatiguevalue is 0),

        (Drycough == 'yes' ->   Drycoughvalue is 1; Drycoughvalue is 0),

        (Diabetes == 'yes' -> Diabetesvalue is 1; Diabetesvalue is 0),

         %If area recorded is a risk area intialize Areavalue to 1
        (high_risk_area(Location) -> Locationvalue is 1;Locationvalue is 0),

        %Add risk values
        Covid_19 is Fevervalue+Asthmavalue+Fatiguevalue+Drycoughvalue+Diabetesvalue+Tempval+Locationvalue,

        %If total risk value >= 3 patient at risk
        send(A,append,new(Lbl15,label)),
        (Covid_19  >= 3 -> send(Lbl15,append,'!!! You are at risk of Covid-19'),
        send(Lbl15,append,'\n\nShort term action: quarantine'),
        send(Lbl15,append,'\nLong term action: Medicine, Rest, Observation, Re-test'),
        send(Lbl15,append,'\n\nPossible actions for MOH: Maintain this persons anominity, Handle them carefully not to contract virus from them, locate and test their family members'),
        Rval is 1;
        send(Lbl15,append,'Fortunately, you are not at risk for the Corona virus'),
        send(Lbl15,append,'\n\nNo action required by MOH'),Rval is 0),
        updatestats(Rval),
        send(A,open).


    updatestats(Val):- stat(TC,DC),Newtot is TC + 1, Newhigh is DC + Val,retractall(stat(_,_)),
    assert(stat(Newtot,Newhigh)).
