%modulo principal

:-ensure_loaded(diagnostico).
:-ensure_loaded(imc).

:-dynamic(nutricion/2).
:-dynamic(comida/2).

main:-
    inicio,
    problemas([]).

inicio:-
    nl,
    write('\n---------------------------------------------\n'),
    write('Prolog Sistema experto en Calidad Alimentativa'),
    write('\n---------------------------------------------\n'),
    nl.
%hay un problema con los ouputs creo, funcionan bien individualmente
% ok el problema es con main, si problemas([]) tiene una lista vacia da
% problemas, no se porque.
% problemas(Lista) funciona correctamente
problemas(Res):-
    write('Escriba sus síntomas'),nl,
    write('Posibles problemas: desgano - fatiga - irritabilidad - debilidad - etc'),
    nl,
    write('Al finlizar los sintomas escriba "Stop"'),nl,
    leer_problemas(Lista),
    nostring(Lista,Lista2),
    app_nutricion(Lista2,Res),
    print(Res).


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

inv_nutricion(Compuesto,Problema) :-
    nutricion(Problema,Compuesto).
app_nutricion([],[]).
app_nutricion([Compuesto|Compuestos],Problemas):-
    inv_nutricion(Compuesto,Problema),
    app_nutricion(Compuestos,Problemas1),
    Problemas = [Problema|Problemas1].

string_to_nonstring(Listastring,Nein) :-
    read_term_from_atom(Listastring,Nein,[]).
%no se que nombre ponerle
nostring(Listastring,Nostring):-
    maplist(string_to_nonstring,Listastring,Nostring).






