% =========================================================================
% EXTRACCIÓN DE DATOS DESDE LAS ESTRUCTURAS DE SIMULINK
% =========================================================================
clc,
% Extraer los vectores numéricos de datos (.Data)
velocidad_datos = out.w_m_out;
torque_datos = out.T_m_out;
% =========================================================================
% GENERACIÓN DE LA GRÁFICA TORQUE vs VELOCIDAD
% =========================================================================

% --- INICIO DE LÍNEAS REEMPLAZADAS ---
% 1. Calcular límites simétricos para el encuadre (margen del 20%)
max_w = max(max(abs(velocidad_datos)) * 1.05, 50); % Mínimo 50 rad/s para visibilidad
max_T = max(max(abs(torque_datos)) * 1.2, 0.9);     % Mínimo 5 N.m para visibilidad

figure('Color', [1 1 1]); % Ventana con fondo blanco
hold on;

% 2. Dibujar los 4 cuadrantes con colores suaves (patch)
% Cuadrante I: Motor Directo (+,+) - Verde suave
patch([0 max_w max_w 0], [0 0 max_T max_T], [0.9 1 0.9], 'EdgeColor', 'none', 'HandleVisibility', 'off');
% Cuadrante II: Freno en Reversa (-,+) - Naranja/Rojo suave
patch([-max_w 0 0 -max_w], [0 0 max_T max_T], [1 0.9 0.85], 'EdgeColor', 'none', 'HandleVisibility', 'off');
% Cuadrante III: Motor en Reversa (-,-) - Verde suave
patch([-max_w 0 0 -max_w], [-max_T -max_T 0 0], [0.9 1 0.9], 'EdgeColor', 'none', 'HandleVisibility', 'off');
% Cuadrante IV: Freno Directo (+,-) - Naranja/Rojo suave
patch([0 max_w max_w 0], [-max_T -max_T 0 0], [1 0.9 0.85], 'EdgeColor', 'none', 'HandleVisibility', 'off');

% 3. Remarcar los ejes cartesianos
xline(0, 'k-', 'LineWidth', 1.5, 'HandleVisibility', 'off');
yline(0, 'k-', 'LineWidth', 1.5, 'HandleVisibility', 'off');

% 4. Agregar etiquetas a cada cuadrante
text(max_w/2, max_T/2, {'Cuadrante I', 'Motor Directo', 'P > 0'}, 'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'FontSize', 7);
text(-max_w/2, max_T/2, {'Cuadrante II', 'Freno Reversa', 'P < 0'}, 'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'FontSize', 7);
text(-max_w/2, -max_T/2, {'Cuadrante III', 'Motor Reversa', 'P > 0'}, 'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'FontSize', 7);
text(max_w/2, -max_T/2, {'Cuadrante IV', 'Freno Directo', 'P < 0'}, 'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'FontSize', 7);

% --- INICIO DE LÍNEAS REEMPLAZADAS ---
% 5. Graficar la trayectoria con gradiente de color continuo (tiempo)
% Se genera el vector de tiempo (ajustar el '2' si tu simulación dura distinto)
tiempo_sim = linspace(0, 2, length(velocidad_datos)); 

% Para hacer una línea con gradiente continuo usamos patch agregando un NaN al final
x_p = [velocidad_datos(:)' NaN];
y_p = [torque_datos(:)' NaN];
c_p = [tiempo_sim(:)' NaN];

patch('XData', x_p, 'YData', y_p, 'CData', c_p, ...
      'FaceColor', 'none', 'EdgeColor', 'interp', ...
      'LineWidth', 2.5, 'HandleVisibility', 'off');

% Agregar y configurar la barra de colores
colormap(turbo);
cb = colorbar;
ylabel(cb, 'Tiempo [s]', 'FontSize', 11);
% --- FIN DE LÍNEAS REEMPLAZADAS ---

grid on;
% Configuraciones estéticas y límites
title('Caracteristica Dinamica: Torque vs. Velocidad Angular en 4 Cuadrantes', 'FontSize', 12, 'FontWeight', 'bold', 'Interpreter', 'latex');


% Si son varios arrays columna, podés concatenarlos:
writematrix([out.tout, out.iq, out.w_m_out], 'datos_exportados.csv');


