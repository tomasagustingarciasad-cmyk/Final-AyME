clc, close all;
% --- 14. EXTRAER NUEVOS DATOS (Velocidad Angular) ---
paso = 1; % Toma 1 de cada 5 puntos para evitar colapso de memoria gráfica
tiempo_vd_NL  = out.w_m_vd0.time(1:paso:end); 
datos_w_vd0_NL  = out.w_m_vd0.signals.values(1:paso:end);
datos_w_vdpos_NL  = out.w_m_vdpos.signals.values(1:paso:end);
datos_w_vdneg_NL  = out.w_m_vdneg.signals.values(1:paso:end);

% --- 15. CREAR QUINTA FIGURA (Corrientes NL) ---
figure('Color', 'w');
plot(tiempo_vd_NL, datos_w_vd0_NL, 'LineWidth', 1.5, 'Color', [0.8500, 0.3250, 0.0980]); hold on; % Rojo optimizado
plot(tiempo_vd_NL, datos_w_vdpos_NL, 'LineWidth', 1.5, 'Color', [0, 0.4470, 0.7410]);             % Azul optimizado
plot(tiempo_vd_NL, datos_w_vdneg_NL, 'LineWidth', 1.5, 'Color', [0.4660, 0.6740, 0.1880]); hold off; % Verde optimizado
grid on; grid minor;
title('Variación de velocidad con reforzamiento y debilitamiento de campo', 'FontSize', 18, 'FontWeight', 'bold');
legend('NL / w_m, vd=0', 'NL / w_m, vd=+1,9596', 'NL / w_m, vd=-1,9596', 'Location', 'northeast', 'FontSize', 10);
xlabel('Tiempo (s)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Velocidad Angular [rad/s]', 'FontSize', 16, 'FontWeight', 'bold');
ax16 = gca;
ax16.FontSize = 12; ax16.FontWeight = 'bold'; ax16.GridAlpha = 0.3; ax16.MinorGridAlpha = 0.15;



% --- 14. EXTRAER NUEVOS DATOS (Torque) ---
paso = 1; % Toma 1 de cada 5 puntos para evitar colapso de memoria gráfica
tiempo_vd_NL  = out.w_m_vd0.time(1:paso:end); 
datos_Tm_vd0_NL  = out.T_m_vd0.signals.values(1:paso:end);
datos_Tm_vdpos_NL  = out.T_m_vdpos.signals.values(1:paso:end);
datos_Tm_vdneg_NL  = out.T_m_vdneg.signals.values(1:paso:end);

% --- 15. CREAR QUINTA FIGURA (Torque) ---
figure('Color', 'w');
plot(tiempo_vd_NL, datos_Tm_vd0_NL, 'LineWidth', 1.5, 'Color', [0.8500, 0.3250, 0.0980]); hold on; % Rojo optimizado
plot(tiempo_vd_NL, datos_Tm_vdpos_NL, 'LineWidth', 1.5, 'Color', [0, 0.4470, 0.7410]);             % Azul optimizado
plot(tiempo_vd_NL, datos_Tm_vdneg_NL, 'LineWidth', 1.5, 'Color', [0.4660, 0.6740, 0.1880]); hold off; % Verde optimizado
grid on; grid minor;
title('Variación de torque con reforzamiento y debilitamiento de campo', 'FontSize', 18, 'FontWeight', 'bold');
legend('NL / T_m, vd=0', 'NL / T_m, vd=+1,9596', 'NL / T_m, vd=-1,9596', 'Location', 'northeast', 'FontSize', 10);
xlabel('Tiempo (s)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Torque [N.m]', 'FontSize', 16, 'FontWeight', 'bold');
ax17 = gca;
ax17.FontSize = 12; ax17.FontWeight = 'bold'; ax17.GridAlpha = 0.3; ax17.MinorGridAlpha = 0.15;



% --- 14. EXTRAER NUEVOS DATOS (Temp) ---
paso = 1; % Toma 1 de cada 5 puntos para evitar colapso de memoria gráfica
tiempo_vd_NL  = out.w_m_vd0.time(1:paso:end); 
datos_Ts_vd0_NL  = out.T_s_vd0.signals.values(1:paso:end);
datos_Ts_vdpos_NL  = out.T_s_vdpos.signals.values(1:paso:end);
datos_Ts_vdneg_NL  = out.T_s_vdneg.signals.values(1:paso:end);

% --- 15. CREAR QUINTA FIGURA (Temp) ---
figure('Color', 'w');
plot(tiempo_vd_NL, datos_Ts_vd0_NL, 'LineWidth', 1.5, 'Color', [0.8500, 0.3250, 0.0980]); hold on; % Rojo optimizado
plot(tiempo_vd_NL, datos_Ts_vdpos_NL, 'LineWidth', 1.5, 'Color', [0, 0.4470, 0.7410]);             % Azul optimizado
plot(tiempo_vd_NL, datos_Ts_vdneg_NL, 'LineWidth', 1.5, 'Color', [0.4660, 0.6740, 0.1880]); hold off; % Verde optimizado
grid on; grid minor;
title('Variación de Temperatura con reforzamiento y debilitamiento de campo', 'FontSize', 18, 'FontWeight', 'bold');
legend('NL / T_s, vd=0', 'NL / T_s, vd=+1,9596', 'NL / T_s, vd=-1,9596', 'Location', 'northeast', 'FontSize', 10);
xlabel('Tiempo (s)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Temperatura de estator [°C]', 'FontSize', 16, 'FontWeight', 'bold');
ax18 = gca;
ax18.FontSize = 12; ax18.FontWeight = 'bold'; ax18.GridAlpha = 0.3; ax18.MinorGridAlpha = 0.15;

