%%%% Punto 4: Filtro Senc

%%% Inputs:
%% Parametros:
% Fm: Frecuencia de muestreo. Debe satisfacer el teorema de Nyquist (Fm >= 2 Fmax)
% N: Periodo (señal + zona muerta). Debe ser una potencia de 2
% N1: Cantidad de elementos se la señal sin zona muerta. N1 < N
% M: Elementos de h - 1, es decir la longitud del nucleo. h tendra M + 1 elementos. Debe ser par
% Fc: Frecuencia de corte analogica, es decir la longitud de la ventana de analisis. Mayor a la frecuencia maxima de la señal y menor  a la frecuencia del ruido
% t1: Abcisa en tiempo de la señal sin zona muerta
%% Señales:
% xr: Señal sin ruido sin zona muerta
% r: Ruido sin zona muerta
%% Graficos:
% tit: Titulo ventana

function Ceballos_Moreno_Suarez_3k1_SencFunction (Fm, N, N1, M, Fc, t1, x1, r, tit)
  
  
  % Abcisa secuencial de la señal con zona muerta
  n = 0 : (N-1);
  % Abcisa en tiempo de la señal con zona muerta
  t = n / Fm;
  % Abcisa secuencial de h sin zona muerta
  n2 = 0 : M;
  % Abcisa en tiempo de h sin zona muerta
  t2 = n2 / Fm;
  % Frecuencia de corte
  fc = Fc / Fm;
  % Abcisa en frecuencia de las transformadas
  F = Fm / N * n;
  
  %% Señales:
  % Señal con ruido sin zona muerta
  x1r = x1 + r;
  % Señal en la zona muerta
  a1 = zeros(1,(N - N1));
  % Señal con ruido con zona muerta
  xr = [x1r, a1];
  
  %% Rta al impulso h
  % Numerador de h (Senc desplazado) sin zona muerta
  a2 = sin(2*pi*fc*( n2 - (M/2)));
  % Denominador de h (Senc desplazado) sin zona muerta
  b2 = pi * (n2 - (M/2));
  % h (Senc desplazado). En M/2 + 1 habrá una division por 0, la cual corresponde
  % al pico del senc, cuyo valor es 2*fc. Sin zona muerta
  h1 = a2 ./b2;
  h1(M/2 + 1) = 2*fc;
  % Funcion de ventana. Hay que trasponer, porque hamming da un vector columna
  v = hamming(M+1)';
  % h (ventanado). Sin zona muerta
  h2 = h1 .* v;
  % h (normalizado). Sin zona muerta
  h3 = h2 / sum(h2);
  % h en la zona muerta
  a3 = zeros(1,(N - M - 1));
  % h con zona muerta (definitivo)
  h = [h3,a3];
  
  %% Salida del sistema
  % Se debe tomar una parte de la salida por haber calculado las convoluciones con la zona muerta y con h desplazado
  % Por teorema de convolucion
  Xr = fft(xr);
  H = fft(h);
  Y = Xr .* H;
  y = ifft(Y);
  yd = y((M/2 + 1) : (M/2 + N1));
  % Por convolucion de octave
  y1 = conv(xr, h);
  yd1 = y1((M/2 + 1) : (M/2 + N1));
  % Por convolucion propia
  y2 = Ceballos_Moreno_Suarez_3k1_Conv(xr, h);
  yd2 = y1((M/2 + 1) : (M/2 + N1));
  
  %% Graficos
  figure();
  % 
  set(gcf, 'name', tit);
  % Señal de entrada con y sin ruido
  subplot(4,3,1);
  plot(t1,x1);
  title('Señal de entrada sin ruido: sen(2π6t + 2) + cos(2π8t)');
  xlabel('t[s]');
  ylabel('x(t)');

  subplot(4,3,2);
  plot(t1,r);
  title('Ruido: sen(2π25t)');
  xlabel('t[s]');
  ylabel('r(t)');

  subplot(4,3,3);
  plot(t1,x1r);
  title('Señal de entrada con ruido: x(t) + r(t)');
  xlabel('t[s]');
  ylabel('xr(t)');


  % Ventana de Hamming y nucleo del filtro
  subplot(4,2,3);
  plot(t2,v);
  title('Ventana de hamming');
  xlabel('t[s]');
  ylabel('v(t)');

  subplot(4,2,4);
  plot(t2,h3);
  title('Nucleo del filtro');
  xlabel('t[s]');
  ylabel('h(t)');


  % Modulos de los espectros. Al mostrar el modulo se debe usar abs()
  subplot(4,3,7);
  plot(F,abs(Xr));
  title('Espectro de la señal con ruido');
  xlabel('f[Hz]');
  ylabel('Xr(f)');

  subplot(4,3,8);
  plot(F,abs(H));
  title('Espectro de la rta al impulso');
  xlabel('f[Hz]');
  ylabel('H(f)');

  subplot(4,3,9);
  plot(F,abs(Y));
  title('Espectro de la salida del sistema');
  xlabel('f[Hz]');
  ylabel('Y(f)');


  % Señales filtradas. Por la posibilidad de que quede una parte imaginaria, se usa real(). Se espera que las 3 sean iguales
  subplot(4,3,10);
  plot(t1, real(yd));
  title('Salida del sistema (Por teorema de convolucion)');
  xlabel('t[s]');
  ylabel('y1(s)');

  subplot(4,3,11);
  plot(t1, real(yd1));
  title('Salida del sistema (Por convolucion de Octave)');
  xlabel('t[s]');
  ylabel('y2(s)');

  subplot(4,3,12);
  plot(t1, real(yd2));
  title('Salida del sistema (Por convolucion propia)');
  xlabel('t[s]');
  ylabel('y3(s)');

endfunction
