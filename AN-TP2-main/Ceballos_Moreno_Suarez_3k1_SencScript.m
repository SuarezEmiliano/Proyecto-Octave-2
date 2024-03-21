%% Limpiar espacio de trabajo
clc; clear; close all;

%%% Punto 5: Prueba del filtro

%% Parametros (Ver inputs function para ver su definicion):
N1 = 400; Fm = 250; N = 2^10; M = 100; Fc = 15;
% Abcisa secuencial de la señal sin zona muerta
n1 = 0 : (N1-1);
t1 = n1 / Fm;

%% Señales
% Señal sin ruido sin zona muerta
x1 = sin(2*pi*6*t1 + 2) + cos(2*pi*8*t1);
% Ruido sin zona muerta
r = sin(2*pi*25*t1);

%% Obtencion de los resultados
Ceballos_Moreno_Suarez_3k1_SencFunction(Fm, N, N1, M, Fc, t1, x1, r, 'Buenos parametros');

%%% Punto 6: Comparacion de resultados variando Fm, M, Fc
%% Disminuyendo la frecuencia de muestreo
Fm = 150; M = 100; Fc = 15;
n1 = 0 : (N1-1);
t1 = n1 / Fm;
x1 = sin(2*pi*6*t1 + 2) + cos(2*pi*8*t1);
r = sin(2*pi*25*t1);

Ceballos_Moreno_Suarez_3k1_SencFunction(Fm, N, N1, M, Fc, t1, x1, r, 'Disminuyendo Fm');
% Conclusion: Como se sigue respetando el teorema de Nyquist, el muestreo sigue siendo correcto
% Ademas, al dismunuir Fm, aumenta t1 para tener la misma cantidad de muestras

%% Disminuyendo la longitud del nucleo
Fm = 250; M = 16; Fc = 15;
n1 = 0 : (N1-1);
t1 = n1 / Fm;
x1 = sin(2*pi*6*t1 + 2) + cos(2*pi*8*t1);
r = sin(2*pi*25*t1);

Ceballos_Moreno_Suarez_3k1_SencFunction(Fm, N, N1, M, Fc, t1, x1, r, 'Disminuyendo M');
% Conclusion: Al tener tan poca longitud el filtro, se alarga la caida de la
% ventana de analisis, por lo que queda parte del ruido en la salida del sistema

%% Aumentando la frecuencia de corte sobre el ruido
Fm = 250; M = 100; Fc = 30;
n1 = 0 : (N1-1);
t1 = n1 / Fm;
x1 = sin(2*pi*6*t1 + 2) + cos(2*pi*8*t1);
r = sin(2*pi*25*t1);

Ceballos_Moreno_Suarez_3k1_SencFunction(Fm, N, N1, M, Fc, t1, x1, r, 'Aumentando Fc');
% Conclusion: Efectivamente, no elimina el ruido
