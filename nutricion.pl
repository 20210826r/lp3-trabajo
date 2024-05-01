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
    leer_genero(Genero), % Agregamos la lectura del genero aqui
    nostring(Lista, Lista2),
    leer_edad(Edad), % Si es necesario, tambien podrias solicitar la edad aqui
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

app_nutricion([], [], _).
app_nutricion([Compuesto | Compuestos], Problemas, Genero) :-
    inv_nutricion(Compuesto, Problema),
    app_nutricion(Compuestos, Problemas1, Genero),
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
    read_line_to_string(Input,_), % No necesitamos asignar a Edad
    catch(number_string(Edad_n,Input),_,fail).

verificar_edad2(Edad_n):-
    repeat,
    verificar_edad(Edad_n),
    !.

leer_genero(Genero):-
    write("Ingrese su género (masculino/femenino): "),
    read_string(user, "\n", "\r", _, Genero).

% Luego puedes usar esta información para hacer recomendaciones de alimentos basadas en el género.

imprimir_resultados([]).
imprimir_resultados([Problema | RestoProblemas]) :-
    alimentos_relacionados(Problema, Alimentos),
    write('Solución: '), write(Problema), nl,
    write('Alimentos que lo contienen: '), write(Alimentos), nl,
    imprimir_resultados(RestoProblemas).

alimentos_relacionados(Problema, Alimentos) :-
    findall(Alimento, comida(Alimento, Problema), Alimentos).

%app_nutricion([],[]).
%app_nutricion([Problema|Problemas],Compuestos):-
%    inv_nutricion(Problema,Compuesto),
%    app_nutricion(Problemas,Compuestos1),
%    Compuestos = [Compuesto|Compuestos1].