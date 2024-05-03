% Modulo principal

:- ensure_loaded(diagnostico).
:- ensure_loaded(imc).
:- ensure_loaded(restricciones).

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
    write('Posibles problemas: desgano - fatiga - irritabilidad - debilidad-'), nl,
    write('dolor articular - piel_seca - fatiga - palidez - falta_de_concentracion'),nl,
    write('calambres_musculares - debilidad_osea - osteoporosis - depresion - ansiedad - problemas_de_memoria'),
    write('Al finalizar los sintomas escriba "Stop"'), nl,
    leer_problemas(Lista),
    %leer_genero(Genero),nl, % Agregamos la lectura del genero aqui
    nostring(Lista, Lista2),
    leer_edad(Edad), % Si es necesario, tambien podrias solicitar la edad aqui
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
    repeat,
    verificar_edad(Edad_n).

verificar_edad(Edad_n):-
    write("Ingrese su edad: "),
    read_string(user,"\n","\r",_,Edad),
    catch(number_string(Edad_n,Edad),_,fail),
    !.

leer_genero(Genero):-
    write("Ingrese su genero (masculino/femenino): "),
    read_string(user, "\n", "\r", _, Genero_indf),
    (
      Genero_indf = "masculino";
      Genero_indf == "femenino"
    ),
    !,
    Genero = Genero_indf.

% Luego puedes usar esta informacion para hacer recomendaciones de
% alimentos basadas en el genero.

imprimir_resultados([]).
imprimir_resultados([Problema | RestoProblemas]) :-
    alimentos_relacionados(Problema, Alimentos),
    write('Solucion: '), write(Problema), nl,
    write('Alimentos que lo contienen: '), write(Alimentos), nl,
    imprimir_resultados(RestoProblemas).

alimentos_relacionados(Problemas, Alimentos) :-
    findall(Alimento, comida(Alimento, Problemas), Alimentos).


