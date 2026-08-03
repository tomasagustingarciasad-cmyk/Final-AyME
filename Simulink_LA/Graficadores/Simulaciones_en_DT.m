clc, close all;
% --- 1. CONFIGURAR VARIABLES DESDE TIMESERIES ---
% (Asegurate de cambiar 'resultado' por el nombre que le pusiste en Simulink)
tiempo = out.vq_consig.time;       
datos_vq  = out.vq_consig.signals.values;
datos_Tl = out.Tl_consig.signals.values;

% --- 2. CREAR LA FIGURA (Fondo blanco e ideal para informes) ---
figure('Color', 'w'); 
plot(tiempo, datos_vq, 'LineWidth', 2.5, 'Color', 'r'); 
grid on;

% --- 3. TEXTOS Y TÍTULOS GRANDES ---
title('Consigna de Tensión v_q*', 'FontSize', 18, 'FontWeight', 'bold');
xlabel('Tiempo (s)', 'FontSize', 16, 'FontWeight', 'bold');
ylabel('Tensión [V]', 'FontSize', 16, 'FontWeight', 'bold');

% --- 4. AGRANDAR NÚMEROS DE LOS EJES ---
ax = gca;                      % Captura los ejes actuales
ax.FontSize = 14;              % Agranda los números a tamaño 15
ax.FontWeight = 'bold';        % Pone los números en negrita
ax.GridAlpha = 0.3;            % Hace la cuadrícula más sutil y limpia

% --- 5. CREAR SEGUNDA FIGURA (Tl_consig) ---
figure('Color', 'w'); 
plot(tiempo, datos_Tl, 'LineWidth', 2.5, 'Color', [0.4940, 0.1840, 0.5560]); 
grid on;
title('Consigna de Torque de Perturbación T\_l', 'FontSize', 18, 'FontWeight', 'bold');
xlabel('Tiempo (s)', 'FontSize', 16, 'FontWeight', 'bold');
ylabel('Torque [N.m]', 'FontSize', 16, 'FontWeight', 'bold');
ax2 = gca; ax2.FontSize = 15; ax2.FontWeight = 'bold'; ax2.GridAlpha = 0.3;


% --- 6. EXTRAER NUEVOS DATOS (THETA) ---
tiempo_theta = out.theta_LTI.time; 
datos_LTI    = out.theta_LTI.signals.values;
datos_NL     = out.theta_NL.signals.values;

% --- 7. CREAR TERCERA FIGURA (Subplot comparativo) ---
figure('Color', 'w');

% Gráfica superior (LTI en rojo)
ax3 = subplot(2,1,1);
plot(tiempo_theta, datos_LTI, 'LineWidth', 2, 'Color', 'r'); 
grid on; grid minor;
legend('Sistema completo LTI/theta\_m', 'Location', 'northeast', 'FontSize', 10);
ylabel('Ángulo motor [rad]', 'FontSize', 16, 'FontWeight', 'bold');
ax3.FontSize = 12; ax3.FontWeight = 'bold'; ax3.GridAlpha = 0.3; ax3.MinorGridAlpha = 0.15;
ax3.XTickLabel = []; % Elimina la numeración del eje X para evitar redundancia visual

% Gráfica inferior (NL en azul)
ax4 = subplot(2,1,2);
plot(tiempo_theta, datos_NL, 'LineWidth', 2, 'Color', [0, 0.4470, 0.7410]); 
grid on; grid minor;
legend('Modelo NL desacoplado con Ley de control NL/theta\_m', 'Location', 'northeast', 'FontSize', 10);
xlabel('Tiempo (s)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Ángulo motor [rad]', 'FontSize', 16, 'FontWeight', 'bold');
ax4.FontSize = 12; ax4.FontWeight = 'bold'; ax4.GridAlpha = 0.3; ax4.MinorGridAlpha = 0.15;
linkaxes([ax3, ax4], 'xy');

% --- 8. EXTRAER NUEVOS DATOS (OMEGA) ---
tiempo_w = out.w_LTI.time; 
datos_LTI2    = out.w_LTI.signals.values;
datos_NL2     = out.w_NL.signals.values;

% --- 9. CREAR TERCERA FIGURA (Subplot comparativo) ---
figure('Color', 'w');

