clc, close all;
% --- 14. EXTRAER NUEVOS DATOS (Velocidad Angular) ---
paso = 1; % Toma 1 de cada 5 puntos para evitar colapso de memoria gráfica
tiempo_simu  = out.q1_consig_escal.time(1:paso:end); 
datos_consigna_ang  = out.q1_consig_escal.signals.values(1:paso:end);
datos_consigna_vel  = out.w_m_consig.signals.values(1:paso:end);
datos_theta_m_sens  = out.theta_m_sens.signals.values(1:paso:end);
datos_wm = out.w_m.signals.values(1:paso:end);
datos_ia = out.i_a.signals.values(1:paso:end);
datos_ib = out.i_b.signals.values(1:paso:end);
datos_ic = out.i_c.signals.values(1:paso:end);
datos_Ts_sens = out.T_s_sens.signals.values(1:paso:end);
datos_Ts_sist = out.T_s_sist.signals.values(1:paso:end);
datos_theta_m_est = out.theta_m_est.signals.values(1:paso:end);
datos_wm_est = out.w_m_est.signals.values(1:paso:end);
datos_va = out.v_a.signals.values(1:paso:end);
datos_vb = out.v_b.signals.values(1:paso:end);
datos_vc = out.v_c.signals.values(1:paso:end);
datos_va1 = out.v_a1.signals.values(1:paso:end);
datos_vb1 = out.v_b1.signals.values(1:paso:end);
datos_vc1 = out.v_c1.signals.values(1:paso:end);
 
% --- 15. CREAR QUINTA FIGURA (Temp) ---
figure('Color', 'w');
plot(tiempo_simu, datos_consigna_ang, 'LineWidth', 1.5, 'Color', 'r'); hold on; % Rojo optimizado
plot(tiempo_simu, datos_theta_m_sens, 'LineWidth', 1.5, 'Color', 'b');hold off;    % Azul optimizado
grid on; grid minor;
title('Respuesta de posición frente a consigna de velocidad con modulador de tensión no ideal', 'FontSize', 18, 'FontWeight', 'bold');
legend('q1^*', 'theta_m sensado', 'Location', 'northeast', 'FontSize', 10);
xlabel('Tiempo (s)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Posición Angular [rad]', 'FontSize', 16, 'FontWeight', 'bold');
ax1 = gca;
ax1.FontSize = 12; ax1.FontWeight = 'bold'; ax1.GridAlpha = 0.3; ax1.MinorGridAlpha = 0.15;





% --- 15. CREAR QUINTA FIGURA (Corrientes NL) ---
figure('Color', 'w');
plot(tiempo_simu, datos_consigna_vel, 'LineWidth', 1.5, 'Color', 'r'); hold on; % Rojo optimizado
plot(tiempo_simu, datos_wm, 'LineWidth', 1.5, 'Color', 'b'); hold off; % Azul
grid on; grid minor;
title('Respuesta de velocidad frente a consigna de velocidad con modulador de tensión no ideal', 'FontSize', 18, 'FontWeight', 'bold');
legend('w_{m}^{*}', 'w_m', 'Location', 'northeast', 'FontSize', 10);
xlabel('Tiempo (s)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Velocidad Angular [rad/s]', 'FontSize', 16, 'FontWeight', 'bold');
ax2 = gca;
ax2.FontSize = 12; ax2.FontWeight = 'bold'; ax2.GridAlpha = 0.3; ax2.MinorGridAlpha = 0.15;


    





% --- 15. CREAR QUINTA FIGURA (Temp) ---
figure('Color', 'w');
plot(tiempo_simu, datos_ia, 'LineWidth', 1.5, 'Color', [0.8500, 0.3250, 0.0980]); hold on; % Rojo optimizado
plot(tiempo_simu, datos_ib, 'LineWidth', 1.5, 'Color', [0, 0.4470, 0.7410]);             % Azul optimizado
plot(tiempo_simu, datos_ic, 'LineWidth', 1.5, 'Color', [0.4660, 0.6740, 0.1880]); hold off; % Verde optimizado
grid on; grid minor;
title('Corrientes de fase sensadas con modulador de tensión no ideal', 'FontSize', 18, 'FontWeight', 'bold');
legend('i_a', 'i_b', 'i_c', 'Location', 'northeast', 'FontSize', 10);
xlabel('Tiempo (s)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Corriente [A]', 'FontSize', 16, 'FontWeight', 'bold');
ax3 = gca;
ax3.FontSize = 12; ax3.FontWeight = 'bold'; ax3.GridAlpha = 0.3; ax3.MinorGridAlpha = 0.15;

figure('Color', 'w');
plot(tiempo_simu, datos_va, 'LineWidth', 1.5, 'Color', [0.8500, 0.3250, 0.0980]); hold on; % Rojo optimizado
plot(tiempo_simu, datos_vb, 'LineWidth', 1.5, 'Color', [0, 0.4470, 0.7410]);             % Azul optimizado
plot(tiempo_simu, datos_vc, 'LineWidth', 1.5, 'Color', [0.4660, 0.6740, 0.1880]); hold off; % Verde optimizado
grid on; grid minor;
title('Tensiones de fase frente a modulador no ideal', 'FontSize', 18, 'FontWeight', 'bold');
legend('v_a', 'v_b', 'v_c', 'Location', 'northeast', 'FontSize', 10);
xlabel('Tiempo (s)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Tensión [V]', 'FontSize', 16, 'FontWeight', 'bold');
ax6 = gca;
ax6.FontSize = 12; ax6.FontWeight = 'bold'; ax6.GridAlpha = 0.3; ax6.MinorGridAlpha = 0.15;




figure('Color', 'w');
plot(tiempo_simu, datos_va1, 'LineWidth', 1.5, 'Color', [0.8500, 0.3250, 0.0980]); hold on; % Rojo optimizado
plot(tiempo_simu, datos_vb1, 'LineWidth', 1.5, 'Color', [0, 0.4470, 0.7410]);             % Azul optimizado
plot(tiempo_simu, datos_vc1, 'LineWidth', 1.5, 'Color', [0.4660, 0.6740, 0.1880]); hold off; % Verde optimizado
grid on; grid minor;
title('Tensiones de fase frente a modulador no ideal previo a la saturación', 'FontSize', 18, 'FontWeight', 'bold');
legend('v_a sin saturación', 'v_b sin saturación', 'v_c sin saturación', 'Location', 'northeast', 'FontSize', 10);
xlabel('Tiempo (s)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Tensión [V]', 'FontSize', 16, 'FontWeight', 'bold');
ax5 = gca;
ax5.FontSize = 12; ax5.FontWeight = 'bold'; ax5.GridAlpha = 0.3; ax5.MinorGridAlpha = 0.15;





figure('Color', 'w');
plot(tiempo_simu, datos_Ts_sist, 'LineWidth', 1.5, 'Color', 'r'); hold on;  % Rojo optimizado
plot(tiempo_simu, datos_Ts_sens, 'LineWidth', 1.5, 'Color', 'b'); hold off;
grid on; grid minor;
title('Temperatura de estator real vs sensada', 'FontSize', 18, 'FontWeight', 'bold');
legend('T_s sistema','T_s sensor', 'Location', 'northeast', 'FontSize', 10);
xlabel('Tiempo (s)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Temperatura [°C]', 'FontSize', 16, 'FontWeight', 'bold');
ax4 = gca;
ax4.FontSize = 12; ax4.FontWeight = 'bold'; ax4.GridAlpha = 0.3; ax4.MinorGridAlpha = 0.15;








