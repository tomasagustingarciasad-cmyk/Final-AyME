clc, clear, close all;
% CONDICIONES INICIALES %
tita0 = 0;
wm0 = 0;
iq0 = 0;
id0 = 1;
io0 = 0;
Ts0 = 40;


% MODELO DE LA CARGA %
g = 9.80665;                        %m/s^2      Gravedad
b_l = 0.1;%%%%                      %N.m/rad/s  Coeficiente de fricción de la articulación
m = 1;                              %kg         Masa del brazo
L_cm = 0.25;                        %m          Distancia de la articulación al centro de masa del brazo
J_cm=0.0208;                        %kg.m^2     Momento de inercia del brazo
L_l = 0.5;                          %m          Longitud total del brazo
m_l = 0;%%%%                        %kg         Puede variar entre 0 y 1.5kg, masa que recoge el brazo
J_l=(m*(L_cm^2)+J_cm)+m_l*(L_l^2);  %kg.m^2     Momento de inercia total del brazo mas la carga
k_l = m * L_cm + m_l * L_l;         %kg.m       Constante para calcular momento debido al peso del brazo y de la carga
%T_ld = 2.5;  (Ver especificaciones de operación)



% CAJA REDUCTORA %
r = 120/1;                          %Relación de transmisión de la caja reductora



% PARÁMETROS: tolerancia error +/- 1% %
J_m = 14.0*10^-6;                   %kg.m^2   Momento de inercia (motor y caja) 
b_m = 15.0*10^-6;                   %N*m/rad/s   Coef. de fricción viscosa (motor y caja)
P_p = 3;                            %Pares de polos del estator
lambda_m = 0.016;                   %V/rad/s    Flujo magnetico equivalente de imanes concatenado por espiras del bobinado del estator
L_q=5.8 * 10^(-3);                  %H          Inductancia de estator (eje en cuadratura)
L_d = 6.6 * 10^(-3);                %H          Inductancia del estator (eje directo)
L_ls = 0.8 * 10^(-3);               %H          Inductancia de dispersión de estator
T_sREF = 20;
R_sREF=1.02;                        %Ohm        Resistencia de estator por fase a 20ºC (Rs)
alpha_cu=3.9*10^-3;                 %1/ºC       Coeficiente de aumento de la resistencia Rs con T°
C_ts=0.818;                         %W/ºC/s     Capacitancia termica del estator
R_ts_amb=146.7;                     %ºC/W       Resistencia termica entre el estator y el ambiente
tau_ts_amb=R_ts_amb*C_ts;           %s          Constante de tiempo del sistema térmico



% PARAMETROS EQUIVALENTES DEL SISTEMA MOTOR + CAJA + CARGA %
J_eq = J_m + J_l/(r^2);
b_eq = b_m + b_l/(r^2);


% ESPECIFICACIONES DE OPERACIÓN
T_amb = 40;%%%%%%%%%%%              %°C      Rango de temperatura ambiente: −15°𝐶≤𝑇𝑎𝑚𝑏° (𝑡)≤40°C




% Cálculo de Rs a la temperatura inicial (Ts0)
R_s_actual = R_sREF * (1 + alpha_cu * (Ts0 - T_sREF));




% ESPECIFICACIONES DE OPERACIÓN
T_ld = 2.5;  %%%%                   %N.m        Puede variar entre -5 y 5 N.m, torque de carga (Asumir funcion escalon)
nl_nom = 2*pi; %(60 rpm)            %rad/s      Velocidad nominal (salida)
Tq_nom = 17;                        %Nm         Torque nominal (salida)
Tq_max = 45;                        %Nm         Torque pico (salida) (corta duracion, aceleracion)
nm_nom = 691.15;                    %rad/s      Velocidad nominal rotor (6600rpm)
V_sl_nom = 30;                      %V          Tensión nominal de línea
Vflnom = V_sl_nom/sqrt(3);          %V          Tensión nominal de fase
Isnom = 0.4;                        %A          Corriente nominal (regimen continuo)
Ismax = 2;                          %A          Corriente máxima (corta duración)
Tsmax = 115;                        %°C         Tenperatura maxima
%Rango de temperatura ambiente −15°𝐶≤𝑇𝑎𝑚𝑏° (𝑡)≤40°C
Vslmax = 48;                        %V          Módulo de tensión de línea máximo
Vsat = Vslmax * sqrt(2) / sqrt(3);  %V          Limite de saturación
femax = 330;                        %Hz         Frecuencia síncrona máxima (rango de -330 a 330)


% Polos y ceros considerando los valores nominales:

