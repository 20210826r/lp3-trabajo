%modulo principal

:-ensure_loaded(diagnostico).
:-ensure_loaded(imc).

:-dynamic(nutricion/2).
:-dynamic(comida/2).

main:-
    inicio,
    problemas.

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
problemas:-
    write('Escriba sus síntomas'),nl,
    write('Posibles problemas: desgano - fatiga - irritabilidad - debilidad - etc'),
    nl,
    write('Al finalizar los síntomas escriba "Stop"'),nl,
    leer_problemas(Lista),
    nostring(Lista,Lista2),
    app_nutricion(Lista2,Res1),
    app_comida(Res1,Res2),
    write(Res2).



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
%Para hallar los compuestos que faltan y causan el problema
inv_nutricion(Problema,Compuesto) :-
    nutricion(Compuesto,Problema).
app_nutricion([],[]).
app_nutricion([Problema|Problemas],Compuestos):-
    inv_nutricion(Problema,Compuesto),
    app_nutricion(Problemas,Compuestos1),
    Compuestos = [Compuesto|Compuestos1].
%Para hallar las comidas que tienen el compuesto
inv_comida(Compuesto,Comida):-
    comida(Comida,Compuesto).
app_comida([],[]).
app_comida([Compuesto|Compuestos],Comidas):-
    inv_comida(Compuesto,Comida),
    app_comida(Compuestos,Comidas1),
    Comidas = [Comida|Comidas1].

string_to_nonstring(Listastring,Nein) :-
    read_term_from_atom(Listastring,Nein,[]).
%no se que nombre ponerle
nostring(Listastring,Nostring):-
    maplist(string_to_nonstring,Listastring,Nostring).






