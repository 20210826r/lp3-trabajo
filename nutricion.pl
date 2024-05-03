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
    write('Posibles problemas: desgano - fatiga - irritabilidad - debilidad-'), nl,
    write('dolor_articular - piel_seca - palidez - falta_de_concentracion'),nl,
    write('calambres_musculares - debilidad_osea - osteoporosis - depresion - ansiedad - problemas_de_memoria \n'),
    write('Al finalizar los sintomas escriba "Stop"'), nl,
    leer_problemas(Lista),
    write('Por favor, ingrese su edad: \n'), read(Edad),
    nostring(Lista, Lista2),
    write('Por favor, ingrese su genero (masculino o femenino): \n'), read(Genero),
    write('Por favor, ingrese su peso (en kilogramos): \n'), read(Peso),
    write('Por favor, ingrese su altura (en metros): \n'), read(Altura),
    (   (Edad >= 3, Edad =< 10) -> Recomendacion = 'frutas, verduras, cereales, carnes, pescados y lacteos';
        (Edad >= 10, Edad =< 18) -> Recomendacion = 'alimentacion completa que tenga en cantidad y calidad los tres grupos del plato del bien comer (frutas y verduras; cereales y tuberculos y leguminosas y alimentos de origen animal)';
        (Edad >= 18, Edad =< 40, Genero = 'masculino') -> Recomendacion = 'leche y sus derivados, carnes, pescado, huevo, cereales, leguminosas y verduras';
        (Edad >= 18, Edad =< 40, Genero = 'femenino') -> Recomendacion = 'carnes, visceras, aves, pescados, vegetales de hoja verde como espinacas, berros y acelgas';
        (Edad >= 40, Edad =< 65) -> Recomendacion = 'lacteos como leche, requeson, quesos frescos, carnes, pescado, jamon, huevos, pollo, pan integral, arroz, leguminosas, frutas y verduras en general';
        Recomendacion = 'No hay recomendacion disponible para esta edad y genero'),
    write('Segun su edad y genero se recomienda consumir: '), write(Recomendacion), nl,
    write('Adicionalmente lo que que podria solucionar sus sintomas: \n'),
    imc(Altura, Peso, IMC),
    clasificar_imc(IMC, Clasificacion),
    app_nutricion(Lista2, Res),
    list_to_set(Res, ResSinRepetidos), % Eliminar duplicados
    imprimir_resultados(ResSinRepetidos),
    write('Su IMC es: '), write(IMC), nl,
    write('Segun su IMC, usted tiene: '), write(Clasificacion).

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

inv_nutricion(Problema, Compuesto) :-
    nutricion(Compuesto, Problema).

app_nutricion([],[]).
app_nutricion([Compuesto | Compuestos], Problemas) :-
    inv_nutricion(Compuesto, Problema),
    app_nutricion(Compuestos, Problemas1),
    Problemas = [Problema | Problemas1].

string_to_nonstring(Lista, Nostring) :-
    read_term_from_atom(Lista, Nostring, []).

nostring(Lista, Nostring) :-
    maplist(string_to_nonstring, Lista, Nostring).

imprimir_resultados([]).
imprimir_resultados([Problema | RestoProblemas]) :-
    alimentos_relacionados(Problema, Alimentos),
    write('Solucion: '), write(Problema), nl,
    write('Alimentos que lo contienen: '), write(Alimentos), nl,
    imprimir_resultados(RestoProblemas).

alimentos_relacionados(Problemas, Alimentos) :-
    findall(Alimento, comida(Alimento, Problemas), Alimentos).

% Predicado para calcular el IMC
imc(Altura, Peso, IMC) :-
    IMC is Peso / (Altura * Altura).

% Predicados para clasificar el IMC
clasificar_imc(IMC, 'Bajo Peso') :- IMC < 18.5.
clasificar_imc(IMC, 'Peso Normal') :- IMC >= 18.5, IMC < 24.9.
clasificar_imc(IMC, 'Sobrepeso') :- IMC >= 25, IMC < 29.9.
clasificar_imc(IMC, 'Obesidad') :- IMC >= 30.