% Gráfica superior (LTI en rojo)
ax5 = subplot(2,1,1);
plot(tiempo_w, datos_LTI2, 'LineWidth', 2, 'Color', 'r'); 
grid on; grid minor;
legend('Sistema completo LTI/w\_m', 'Location', 'northeast', 'FontSize', 10);
ylabel('Velocidad motor [rad/s]', 'FontSize', 16, 'FontWeight', 'bold');
ax5.FontSize = 12; ax5.FontWeight = 'bold'; ax5.GridAlpha = 0.3;
ax5.XTickLabel = []; % Elimina la numeración del eje X para evitar redundancia visual

% Gráfica inferior (NL en azul)
ax6 = subplot(2,1,2);
plot(tiempo_w, datos_NL2, 'LineWidth', 2, 'Color', [0, 0.4470, 0.7410]); 
grid on; grid minor;
legend('Modelo NL desacoplado con Ley de control NL/w\_m', 'Location', 'northeast', 'FontSize', 10);
xlabel('Tiempo (s)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Velocidad motor [rad/s]', 'FontSize', 16, 'FontWeight', 'bold');
ax6.FontSize = 12; ax6.FontWeight = 'bold'; ax6.GridAlpha = 0.3;
linkaxes([ax5, ax6], 'xy');

% --- 10. EXTRAER NUEVOS DATOS (Temp) ---
tiempo_Temp = out.T_s_LTI.time; 
datos_LTI3    = out.T_s_LTI.signals.values;
datos_NL3     = out.T_s_NL.signals.values;

% --- 11. CREAR TERCERA FIGURA (Subplot comparativo) ---
figure('Color', 'w');

% Gráfica superior (LTI en rojo)
ax7 = subplot(2,1,1);
plot(tiempo_Temp, datos_LTI3, 'LineWidth', 2, 'Color', 'r'); 
grid on; grid minor;
legend('Sistema completo LTI/T\_s', 'Location', 'northeast', 'FontSize', 10);
ylabel('Temperatura de estator [°C]', 'FontSize', 16, 'FontWeight', 'bold');
ax7.FontSize = 12; ax7.FontWeight = 'bold'; ax7.GridAlpha = 0.3;
ax7.XTickLabel = []; % Elimina la numeración del eje X para evitar redundancia visual

% Gráfica inferior (NL en azul)
ax8 = subplot(2,1,2);
plot(tiempo_Temp, datos_NL3, 'LineWidth', 2, 'Color', [0, 0.4470, 0.7410]); 
grid on; grid minor;
legend('Modelo NL desacoplado con Ley de control NL/T\_s', 'Location', 'northeast', 'FontSize', 10);
xlabel('Tiempo (s)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Temperatura de estator [°C]', 'FontSize', 16, 'FontWeight', 'bold');
ax8.FontSize = 12; ax8.FontWeight = 'bold'; ax8.GridAlpha = 0.3;
linkaxes([ax7, ax8], 'xy');

% --- 12. EXTRAER NUEVOS DATOS (Torque) ---
tiempo_Torq = out.T_m_LTI.time; 
datos_LTI4    = out.T_m_LTI.signals.values;
datos_NL4     = out.T_m_NL.signals.values;

% --- 13. CREAR TERCERA FIGURA (Subplot comparativo) ---
figure('Color', 'w');

% Gráfica superior (LTI en rojo)
ax9 = subplot(2,1,1);
plot(tiempo_Torq, datos_LTI4, 'LineWidth', 2, 'Color', 'r'); 
grid on; grid minor;
legend('Sistema completo LTI/T\_m', 'Location', 'northeast', 'FontSize', 10);
ylabel('Torque electromagnético [N.m]', 'FontSize', 16, 'FontWeight', 'bold');
ax9.FontSize = 12; ax9.FontWeight = 'bold'; ax9.GridAlpha = 0.3;
ax9.XTickLabel = []; % Elimina la numeración del eje X para evitar redundancia visual

% Gráfica inferior (NL en azul)
ax10 = subplot(2,1,2);
plot(tiempo_Torq, datos_NL4, 'LineWidth', 2, 'Color', [0, 0.4470, 0.7410]); 
grid on; grid minor;
legend('Modelo NL desacoplado con Ley de control NL/T\_m', 'Location', 'northeast', 'FontSize', 10);
xlabel('Tiempo (s)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Torque electromagnético [N.m]', 'FontSize', 16, 'FontWeight', 'bold');
ax10.FontSize = 12; ax10.FontWeight = 'bold'; ax10.GridAlpha = 0.3;
linkaxes([ax9, ax10], 'xy');








% ==========================================
% FIN DEL SCRIPT
% ==========================================
