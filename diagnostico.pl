:-dynamic nutricion/1.
:-dynamic comida/1.
%Las reglas estan todas en una sola file

%Reglas relacion compuesto problema
nutricion(vitamina_B, desgano).
nutricion(vitamina_B, fatiga).
nutricion(vitamina_B, irritabilidad).
nutricion(vitamina_C, debilidad).
nutricion(vitamina_C, dolor_articular).
nutricion(vitamina_C, piel_seca).
nutricion(hierro, fatiga).
nutricion(hierro, palidez).
nutricion(hierro, falta_de_concentracion).
nutricion(calcio, calambres_musculares).
nutricion(calcio, debilidad_osea).
nutricion(calcio, osteoporosis).
nutricion(omega_3, depresion).
nutricion(omega_3, ansiedad).
nutricion(omega_3, problemas_de_memoria).

%Reglas relacion comida compuesto
comida(manzana, vitamina_B).
comida(manzana, vitamina_C).
comida(manzana, fibra).
comida(manzana, antioxidante).
comida(naranja, vitamina_C).
comida(naranja, antioxidante).
comida(platano, potasio).
comida(platano, vitamina_B6).
comida(espinaca, hierro).
comida(espinaca, vitamina_K).
comida(espinaca, vitamina_A).
comida(brocoli, vitamina_C).
comida(brocoli, vitamina_K).
comida(brocoli, fibra).
comida(arandanos, antioxidante).
comida(arandanos, vitamina_C).
comida(arandanos, vitamina_K).
comida(salmon, ocidos_grasos).
comida(salmon, omega_3).
comida(salmon, proteina).
comida(salmon, vitamina_D).
