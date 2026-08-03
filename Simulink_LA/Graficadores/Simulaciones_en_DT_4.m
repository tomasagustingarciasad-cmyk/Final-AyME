clc, close all;
% --- 14. EXTRAER NUEVOS DATOS (CORRIENTES DE FASE NL) ---
paso = 1; % Toma 1 de cada 5 puntos para evitar colapso de memoria gráfica
tiempo_vq_NL  = out.v_q_NL.time(1:paso:end); 
datos_v_q_NL  = out.v_q_NL.signals.values(1:paso:end);
datos_v_d_NL  = out.v_d_NL.signals.values(1:paso:end);
datos_v_0_NL  = out.v_0_NL.signals.values(1:paso:end);

% --- 15. CREAR QUINTA FIGURA (Corrientes NL) ---
figure('Color', 'w');
plot(tiempo_vq_NL, datos_v_q_NL, 'LineWidth', 1.5, 'Color', [0.8500, 0.3250, 0.0980]); hold on; % Rojo optimizado
plot(tiempo_vq_NL, datos_v_d_NL, 'LineWidth', 1.5, 'Color', [0, 0.4470, 0.7410]);             % Azul optimizado
plot(tiempo_vq_NL, datos_v_0_NL, 'LineWidth', 1.5, 'Color', [0.4660, 0.6740, 0.1880]); hold off; % Verde optimizado
grid on; grid minor;
legend('NL / v_q', 'NL / v_d', 'NL / v_0', 'Location', 'northeast', 'FontSize', 10);
xlabel('Tiempo (s)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Tensión [V]', 'FontSize', 16, 'FontWeight', 'bold');
ax15 = gca;
ax15.FontSize = 12; ax15.FontWeight = 'bold'; ax15.GridAlpha = 0.3; ax15.MinorGridAlpha = 0.15;
