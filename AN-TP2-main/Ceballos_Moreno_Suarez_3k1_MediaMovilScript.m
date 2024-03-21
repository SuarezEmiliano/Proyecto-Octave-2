%% Limpiar espacio de trabajo
clc; clear; close all;

%filtro de media móvil con promedio centrado.

%Parámetros
Fm= 1000;
N = 2^9;
n = 0 : (N-1);
t = n/Fm;

%CONSIGNA 2
% Definir la señal de entrada
senalentrada = 2 * sin(2*pi*10*t +2) + 4*  cos(2*pi*15*t) + 2;
ruido = 2 * randn(size(t));
senalporfiltrar = senalentrada + ruido;

%Llamo a la funcion de filtro pasandole como parametro la señal por filtrar y la cantidad de impulsos que corresponden al filtro.
senal_suavizada_5 = Ceballos_Moreno_Suarez_3k1_MediaMovilFunction(senalporfiltrar, 5);

% Mostrar la señal original y la señal suavizada
figure;
subplot(4,1,1);
plot(t,senalentrada);
title('Señal original');

subplot(4,1,2);
plot(t,ruido);
title('Ruido');

subplot(4,1,3);
plot(t, senalporfiltrar);
title('Señal con Ruido');

subplot(4,1,4);
plot(t,senal_suavizada_5, 'r', 'DisplayName', 'Señal Filtrada');
title('Filtro de Media Móvil con Promedio Centrado');

%CONSIGNA 3: Aplicamos la funcion de filtro a la misma señal de la consigna dos pero con una distinta cantidad de impulsos.
senal_suavizada_3 = Ceballos_Moreno_Suarez_3k1_MediaMovilFunction(senalporfiltrar,3);
senal_suavizada_7 = Ceballos_Moreno_Suarez_3k1_MediaMovilFunction(senalporfiltrar,7);
senal_suavizada_9 = Ceballos_Moreno_Suarez_3k1_MediaMovilFunction(senalporfiltrar,9);

figure;
subplot(4,1,1);
plot(t,senal_suavizada_3, 'r', 'DisplayName', 'Señal Filtrada');
title('Filtro de Media Móvil con Promedio Centrado con 3 impulsos');

subplot(4,1,2);
plot(t,senal_suavizada_5, 'r', 'DisplayName', 'Señal Filtrada');
title('Filtro de Media Móvil con Promedio Centrado con 5 impulsos');

subplot(4,1,3);
plot(t,senal_suavizada_7, 'r', 'DisplayName', 'Señal Filtrada');
title('Filtro de Media Móvil con Promedio Centrado con 7 impulsos');

subplot(4,1,4);
plot(t,senal_suavizada_9, 'r', 'DisplayName', 'Señal Filtrada');
title('Filtro de Media Móvil con Promedio Centrado con 9 impulsos');


