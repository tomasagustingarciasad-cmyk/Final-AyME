clc, close all;
% --- 14. EXTRAER NUEVOS DATOS (Velocidad Angular) ---
paso = 1; % Toma 1 de cada 5 puntos para evitar colapso de memoria gráfica
tiempo_simu  = out.q1_consig_escal.time(1:paso:end); 
datos_consigna_ang  = out.q1_consig_escal.signals.values(1:paso:end);
datos_consigna_vel  = out.w_m_consig.signals.values(1:paso:end);
datos_theta_m  = out.theta_m.signals.values(1:paso:end);
datos_error = out.err_theta.signals.values(1:paso:end);
datos_wm = out.w_m.signals.values(1:paso:end);
datos_Tm = out.T_m.signals.values(1:paso:end);
datos_ia = out.i_a.signals.values(1:paso:end);
datos_ib = out.i_b.signals.values(1:paso:end);
datos_ic = out.i_c.signals.values(1:paso:end);
datos_va = out.v_a.signals.values(1:paso:end);
datos_vb = out.v_b.signals.values(1:paso:end);
datos_vc = out.v_c.signals.values(1:paso:end);
datos_Ts = out.T_s.signals.values(1:paso:end);
datos_theta_m_est = out.theta_m_est.signals.values(1:paso:end);
datos_wm_est = out.w_m_est.signals.values(1:paso:end);
datos_T_ld = out.T_ld.signals.values(1:paso:end);
datos_Tm_consig = out.T_m_consig.signals.values(1:paso:end);

 
% --- 15. CREAR QUINTA FIGURA (Corrientes NL) ---
figure('Color', 'w');
plot(tiempo_simu, datos_consigna_vel, 'LineWidth', 1.5, 'Color', 'r'); hold on; % Rojo optimizado
plot(tiempo_simu, datos_wm_est, 'LineWidth', 1.5, 'Color', [0.85, 0.65, 0.13]);
plot(tiempo_simu, datos_wm, 'LineWidth', 1.5, 'Color', 'b'); hold off; % Azul
grid on; grid minor;
title('Consigna de velocidad angular vs rta vs velocidad estimada', 'FontSize', 18, 'FontWeight', 'bold');
legend('w_{m}^{*}', ' w_{m}^~','w_m', 'Location', 'northeast', 'FontSize', 10);
xlabel('Tiempo (s)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Velocidad Angular [rad/s]', 'FontSize', 16, 'FontWeight', 'bold');
ax1 = gca;
ax1.FontSize = 12; ax1.FontWeight = 'bold'; ax1.GridAlpha = 0.3; ax1.MinorGridAlpha = 0.15;
%-----------------------------------------------------------------------------------------------------

% --- 15. CREAR QUINTA FIGURA (Temp) ---
figure('Color', 'w');
plot(tiempo_simu, datos_consigna_ang, 'LineWidth', 1.5, 'Color', 'r'); hold on; % Rojo optimizado
plot(tiempo_simu, datos_theta_m, 'LineWidth', 1.5, 'Color', 'b');             % Azul optimizado
%plot(tiempo_simu, datos_theta_m_est, 'LineWidth', 1.5, 'Color', [0.85, 0.65, 0.13]); hold off; % Amarillo mostasa
grid on; grid minor;
title('Respuesta de posición frente a consigna de velocidad angular', 'FontSize', 18, 'FontWeight', 'bold');
legend('q1^*', 'theta_m', 'Location', 'northeast', 'FontSize', 10);
xlabel('Tiempo (s)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Posición Angular [rad]', 'FontSize', 16, 'FontWeight', 'bold');
ax7 = gca;
ax7.FontSize = 12; ax7.FontWeight = 'bold'; ax7.GridAlpha = 0.3; ax7.MinorGridAlpha = 0.15;