% Orden: s^1, s^0
num = [(L_q), (R_sREF)];

% Coeficientes del denominador: (J_eq*L_q)*s^3 + (L_q*b_eq + J_eq*R_s)*s^2 + (R_s*b_eq + 1.5*P_p^2*lambda_m^2)*s + 0
% Orden: s^3, s^2, s^1, s^0 (Ojo: el término independiente es cero porque se puede extraer factor común s)
den = [(J_eq * L_q), (L_q * b_eq + J_eq * R_sREF), (R_sREF * b_eq + 1.5 * P_p^2 * lambda_m^2), 0];

% Creación de la función de transferencia
H = tf(num, den);

disp("Polos de la función de tranferencia 20°C:");
disp(pole(H));
disp("Ceros de la función de tranferencia 20°C:");
disp(zero(H));
disp('--- Parámetros del Sistema 20° ---');
damp(H); 
% Generación de la figura y gráfica del mapa de polos y ceros
figure;
hold on;
grid on;

% Dibujar ejes primero (así quedan de fondo y no interfieren con la leyenda)
xline(0, '--k', 'LineWidth', 1, 'HandleVisibility', 'off'); % Eje y (Imaginario)
yline(0, '--k', 'LineWidth', 1, 'HandleVisibility', 'off'); % Eje x (Real)

% Dibujar polos del sistema (rojo, cruz)
plot (real(pole(H)), imag(pole(H)), 'rx', 'MarkerSize', 15, 'LineWidth', 2  );
% Dibujar ceros del sistema (azul, círculo)
plot(real(zero(H)), imag(zero(H)), 'bo', 'MarkerSize', 15, 'LineWidth', 2);

title('Mapa de Polos y Ceros en el Plano s ');
xlabel('Eje Real');
ylabel('Eje Imaginario');
legend({'Polos del sistema', 'Ceros del sistema'},'Location','best');
ylim([-160 160]);
axis equal;
hold off;





% =========================================================================
% BARRIDO DE TEMPERATURA Y CÁLCULO DE MIGRACIÓN
% =========================================================================
disp("---------------------------------------------------------------------------------------------------");
disp("---------------------------------------------------------------------------------------------------");
disp("---------------------------------------------------------------------------------------------------");
disp("BARRIDO DE TEMPERATURA Y CÁLCULO DE MIGRACIÓN");
% Rango de temperaturas desde -15°C hasta 115°C (según tus especificaciones)
T_vec = -15:1:115; 

% Inicializar matrices para almacenar los polos y ceros en cada paso
polos_hist = zeros(length(T_vec), 3); % Tu denominador es de orden 3 (3 polos)
ceros_hist = zeros(length(T_vec), 1); % Tu numerador es de orden 1 (1 cero)

