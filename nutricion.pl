% Modulo principal

:- ensure_loaded(diagnostico).
:- ensure_loaded(imc).

:- dynamic(nutricion/2).
:- dynamic(comida/2).

main :-
    inicio,
    problemas.

inicio :-
    nl,
    write('\n----------------------------------------------\n'),
    write('Prolog Sistema Experto en Calidad Alimentativa'),
    write('\n----------------------------------------------\n'),
    nl.

problemas :-
    write('Escriba sus sintomas'), nl,
    write('Posibles problemas: desgano - fatiga - irritabilidad - debilidad - etc'), nl,
    write('Al finalizar los sintomas escriba "Stop"'), nl,
    leer_problemas(Lista),
    nostring(Lista, Lista2),
    %Implementacion de la edad
    leer_edad(Edad),
    write(Edad),
    app_nutricion(Lista2, Res),
    imprimir_resultados(Res).

leer_problemas(Problemas) :-
    write('Ingrese su problema: \n'),
    read_string(user, "\n", "\r", _, Respuesta),
    (
        Respuesta == "Stop" ->
        Problemas = []
    ;
        leer_problemas(Problemas1),
        Problemas = [Respuesta | Problemas1]
    ).

inv_nutricion(Compuesto, Problema) :-
    nutricion(Problema, Compuesto).

app_nutricion([],[]).
app_nutricion([Compuesto | Compuestos], Problemas) :-
    inv_nutricion(Compuesto, Problema),
    app_nutricion(Compuestos, Problemas1),
    Problemas = [Problema | Problemas1].

string_to_nonstring(Lista, Nostring) :-
    read_term_from_atom(Lista, Nostring, []).

nostring(Lista, Nostring) :-
    maplist(string_to_nonstring, Lista, Nostring).

leer_edad(Edad_n):-
    verificar_edad(Edad_n),
    verificar_edad2(Edad_n).

verificar_edad(Edad_n):-
    write("Ingrese su edad: "),
    read_string(user,"\n","\r","_",Input),
    read_line_to_string(Input,Edad), %Pasar el input a string
    catch(number_string(Edad_n,Edad),_,fail). % Convertir el string a numerico
    %catch(:Goal, +ExceptionTerm, :RecoveryGoal)
    %Goal es converitir Edad a numerico
    %No se especifico un Catch
    %si no se puede convertir la funcion da resultado fallo
verificar_edad2(Edad_n):-
    repeat,
    verificar_edad(Edad_n),
    !.%Si se da un resultado correcto corta la funcion


imprimir_resultados([]).
imprimir_resultados([Problema | RestoProblemas]) :-
    alimentos_relacionados(Problema, Alimentos),
    write('Solucion: '), write(Problema), nl,
    write('Alimentos que lo contienen: '), write(Alimentos), nl,
    imprimir_resultados(RestoProblemas).

alimentos_relacionados(Problema, Alimentos) :-
    findall(Alimento, comida(Alimento, Problema), Alimentos).

%app_nutricion([],[]).
%app_nutricion([Problema|Problemas],Compuestos):-
%    inv_nutricion(Problema,Compuesto),
%    app_nutricion(Problemas,Compuestos1),
%    Compuestos = [Compuesto|Compuestos1].

