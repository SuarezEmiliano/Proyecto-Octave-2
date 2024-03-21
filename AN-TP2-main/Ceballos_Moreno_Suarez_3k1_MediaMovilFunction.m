

function retval = Ceballos_Moreno_Suarez_3k1_MediaMovilFunction (senal, cant_impulsos)
%filtro de media móvil con promedio centrado.
% Definir la señal de entrada

n = length(senal); % Longitud de la señal

% Dada la cantidad de impulsos que comprenden a la ventana definimos cuantos impulsos debe haber en cada lado del punto central que es el que va a
%ir cambiando al recorrer la señal
ventana = (cant_impulsos - 1) / 2;

% Inicializar un arreglo para la señal resultante del filtro
senal_filtrada = zeros(1, n);

% Aplicar el filtro
%Recorremos cada punto de la señal
for i = 1:n
    % Si i (la posición actual en la señal) es menor que ventana + 1 entonces estamos en los primeros puntos de la señal
    %y no hay suficientes puntos a la izquierda para calcular un promedio centrado.
    if i < ventana + 1;
        %Cuando estamos en los primeros puntos de la señal puede no haber suficientes puntos a la izquierda para calcular un promedio centrado, por ello
        %se establece ventana_izquierda de manera que la ventana de cálculo incluye sólo los puntos disponibles en ese lado. Por su parte
        %la ventana_derecha se define para que incluya todos los puntos a la derecha que hagan falta según el valor de ventana.
        ventana_lado_izquierdo = i - 1;
        ventana_lado_derecho = ventana;

    % Si i (la posición actual en la señal) es mayor que la diferencia entre la longitud total de la señal (n) y el tamaño de ventana
    %entonces estamos en los últimos puntos de la señal, y no hay suficientes puntos a la derecha para calcular un promedio centrado.
    elseif i > n - ventana
        %%la ventana_derecha se define para que incluya todos los puntos a la izquierda que hagan falta según el valor de ventana.
        %ventana_derecha se establece en n - i, que es la cantidad de puntos restantes a la derecha del punto actual y que son los que podemos tomar en el promedio.
        ventana_lado_izquierdo = ventana;
        ventana_lado_derecho = n - i;
    else
        % En otros casos, hay suficientes puntos a ambos lados por los que se toman los que hacen falta.
        ventana_lado_izquierdo = ventana;
        ventana_lado_derecho = ventana;
    end

        % Calcular el promedio centrado
        ventana_actual = senal(i - ventana_lado_izquierdo : i + ventana_lado_derecho);
        senal_filtrada(i) = mean(ventana_actual);
end
retval = senal_filtrada;
endfunction
