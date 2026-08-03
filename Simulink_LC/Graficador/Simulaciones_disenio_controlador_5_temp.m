clc, close all;
% --- 14. EXTRAER NUEVOS DATOS (Velocidad Angular) ---
paso = 1; % Toma 1 de cada 5 puntos para evitar colapso de memoria gráfica
tiempo_simu  = out.T_s_temp.time(1:paso:end); 
datos_temp  = out.T_s_temp.signals.values(1:paso:end);



% --- 15. CREAR QUINTA FIGURA (Temp) ---
figure('Color', 'w');
plot(tiempo_simu, datos_temp, 'LineWidth', 1.5, 'Color', 'r'); % Rojo optimizado
grid on; grid minor;
title('Temperatura de estator', 'FontSize', 18, 'FontWeight', 'bold');
legend('T_s',  'Location', 'northeast', 'FontSize', 10);
xlabel('Tiempo (s)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Temperatura [°C]', 'FontSize', 16, 'FontWeight', 'bold');
ax10 = gca;
ax10.FontSize = 12; ax10.FontWeight = 'bold'; ax10.GridAlpha = 0.3; ax10.MinorGridAlpha = 0.15;