%modulo principal

:-ensure_loaded(diagnostico).
:-ensure_loaded(imc).

:-dynamic(nutricion/2).
:-dynamic(sintoma/2).

main:-
    inicio,
    problemas([]).


inicio:-
    nl,
    write('\n---------------------------------------------\n'),
    write('Prolog Sistema experto en Calidad Alimentativa'),
    write('\n---------------------------------------------\n'),
    nl.

problemas(Problemas):-
    write('Escriba sus síntomas'),nl,
    write('Posibles problemas: desgano - fatiga - irritabilidad - debilidad - etc'),
    nl,
    write('Al finlizar los sintomas escriba "Stop"'),nl,
    retractall(nutricion(_,Problemas)),
    leer_problemas(Lista),
    forall(member(X,Lista),assertz(nutricion(_,X))),
    write(Lista),
    nutricion(_,Problemas).

leer_problemas(Problemas):-
    write('Ingrese su problema: \n'),
    read_string(user,"\n","\r",_,Respuesta),
    (
    Respuesta == "Stop"
        ->
        Problemas = []
        ;
        leer_problemas(Problemas1),
        Problemas = [Respuesta|Problemas1]
    ).