% --- 15. CREAR QUINTA FIGURA (Temp) ---
figure('Color', 'w');
plot(tiempo_simu, datos_Tm_consig, 'LineWidth', 1.5, 'Color', 'r'); hold on; % Rojo optimizado
plot(tiempo_simu, datos_Tm, 'LineWidth', 1.5, 'Color', 'b'); hold off; % Blue
grid on; grid minor;
title('Respuesta de torque a consigna de velocidad', 'FontSize', 18, 'FontWeight', 'bold');
legend('T_{m}^*', 'T_{ld}', 'Location', 'northeast', 'FontSize', 10);
xlabel('Tiempo (s)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Torque [N.m]', 'FontSize', 16, 'FontWeight', 'bold');
ax9 = gca;
ax9.FontSize = 12; ax9.FontWeight = 'bold'; ax9.GridAlpha = 0.3; ax9.MinorGridAlpha = 0.15;



% --- 15. CREAR QUINTA FIGURA (Temp) ---
figure('Color', 'w');
plot(tiempo_simu, datos_ia, 'LineWidth', 1.5, 'Color', [0.8500, 0.3250, 0.0980]); hold on; % Rojo optimizado
plot(tiempo_simu, datos_ib, 'LineWidth', 1.5, 'Color', [0, 0.4470, 0.7410]);             % Azul optimizado
plot(tiempo_simu, datos_ic, 'LineWidth', 1.5, 'Color', [0.4660, 0.6740, 0.1880]); hold off; % Verde optimizado
grid on; grid minor;
title('Corrientes de fase', 'FontSize', 18, 'FontWeight', 'bold');
legend('i_a', 'i_b', 'i_c', 'Location', 'northeast', 'FontSize', 10);
xlabel('Tiempo (s)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Corriente [A]', 'FontSize', 16, 'FontWeight', 'bold');
ax5 = gca;
ax5.FontSize = 12; ax5.FontWeight = 'bold'; ax5.GridAlpha = 0.3; ax5.MinorGridAlpha = 0.15;



% --- 15. CREAR QUINTA FIGURA (Temp) ---
figure('Color', 'w');
plot(tiempo_simu, datos_va, 'LineWidth', 1.5, 'Color', [0.8500, 0.3250, 0.0980]); hold on; % Rojo optimizado
plot(tiempo_simu, datos_vb, 'LineWidth', 1.5, 'Color', [0, 0.4470, 0.7410]);             % Azul optimizado
plot(tiempo_simu, datos_vc, 'LineWidth', 1.5, 'Color', [0.4660, 0.6740, 0.1880]); hold off; % Verde optimizado
grid on; grid minor;
title('Tensiones de fase', 'FontSize', 18, 'FontWeight', 'bold');
legend('v_a', 'v_b', 'v_c', 'Location', 'northeast', 'FontSize', 10);
xlabel('Tiempo (s)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Tensión [V]', 'FontSize', 16, 'FontWeight', 'bold');
ax6 = gca;
ax6.FontSize = 12; ax6.FontWeight = 'bold'; ax6.GridAlpha = 0.3; ax6.MinorGridAlpha = 0.15;



% --- 15. CREAR QUINTA FIGURA (Temp) ---
figure('Color', 'w');
plot(tiempo_simu, datos_consigna_ang, 'LineWidth', 1.5, 'Color', 'r'); hold on; % Rojo optimizado
plot(tiempo_simu, datos_theta_m, 'LineWidth', 1.5, 'Color', 'b');             % Azul optimizado
%plot(tiempo_simu, datos_theta_m_est, 'LineWidth', 1.5, 'Color', [0.85, 0.65, 0.13]); hold off; % Amarillo mostasa
grid on; grid minor;
title('Respuesta de posición frente a consigna de velocidad angular', 'FontSize', 18, 'FontWeight', 'bold');
legend('q1^*', 'theta_m', 'Location', 'northeast', 'FontSize', 10);
xlabel('Tiempo (s)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Posición Angular [rad]', 'FontSize', 16, 'FontWeight', 'bold');
ax7 = gca;
ax7.FontSize = 12; ax7.FontWeight = 'bold'; ax7.GridAlpha = 0.3; ax7.MinorGridAlpha = 0.15;







