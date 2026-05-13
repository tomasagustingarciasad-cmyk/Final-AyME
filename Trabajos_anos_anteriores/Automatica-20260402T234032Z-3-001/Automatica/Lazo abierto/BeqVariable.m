Parametros;  % Carga los valores de los parámetros

% ----------------- PARÁMETROS PARA ANÁLISIS DE ESTABILIDAD ---------------------
nVal = 10;  % Número de iteraciones (cantidad de valores de bl)
bl_vector = linspace(0.1 - 0.03, 0.1 + 0.03, nVal);  % 10 valores de bl en su rango de incertidumbre
beq_vector = bm + bl_vector / (r^2);  % Cálculo de beq para cada bl

% Colores para la gráfica de polos y respuestas
colors = lines(nVal);  % Usamos la paleta de colores de MATLAB

% ----------------- GRÁFICO DE POLOS ---------------------
figure;
hold on;
grid on;
title('Diagrama de Polos para distintos b_l');
xlabel('Eje Real');
ylabel('Eje Imaginario');

% ----------------- LOOP PARA ANALIZAR LOS 10 MODELOS ---------------------
for i = 1:nVal
    % Se recalcula la matriz A para cada beq distinto
    A = [  0,   1,        0;    
           0, -beq_vector(i)/Jeq, KTeq/Jeq;    
           0, -KEeq/Lq, -Rs/Lq  ];  

    Bc = [ 0; 0; 1/Lq];
    Bd = [0; -1/Jeq; 0];
    C = [1, 0, 0];
    D = 0;

    % Crear sistema en espacio de estados y funciones de transferencia
    sys_tf = tf(ss(A, Bc, C, D));  

    % Cálculo de polos
    poles_C = pole(sys_tf);  % Se obtienen los 3 polos

    % ----------------- GRAFICAR POLOS ---------------------
    plot(real(poles_C), imag(poles_C), 'x', 'Color', colors(i, :), 'MarkerSize', 10, 'LineWidth', 2);
end

% ----------------- LEYENDA ---------------------
legendStr = arrayfun(@(i) sprintf('b_l = %.3f ', bl_vector(i)), 1:nVal, 'UniformOutput', false);
legend(legendStr, 'Location', 'best');

axis equal;
hold off;

% ----------------- RESPUESTA AL ESCALÓN ---------------------
figure;
hold on;
grid on;
title('Respuesta al Escalón para distintos b_l');
xlabel('Tiempo (s)');
ylabel('Salida y(t)');

for i = 1:nVal
    % Se recalcula la matriz A para cada beq distinto
    A = [  0,   1,        0;    
           0, -beq_vector(i)/Jeq, KTeq/Jeq;    
           0, -KEeq/Lq, -Rs/Lq  ];  

    Bc = [ 0; 0; 1/Lq];
    C = [1, 0, 0];
    D = 0;

    % Crear sistema de espacio de estados y su función de transferencia
    sys_tf = tf(ss(A, Bc, C, D));  
    
    % Respuesta al escalón
    [y, t] = step(sys_tf);
    plot(t, y, 'Color', colors(i, :), 'LineWidth', 1.5);
end

legend(legendStr, 'Location', 'best');
hold off;

% ----------------- RESPUESTA AL IMPULSO ---------------------
figure;
hold on;
grid on;
title('Respuesta al Impulso para distintos b_l');
xlabel('Tiempo (s)');
ylabel('Salida y(t)');

for i = 1:nVal
    % Se recalcula la matriz A para cada beq distinto
    A = [  0,   1,        0;    
           0, -beq_vector(i)/Jeq, KTeq/Jeq;    
           0, -KEeq/Lq, -Rs/Lq  ];  

    Bc = [ 0; 0; 1/Lq];
    C = [1, 0, 0];
    D = 0;

    % Crear sistema de espacio de estados y su función de transferencia
    sys_tf = tf(ss(A, Bc, C, D));  
    
    % Respuesta al impulso
    [y, t] = impulse(sys_tf);
    plot(t, y, 'Color', colors(i, :), 'LineWidth', 1.5);
end

legend(legendStr, 'Location', 'best');
hold off;
