% --- 14. EXTRAER NUEVOS DATOS (CORRIENTES EQUIV) ---
%tiempo_iq = out.i_q_LTI.time; 
%datos_i_q_LTI = out.i_q_LTI.signals.values;
%datos_i_d_LTI = out.i_d_LTI.signals.values;
%datos_i_0_LTI = out.i_0_LTI.signals.values;

%datos_i_q_NL = out.i_q_NL.signals.values;
%datos_i_d_NL = out.i_d_NL.signals.values;
%datos_i_0_NL = out.i_0_NL.signals.values;

paso = 5; % Toma 1 de cada 3 puntos para evitar colapso de memoria
tiempo_iq     = out.i_q_LTI.time(1:paso:end); 
datos_i_q_LTI = out.i_q_LTI.signals.values(1:paso:end);
datos_i_d_LTI = out.i_d_LTI.signals.values(1:paso:end);
datos_i_0_LTI = out.i_0_LTI.signals.values(1:paso:end);
datos_i_q_NL  = out.i_q_NL.signals.values(1:paso:end);
datos_i_d_NL  = out.i_d_NL.signals.values(1:paso:end);
datos_i_0_NL  = out.i_0_NL.signals.values(1:paso:end);

% --- 15. CREAR QUINTA FIGURA (Subplot de corrientes comparativo) ---
figure('Color', 'w');

% Gráfica superior (LTI)
ax11 = subplot(2,1,1);
plot(tiempo_iq, datos_i_q_LTI, 'LineWidth', 1.5, 'Color', [0.8500, 0.3250, 0.0980]); hold on;
plot(tiempo_iq, datos_i_d_LTI, 'LineWidth', 1.5, 'Color', [0.4660, 0.6740, 0.1880]);
plot(tiempo_iq, datos_i_0_LTI, 'LineWidth', 1.5, 'Color', [0.9290, 0.6940, 0.1250]); hold off;
grid on; grid minor;
legend('LTI / i_q', 'LTI / i_d', 'LTI / i_0', 'Location', 'northeast', 'FontSize', 10);
ylabel('Corriente [A]', 'FontSize', 16, 'FontWeight', 'bold');
ax11.FontSize = 12; ax11.FontWeight = 'bold'; ax11.GridAlpha = 0.3; ax11.MinorGridAlpha = 0.15;
ax11.XTickLabel = []; % Elimina la numeración del eje X para evitar redundancia visual

% Gráfica inferior (NL)
ax12 = subplot(2,1,2);
plot(tiempo_iq, datos_i_q_NL, 'LineWidth', 1.5, 'Color', [0.8500, 0.3250, 0.0980]); hold on;
plot(tiempo_iq, datos_i_d_NL, 'LineWidth', 1.5, 'Color', [0.4660, 0.6740, 0.1880]);
plot(tiempo_iq, datos_i_0_NL, 'LineWidth', 1.5, 'Color', [0.9290, 0.6940, 0.1250]); hold off;
grid on; grid minor;
legend('NL / i_q', 'NL / i_d', 'NL / i_0', 'Location', 'northeast', 'FontSize', 10);
xlabel('Tiempo (s)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Corriente [A]', 'FontSize', 16, 'FontWeight', 'bold');
ax12.FontSize = 12; ax12.FontWeight = 'bold'; ax12.GridAlpha = 0.3; ax12.MinorGridAlpha = 0.15;
linkaxes([ax11, ax12], 'xy');