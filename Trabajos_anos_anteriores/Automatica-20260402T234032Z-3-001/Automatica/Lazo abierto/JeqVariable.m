Parametros;  % Carga los valores de los parámetros

% ----------------- PARÁMETROS PARA ANÁLISIS DE ESTABILIDAD ---------------------
nVal = 10;  % Número de iteraciones (cantidad de valores de Jl)
Jl_vector_suma = linspace(0, 0.375, nVal);  % 10 valores de Jl desde 0 hasta 0.375
Jeq_vector = Jm + ((m * Lcm^2 + Jcm + ml * Ll^2) + Jl_vector_suma) / (r^2);  % Cálculo de Jeq para cada Jl

% Colores para la gráfica de polos y respuestas
colors = lines(nVal);  % Usamos la paleta de colores de MATLAB

% ----------------- GRÁFICO DE POLOS ---------------------
figure;
hold on;
grid on;
title('Diagrama de Polos para distintos J_{eq}');
xlabel('Eje Real');
ylabel('Eje Imaginario');

% ----------------- LOOP PARA ANALIZAR LOS 10 MODELOS ---------------------
for i = 1:nVal
    % Se recalcula la matriz A para cada Jeq distinto
    A = [  0,   1,        0;    
           0, -beq/Jeq_vector(i), KTeq/Jeq_vector(i);    
           0, -KEeq/Lq, -Rs/Lq  ];  

    Bc = [ 0; 0; 1/Lq];
    Bd = [0; -1/Jeq_vector(i); 0];
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
legendStr = arrayfun(@(i) sprintf('J_{eq} = %.3f x 10^-4 ', Jeq_vector(i) * 10^4), 1:nVal, 'UniformOutput', false);
legend(legendStr, 'Location', 'best');

axis equal;
hold off;

% ----------------- RESPUESTA AL ESCALÓN ---------------------
figure;
hold on;
grid on;
title('Respuesta al Escalón para distintos J_{eq}');
xlabel('Tiempo (s)');
ylabel('Salida y(t)');

for i = 1:nVal
    % Se recalcula la matriz A para cada Jeq distinto
    A = [  0,   1,        0;    
           0, -beq/Jeq_vector(i), KTeq/Jeq_vector(i);    
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
title('Respuesta al Impulso para distintos J_{eq}');
xlabel('Tiempo (s)');
ylabel('Salida y(t)');

for i = 1:nVal
    % Se recalcula la matriz A para cada Jeq distinto
    A = [  0,   1,        0;    
           0, -beq/Jeq_vector(i), KTeq/Jeq_vector(i);    
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
