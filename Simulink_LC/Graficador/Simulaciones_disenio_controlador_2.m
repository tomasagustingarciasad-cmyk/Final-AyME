clc, close all;
% --- 14. EXTRAER NUEVOS DATOS (Velocidad Angular) ---
paso = 1; % Toma 1 de cada 5 puntos para evitar colapso de memoria gráfica
tiempo_simu  = out.Tm_id0.time(1:paso:end); 
datos_Tm_consig  = out.Consig_Torque.signals.values(1:paso:end);
datos_Tm_id0  = out.Tm_id0.signals.values(1:paso:end);
datos_Tm_idpos  = out.Tm_idpos.signals.values(1:paso:end);
datos_Tm_idneg  = out.Tm_idneg.signals.values(1:paso:end);
datos_iq_id0 = out.iq_consig_id0.signals.values(1:paso:end);
datos_iq_idpos = out.iq_consig_idpos.signals.values(1:paso:end);
datos_iq_idneg = out.iq_consig_idneg.signals.values(1:paso:end);

 
% --- 15. CREAR QUINTA FIGURA (Corrientes NL) ---
figure('Color', 'w');
plot(tiempo_simu, datos_Tm_consig, 'LineWidth', 1.5, 'Color', 'r'); hold on; % Rojo optimizado       
plot(tiempo_simu, datos_Tm_id0, 'LineWidth', 1.5, 'Color', 'b'); hold off; 
grid on; grid minor;
title('Consigna de torque T*_m vs T_m (t)', 'FontSize', 18, 'FontWeight', 'bold');
legend('T*_m', 'T_m (t)', 'Location', 'northeast', 'FontSize', 10);
xlabel('Tiempo (s)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Torque [N.m]', 'FontSize', 16, 'FontWeight', 'bold');
ax2 = gca;
ax2.FontSize = 12; ax2.FontWeight = 'bold'; ax2.GridAlpha = 0.3; ax2.MinorGridAlpha = 0.15;

%---------------------------------------------------------------------------------------------
% --- 15. CREAR QUINTA FIGURA (Corrientes NL) ---
figure('Color', 'w');
plot(tiempo_simu, datos_Tm_consig, 'LineWidth', 1.5, 'Color', 'r'); hold on; % Rojo optimizado       
plot(tiempo_simu, datos_Tm_idpos, 'LineWidth', 1.5, 'Color', 'b'); hold off; 
grid on; grid minor;
title('Consigna de torque T*_m vs T_m (t) con reforzamiento de campo', 'FontSize', 18, 'FontWeight', 'bold');
legend('T*_m', 'T_m (t)', 'Location', 'northeast', 'FontSize', 10);
xlabel('Tiempo (s)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Torque [N.m]', 'FontSize', 16, 'FontWeight', 'bold');
ax2 = gca;
ax2.FontSize = 12; ax2.FontWeight = 'bold'; ax2.GridAlpha = 0.3; ax2.MinorGridAlpha = 0.15;

%---------------------------------------------------------------------------------------------
% --- 15. CREAR QUINTA FIGURA (Corrientes NL) ---
figure('Color', 'w');
plot(tiempo_simu, datos_Tm_consig, 'LineWidth', 1.5, 'Color', 'r'); hold on; % Rojo optimizado       
plot(tiempo_simu, datos_Tm_idneg, 'LineWidth', 1.5, 'Color', 'b'); hold off; 
grid on; grid minor;
title('Consigna de torque T*_m vs T_m (t) con debilitamiento de campo', 'FontSize', 18, 'FontWeight', 'bold');
legend('T*_m', 'T_m (t)', 'Location', 'northeast', 'FontSize', 10);
xlabel('Tiempo (s)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Torque [N.m]', 'FontSize', 16, 'FontWeight', 'bold');
ax2 = gca;
ax2.FontSize = 12; ax2.FontWeight = 'bold'; ax2.GridAlpha = 0.3; ax2.MinorGridAlpha = 0.15;





%---------------------------------------------------------------------------------------------
% --- 15. CREAR QUINTA FIGURA (Corrientes NL) ---
figure('Color', 'w');
plot(tiempo_simu, datos_iq_id0, 'LineWidth', 1.5, 'Color', 'r'); hold on; % Rojo optimizado       
plot(tiempo_simu, datos_iq_idpos, 'LineWidth', 1.5, 'Color', 'b'); hold off; 
grid on; grid minor;
title('Consigna de corriente para id=0 vs consigna con reforzamiento de campo', 'FontSize', 18, 'FontWeight', 'bold');
legend('i*_q, id=0', 'i*_q, id>0', 'Location', 'northeast', 'FontSize', 10);
xlabel('Tiempo (s)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Corriente [A]', 'FontSize', 16, 'FontWeight', 'bold');
ax3 = gca;
ax3.FontSize = 12; ax3.FontWeight = 'bold'; ax3.GridAlpha = 0.3; ax3.MinorGridAlpha = 0.15;




%---------------------------------------------------------------------------------------------
% --- 15. CREAR QUINTA FIGURA (Corrientes NL) ---
figure('Color', 'w');
plot(tiempo_simu, datos_iq_id0, 'LineWidth', 1.5, 'Color', 'r'); hold on; % Rojo optimizado       
plot(tiempo_simu, datos_iq_idneg, 'LineWidth', 1.5, 'Color', 'b'); hold off; 
grid on; grid minor;
title('Consigna de corriente para id=0 vs consigna con debilitamiento de campo', 'FontSize', 18, 'FontWeight', 'bold');
legend('i*_q, id=0', 'i*_q, id<0', 'Location', 'northeast', 'FontSize', 10);
xlabel('Tiempo (s)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Corriente [A]', 'FontSize', 16, 'FontWeight', 'bold');
ax4 = gca;
ax4.FontSize = 12; ax4.FontWeight = 'bold'; ax4.GridAlpha = 0.3; ax4.MinorGridAlpha = 0.15;