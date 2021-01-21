%GROUP MEMBERS
%Chadan Huggup 1502401
%Rojay White 1400372
%Alexia Grant 1506671
%Nicholas Cameron 1503070
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


alert:- stat(TC,CD),
        %If the system tested 5 or more patients positive for COVID-19 then an alert will be displayed
        CD >=5 -> new(H,dialog('ALERT!')),
        send(H,append,new(Lbl69,label)),send(Lbl69,append,'THERE IS A SPIKE IN PERSONS HAVING OR PRONE TO HAVE COVID-19, System is dialling 119. Please alert other authorities Thank you!'),
        send(H,append,new(Lbl54,label)),send(Lbl54,append,'Number of persons tested today: '),
        send(H,append,new(Lbl33,label)),   send(Lbl33,append,TC),
        send(H,open).

displaystats:- stat(TC,CD),
                TC >=1 -> Percentage is (CD/TC)*100,
                new(F,dialog('Statistics')),
                send(F,append,new(Lbl79,label)),send(Lbl79,append,'Number of persons tested overall: '),
                send(F,append,new(Lbl99,label)),   send(Lbl99,append,TC),

                send(F,append,new(Lbl189,label)),send(Lbl189,append,'Number tested positive for Corona: '),
                send(F,append,new(Lbl57,label)),   send(Lbl57,append,CD),


                send(F,append,new(Lbl87,label)),send(Lbl87,append,'Percentage At Risk or Has COVID-19 :'),
                send(F,append,new(Lbl43,label)),   send(Lbl43,append,Percentage),
                send(F,open);
                new(G,dialog('Statistics')),
                send(G,append,new(Lbl49,label)),send(Lbl49,append,'Please Diagnose atleast 1 Patient before statistics can exist in t                he system!!!! Zero Patients are Diagnosed'),
                send(G,open).


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
    send(D,append,new(Celsius, text_item(celsius))),
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
    send(Celsius, type, int),

    send(D,append,new(Location, text_item(location))),

    send(D,append,button(accept,message(@prolog,save_main,   Name?selection, Fever?selection, Asthma?selection,
                                        Fatigueness?selection, Drycough?selection,
                                        Diabetes?selection , Sex?selection,
                                        Location?selection,   Celsius?selection))),

    send(D,open).


save_main(Name,Fever,Asthma,Fatigueness,Drycough,Diabetes,Sex,Location,Celsius):-

        new(A,dialog('Dianosis of Results')),
        send(A,append,new(Lbl1234,label)),send(Lbl1234,append,'Person Name :'),
        send(A,append,new(Lbl1,label)),   send(Lbl1,append,Name),


        send(A,append,new(Lbl41,label)),send(Lbl41,append,'Gender :'),
        send(A,append,new(Lbl4,label)), send(Lbl4,append,Sex),


        Temperature is (Celsius*(9/5))+32,
        (Temperature >=100.4 -> Tempval is 1; Tempval is 0),
        send(A,append,new(Lbl511,label)), send(Lbl511,append,'Temperature in Fahrenheit : '),
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
        send(A,open),
        alert().


    updatestats(Val):- stat(TC,DC),Newtot is TC + 1, Newhigh is DC + Val,retractall(stat(_,_)),
    assert(stat(Newtot,Newhigh)).