for i = 1:length(T_vec)
    T_actual = T_vec(i);
    
    % Calcular la Rs dinámica para la temperatura actual
    R_s_dinamica = R_sREF * (1 + alpha_cu * (T_actual - 20));
    
    
    % Definir numerador y denominador con la Rs variable
    num_i = [L_q, R_s_dinamica];
    den_i = [(J_eq * L_q), (L_q * b_eq + J_eq * R_s_dinamica), (R_s_dinamica * b_eq + 1.5 * P_p^2 * lambda_m^2), 0];
    
    % Crear función de transferencia temporal
    H_i = tf(num_i, den_i);
    
    % Guardar las raíces correspondientes (.') transpone a vector fila
    polos_hist(i, :) = pole(H_i).';
    ceros_hist(i, :) = zero(H_i).';
end

% =========================================================================
% SECCIÓN DE GRAFICACIÓN AVANZADA
% =========================================================================
figure('Color', [1 1 1]);
hold on;
grid on;

% 1. Dibujar ejes cartesianos de fondo
xline(0, '-k', 'LineWidth', 1.2, 'HandleVisibility', 'off'); 
yline(0, '-k', 'LineWidth', 1.2, 'HandleVisibility', 'off');

% 2. Dibujar líneas punteadas negras guía (pasan por debajo de los colores)
for p = 1:3
    plot(real(polos_hist(:, p)), imag(polos_hist(:, p)), 'k--', 'LineWidth', 1.2, 'HandleVisibility', 'off');
end
plot(real(ceros_hist), imag(ceros_hist), 'k--', 'LineWidth', 1.2, 'HandleVisibility', 'off');

% 3. Graficar los puntos coloreados usando SCATTER (mapea color a temperatura)
% Tamaño de los puntos = 40. T_vec define el color dinámico.
for p = 1:3
    scatter(real(polos_hist(:, p)), imag(polos_hist(:, p)), 120, T_vec, 'filled', 'HandleVisibility', 'off');
end
scatter(real(ceros_hist), imag(ceros_hist), 120, T_vec, 'filled', 'HandleVisibility', 'off');

% 4. Dibujar marcador del polo fijo en el origen (0) para la leyenda idéntica
plot(0, 0, 'kx', 'MarkerSize', 20, 'LineWidth', 2.5, 'DisplayName', 'Trayectorias');

% 5. Configurar la Barra de Colores (Colorbar)
cb = colorbar;
% Define el salto aquí. Por ejemplo: de -15 en 15 hasta 115
cb.Ticks = -15:5:115; 

ylabel(cb, 'Temperatura [°C]', 'FontSize', 11);
colormap(jet); % 'jet' o 'turbo' dan el degradado exacto de azul a rojo de tu imagen

% 6. Textos, límites y encuadre estético
title('Migración de Polos y Ceros con la Temperatura', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('Re(s)', 'FontSize', 11);
ylabel('Im(s)', 'FontSize', 11);

xlim([-290, 60]);
ylim([-180, 180]);

axis manual; 
hold off;



%---------------------------------------------------------------------------------------------------
% Orden: s^1, s^0

R_s_15 = R_sREF * (1 + alpha_cu * (-15 - 20));
disp("La resistencia a -15°C es:");
disp(R_s_15);

num15 = [(L_q), (R_s_15)];
% Coeficientes del denominador: 
% Orden: s^3, s^2, s^1, s^0 (Ojo: el término independiente es cero porque se puede extraer factor común s)
den15 = [(J_eq * L_q), (L_q * b_eq + J_eq * R_s_15), (R_s_15 * b_eq + 1.5 * P_p^2 * lambda_m^2), 0];

% Creación de la función de transferencia
H15 = tf(num15, den15);

disp("Polos de la función de tranferencia -15°C:");
disp(pole(H15));
disp("Ceros de la función de tranferencia -15°C:");
disp(zero(H15));
disp('--- Parámetros del Sistema -15° ---');
damp(H15); 
%---------------------------------------------------------------------------------------------------
R_s40 = R_sREF * (1 + alpha_cu * (40 - 20));
disp("La resistencia a 40°C es:");
disp(R_s40);
% Orden: s^1, s^0
num40 = [(L_q), (R_s40)];

% Coeficientes del denominador: (J_eq*L_q)*s^3 + (L_q*b_eq + J_eq*R_s)*s^2 + (R_s*b_eq + 1.5*P_p^2*lambda_m^2)*s + 0
% Orden: s^3, s^2, s^1, s^0 (Ojo: el término independiente es cero porque se puede extraer factor común s)
den40 = [(J_eq * L_q), (L_q * b_eq + J_eq * R_s40), (R_s40 * b_eq + 1.5 * P_p^2 * lambda_m^2), 0];

% Creación de la función de transferencia
H40 = tf(num40, den40);

disp("Polos de la función de tranferencia 40°C:");
disp(pole(H40));
disp("Ceros de la función de tranferencia 40°C:");
disp(zero(H40));
disp('--- Parámetros del Sistema 40° ---');
damp(H40); 

%---------------------------------------------------------------------------------------------------
R_s115 = R_sREF * (1 + alpha_cu * (115 - 20));
disp("La resistencia a 115°C es:");
disp(R_s115);
% Orden: s^1, s^0
num115 = [(L_q), (R_s115)];

% Coeficientes del denominador: (J_eq*L_q)*s^3 + (L_q*b_eq + J_eq*R_s)*s^2 + (R_s*b_eq + 1.5*P_p^2*lambda_m^2)*s + 0
% Orden: s^3, s^2, s^1, s^0 (Ojo: el término independiente es cero porque se puede extraer factor común s)
den115 = [(J_eq * L_q), (L_q * b_eq + J_eq * R_s115), (R_s115 * b_eq + 1.5 * P_p^2 * lambda_m^2), 0];

% Creación de la función de transferencia
H115 = tf(num115, den115);

disp("Polos de la función de tranferencia 115°C:");
disp(pole(H115));
disp("Ceros de la función de tranferencia 115°C:");
disp(zero(H115));
disp('--- Parámetros del Sistema 115° ---');
damp(H115); 
disp("---------------------------------------------------------------------------------------------------");
disp("---------------------------------------------------------------------------------------------------");
disp("---------------------------------------------------------------------------------------------------");
disp("BARRIDO DE COEF DE FRICCIÓN VISCOSA");

b_l_vec = 0.07:0.03:0.13;
polos_b = zeros(length(b_l_vec), 3);
ceros_b = zeros(length(b_l_vec), 1);

for i = 1:length(b_l_vec)
    b_l_actual = b_l_vec(i);
    b_eq_din = b_m + b_l_actual/(r^2);
    
    % Se utiliza R_sREF y J_eq nominales para aislar el efecto de b_eq_din
    num_b = [L_q, R_sREF];
    den_b = [(J_eq * L_q), (L_q * b_eq_din + J_eq * R_sREF), (R_sREF * b_eq_din + 1.5 * P_p^2 * lambda_m^2), 0];
    
    H_b = tf(num_b, den_b);
    polos_b(i, :) = pole(H_b).';
    ceros_b(i, :) = zero(H_b).';


    disp("Parametros de la función de tranferencia de coef de friccion viscosa:");
    disp(b_eq_din);
    damp(H_b);

end

figure('Color', [1 1 1]);
hold on; grid on;
xline(0, '-k', 'LineWidth', 1.2, 'HandleVisibility', 'off'); 
yline(0, '-k', 'LineWidth', 1.2, 'HandleVisibility', 'off');

for p = 1:3
    scatter(real(polos_b(:, p)), imag(polos_b(:, p)), 120, b_l_vec, 'filled', 'HandleVisibility', 'off');
end
scatter(real(ceros_b), imag(ceros_b), 120, b_l_vec, 'filled', 'HandleVisibility', 'off');
plot(0, 0, 'kx', 'MarkerSize', 20, 'LineWidth', 2.5, 'DisplayName', 'Trayectorias');

cb_b = colorbar;
ylabel(cb_b, 'Coef. Friccion b_l [N.m/rad/s]', 'FontSize', 11, 'Interpreter', 'none');
colormap(jet);
title('Migración de Polos y Ceros con b_l', 'FontSize', 12, 'FontWeight', 'bold', 'Interpreter', 'none');
xlabel('Re(s)', 'FontSize', 11); ylabel('Im(s)', 'FontSize', 11);
axis auto;
hold off;


disp("---------------------------------------------------------------------------------------------------");
disp("---------------------------------------------------------------------------------------------------");
disp("---------------------------------------------------------------------------------------------------");
disp("BARRIDO CARGA ÚTIL EN EL EXTREMO");
m_l_vec = 0:0.5:1.5;
polos_m = zeros(length(m_l_vec), 3);
ceros_m = zeros(length(m_l_vec), 1);

for i = 1:length(m_l_vec)
    m_l_actual = m_l_vec(i);
    J_l_din = (m*(L_cm^2)+J_cm) + m_l_actual*(L_l^2);
    J_eq_din = J_m + J_l_din/(r^2);
    
    % Se utiliza R_sREF y b_eq nominales para aislar el efecto de J_eq_din
    num_m = [L_q, R_sREF];
    den_m = [(J_eq_din * L_q), (L_q * b_eq + J_eq_din * R_sREF), (R_sREF * b_eq + 1.5 * P_p^2 * lambda_m^2), 0];
    
    H_m = tf(num_m, den_m);
    polos_m(i, :) = pole(H_m).';
    ceros_m(i, :) = zero(H_m).';
disp("Parametros de la función de tranferencia de masa :");
disp((i-1)*0.5)
disp(J_eq_din);

damp(H_m);

end

figure('Color', [1 1 1]);
hold on; grid on;
xline(0, '-k', 'LineWidth', 1.2, 'HandleVisibility', 'off'); 
yline(0, '-k', 'LineWidth', 1.2, 'HandleVisibility', 'off');

for p = 1:3
    scatter(real(polos_m(:, p)), imag(polos_m(:, p)), 120, m_l_vec, 'filled', 'HandleVisibility', 'off');
end
scatter(real(ceros_m), imag(ceros_m), 120, m_l_vec, 'filled', 'HandleVisibility', 'off');
plot(0, 0, 'kx', 'MarkerSize', 20, 'LineWidth', 2.5, 'DisplayName', 'Trayectorias');

cb_m = colorbar;
ylabel(cb_m, 'Masa m_l [kg]', 'FontSize', 11, 'Interpreter', 'none');
colormap(jet);
title('Migración de Polos y Ceros con m_l', 'FontSize', 12, 'FontWeight', 'bold', 'Interpreter', 'none');
xlabel('Re(s)', 'FontSize', 11); ylabel('Im(s)', 'FontSize', 11);
axis auto;
hold off;
