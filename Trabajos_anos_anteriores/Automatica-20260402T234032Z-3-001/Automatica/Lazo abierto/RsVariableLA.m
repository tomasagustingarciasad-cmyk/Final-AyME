Parametros;  % Carga los valores de los parámetros

% ----------------- PARÁMETROS PARA ANÁLISIS DE ESTABILIDAD ---------------------
nVal = 15;  % Cantidad de valores de temperatura
Tsref = 20; % Temperatura de referencia
TsF = linspace(Tsref, Tsmax, nVal);  % Rango de temperatura
Rs_vector = Rs * (1 + alfa * (TsF - Tsref));  % Cálculo de Rs para cada temperatura

% Generar gradiente de colores 
cmap = jet(nVal);  % Mapa de colores

% ----------------- GRÁFICO DE POLOS ---------------------
figure;
hold on;
grid on;
title('Diagrama de Polos para distintos R_s');
xlabel('Eje Real');
ylabel('Eje Imaginario');

% ----------------- LOOP PARA ANALIZAR LOS MODELOS ---------------------
for i = 1:nVal
    % Se recalcula la matriz A para cada Rs distinto
    A = [  0,   1,        0;    
           0, -beq/Jeq, KTeq/Jeq;    
           0, -KEeq/Lq, -Rs_vector(i)/Lq  ];  

    Bc = [ 0; 0; 1/Lq];
    Bd = [0; -1/Jeq; 0];
    C = [1, 0, 0];
    D = 0;

    % Crear sistema en espacio de estados y funciones de transferencia
    sys_tf = tf(ss(A, Bc, C, D));  

    % Cálculo de polos
    poles_C = pole(sys_tf);  % Se obtienen los 3 polos

    % ----------------- GRAFICAR POLOS ---------------------
    plot(real(poles_C), imag(poles_C), 'x', 'Color', cmap(i, :), 'MarkerSize', 10, 'LineWidth', 2);
end

% ----------------- LEYENDA ---------------------
legendStr = arrayfun(@(i) sprintf('R_s = %.3f Ω (%.0f°C)', Rs_vector(i), TsF(i)), 1:nVal, 'UniformOutput', false);
legend(legendStr, 'Location', 'best');

axis equal;
hold off;

% ----------------- RESPUESTA AL ESCALÓN ---------------------
figure;
hold on;
grid on;
title('Respuesta al Escalón para distintos R_s');
xlabel('Tiempo (s)');
ylabel('Salida wm(t)');

for i = 1:nVal
    % Se recalcula la matriz A para cada Rs distinto
    A = [  0,   1,        0;    
           0, -beq/Jeq, KTeq/Jeq;    
           0, -KEeq/Lq, -Rs_vector(i)/Lq  ];  

    Bc = [ 0; 0; 1/Lq];
    C = [0, 1, 0];
    D = 0;

    % Crear sistema de espacio de estados y su función de transferencia
    sys_tf = tf(ss(A, Bc, C, D));  
     
    % Respuesta al escalón
    [y, t] = step(sys_tf);
    plot(t, y, 'Color', cmap(i, :), 'LineWidth', 1.5);
end

legend(legendStr, 'Location', 'best');
hold off;

% ----------------- RESPUESTA AL IMPULSO ---------------------
figure;
hold on;
grid on;
title('Respuesta al Impulso para distintos R_s');
xlabel('Tiempo (s)');
ylabel('Salida wm(t)');

for i = 1:nVal
    % Se recalcula la matriz A para cada Rs distinto
    A = [  0,   1,        0;    
           0, -beq/Jeq, KTeq/Jeq;    
           0, -KEeq/Lq, -Rs_vector(i)/Lq  ];  

    Bc = [ 0; 0; 1/Lq];
    C = [0, 1, 0];
    D = 0;

    % Crear sistema de espacio de estados y su función de transferencia
    sys_tf = tf(ss(A, Bc, C, D));  
    
    % Respuesta al impulso
    [y, t] = impulse(sys_tf);
    plot(t, y, 'Color', cmap(i, :), 'LineWidth', 1.5);
end

legend(legendStr, 'Location', 'best');
hold off;
