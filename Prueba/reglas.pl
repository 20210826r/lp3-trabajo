:- consult('hechos.pl').

% Predicado para calcular el IMC
imc(Altura, Peso, IMC) :-
    IMC is Peso / (Altura * Altura).

% Predicados para clasificar el IMC
clasificar_imc(IMC, 'Bajo Peso') :- IMC < 18.5.
clasificar_imc(IMC, 'Peso Normal') :- IMC >= 18.5, IMC < 24.9.
clasificar_imc(IMC, 'Sobrepeso') :- IMC >= 25, IMC < 29.9.
clasificar_imc(IMC, 'Obesidad') :- IMC >= 30.

% Predicado para recomendar alimentos según la edad y el género
recomendar_alimentos :-
    write('Por favor, ingrese su edad: '), read(Edad),
    write('Por favor, ingrese su genero (masculino o femenino): '), read(Genero),
    write('Por favor, ingrese su sintoma (desgano, fatiga, irritabilidad, debilidad, etc.): '), read(Sintoma),
    write('Por favor, ingrese su peso (en kilogramos): '), read(Peso),
    write('Por favor, ingrese su altura (en metros): '), read(Altura),
    nutricion(Nutriente, Sintoma),
    (   (Edad >= 3, Edad =< 10) -> Recomendacion = 'frutas, verduras, cereales, carnes, pescados y lacteos';
        (Edad >= 10, Edad =< 18) -> Recomendacion = 'alimentacion completa que tenga en cantidad y calidad los tres grupos del plato del bien comer (frutas y verduras; cereales y tuberculos y leguminosas y alimentos de origen animal)';
        (Edad >= 18, Edad =< 40, Genero = 'masculino') -> Recomendacion = 'leche y sus derivados, carnes, pescado, huevo, cereales, leguminosas y verduras';
        (Edad >= 18, Edad =< 40, Genero = 'femenino') -> Recomendacion = 'carnes, visceras, aves, pescados, vegetales de hoja verde como espinacas, berros y acelgas';
        (Edad >= 40, Edad =< 65) -> Recomendacion = 'lacteos como leche, requeson, quesos frescos, carnes, pescado, jamon, huevos, pollo, pan integral, arroz, leguminosas, frutas y verduras en general';
        Recomendacion = 'No hay recomendacion disponible para esta edad y genero'),
    write('Segun su edad, genero y sintoma, se recomienda consumir: '), write(Recomendacion), nl,
    imc(Altura, Peso, IMC),
    write('Su IMC es: '), write(IMC), nl,
    clasificar_imc(IMC, Clasificacion),
    write('Segun su IMC, usted tiene: '), write(Clasificacion), nl.

% Ejemplo de uso:
% recomendar_alimentos.
