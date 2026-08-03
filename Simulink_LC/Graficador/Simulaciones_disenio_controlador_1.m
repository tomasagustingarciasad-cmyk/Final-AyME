clc, close all;
% --- 14. EXTRAER NUEVOS DATOS (Velocidad Angular) ---
paso = 1; % Toma 1 de cada 5 puntos para evitar colapso de memoria gráfica
tiempo_simu  = out.err_Rs_Var.time(1:paso:end); 
datos_erro_var  = out.err_Rs_Var.signals.values(1:paso:end);

% --- 15. CREAR QUINTA FIGURA (Corrientes NL) ---
figure('Color', 'w');
plot(tiempo_simu, datos_erro_var, 'LineWidth', 1.5, 'Color', 'r');% Rojo optimizad
grid on; grid minor;
title('Error de seguimiento de corriente con R_s variable compensada', 'FontSize', 18, 'FontWeight', 'bold');
legend('Error R_s variable', 'Location', 'northeast', 'FontSize', 10);
xlabel('Tiempo (s)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Error ', 'FontSize', 16, 'FontWeight', 'bold');
ax1 = gca;
ax1.FontSize = 12; ax1.FontWeight = 'bold'; ax1.GridAlpha = 0.3; ax1.MinorGridAlpha = 0.15;



% --- 14. EXTRAER NUEVOS DATOS (Torque) ---
paso = 1; % Toma 1 de cada 5 puntos para evitar colapso de memoria gráfica
datos_erro_cte  = out.err_Rs_Cte.signals.values(1:paso:end);

% --- 15. CREAR QUINTA FIGURA (Corrientes NL) ---
figure('Color', 'w');
plot(tiempo_simu, datos_erro_cte, 'LineWidth', 1.5, 'Color', 'r'); % Rojo optimizad
grid on; grid minor;
title('Error de seguimiento de corriente con R_s constante', 'FontSize', 18, 'FontWeight', 'bold');
legend('Error R_s constante', 'Location', 'northeast', 'FontSize', 10);
xlabel('Tiempo (s)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Error ', 'FontSize', 16, 'FontWeight', 'bold');
ax1 = gca;
ax1.FontSize = 12; ax1.FontWeight = 'bold'; ax1.GridAlpha = 0.3; ax1.MinorGridAlpha = 0.15;