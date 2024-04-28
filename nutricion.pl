
%modulo principal

:-ensure_loaded(diagnostico).

%Predicado para hacer la consulta del IMC
diagnosticar_imc :-
    writeln('Ingrese su altura en metros: '),
    read(Altura),
    writeln('Ingrese su peso en kilogramos: '),
    read(Peso),
    calcular_imc(Altura, Peso, IMC),
    IMC_redondeado is round(IMC * 100) / 100, % Redondear a dos decimales
    write('Su IMC es de '), write(IMC_redondeado), writeln(''),
    interpretar_imc(IMC_redondeado, Mensaje),
    write(Mensaje).

% Predicado para interpretar el IMC
interpretar_imc(IMC, 'Tiene bajo peso') :-
    IMC < 18.5.
interpretar_imc(IMC, 'Se encuentra en el peso normal') :-
    IMC >= 18.5,
    IMC < 25.
interpretar_imc(IMC, 'Usted tiene sobrepeso') :-
    IMC >= 25,
    IMC < 30.
interpretar_imc(IMC, 'Usted presenta obesidad') :-
    IMC >= 30.

% Predicado para calcular el IMC
calcular_imc(Altura, Peso, IMC) :-
    IMC is Peso / (Altura * Altura).


