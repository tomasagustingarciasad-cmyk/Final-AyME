clc, close all;
% --- 14. EXTRAER NUEVOS DATOS (CORRIENTES DE FASE NL) ---
paso = 1; % Toma 1 de cada 5 puntos para evitar colapso de memoria gráfica
tiempo_ia_NL  = out.i_a_NL.time(1:paso:end); 
datos_i_a_NL  = out.i_a_NL.signals.values(1:paso:end);
datos_i_b_NL  = out.i_b_NL.signals.values(1:paso:end);
datos_i_c_NL  = out.i_c_NL.signals.values(1:paso:end);

% --- 15. CREAR QUINTA FIGURA (Corrientes NL) ---
figure('Color', 'w');
plot(tiempo_ia_NL, datos_i_a_NL, 'LineWidth', 1.5, 'Color', [0.8500, 0.3250, 0.0980]); hold on; % Rojo optimizado
plot(tiempo_ia_NL, datos_i_b_NL, 'LineWidth', 1.5, 'Color', [0, 0.4470, 0.7410]);             % Azul optimizado
plot(tiempo_ia_NL, datos_i_c_NL, 'LineWidth', 1.5, 'Color', [0.4660, 0.6740, 0.1880]); hold off; % Verde optimizado
grid on; grid minor;
legend('NL / i_a', 'NL / i_b', 'NL / i_c', 'Location', 'northeast', 'FontSize', 10);
xlabel('Tiempo (s)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Corriente [A]', 'FontSize', 16, 'FontWeight', 'bold');
ax13 = gca;
ax13.FontSize = 12; ax13.FontWeight = 'bold'; ax13.GridAlpha = 0.3; ax13.MinorGridAlpha = 0.15;


% --- 14. EXTRAER NUEVOS DATOS (CORRIENTES DE FASE NL) ---
paso = 1; % Toma 1 de cada 5 puntos para evitar colapso de memoria gráfica
tiempo_va_NL  = out.v_a_NL.time(1:paso:end); 
datos_v_a_NL  = out.v_a_NL.signals.values(1:paso:end);
datos_v_b_NL  = out.v_b_NL.signals.values(1:paso:end);
datos_v_c_NL  = out.v_c_NL.signals.values(1:paso:end);

% --- 15. CREAR QUINTA FIGURA (Corrientes NL) ---
figure('Color', 'w');
plot(tiempo_va_NL, datos_v_a_NL, 'LineWidth', 1.5, 'Color', [0.8500, 0.3250, 0.0980]); hold on; % Rojo optimizado
plot(tiempo_va_NL, datos_v_b_NL, 'LineWidth', 1.5, 'Color', [0, 0.4470, 0.7410]);             % Azul optimizado
plot(tiempo_va_NL, datos_v_c_NL, 'LineWidth', 1.5, 'Color', [0.4660, 0.6740, 0.1880]); hold off; % Verde optimizado
grid on; grid minor;
legend('NL / v_a', 'NL / v_b', 'NL / v_c', 'Location', 'northeast', 'FontSize', 10);
xlabel('Tiempo (s)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Tensión [V]', 'FontSize', 16, 'FontWeight', 'bold');
ax14 = gca;
ax14.FontSize = 12; ax14.FontWeight = 'bold'; ax14.GridAlpha = 0.3; ax14.MinorGridAlpha = 0.15;


