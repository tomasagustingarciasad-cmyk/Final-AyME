Parametros;

% ----------------- PARÁMETROS ---------------------
Pi = -5000;
Fbw = 796; % Hz
wCorte = 2*pi*Fbw; % rad/s

Tau = -1/Pi; % seg
Ra_prima = Lq/Tau; % Ohms
RaVerificado = wCorte*Lq; % Omhs

% ----------------- FUNCIÓN DE TRANSFERENCIA ---------------------
numGss = 1;
denGss = [Tau 1];
Gss = tf(numGss, denGss);

% ----------------- MOSTRAR FUNCIÓN DE TRANSFERENCIA ---------------------
fprintf("La función de transferencia del Lazo de control de corriente es: \n");
Gss

fprintf("Constante de tiempo Tau = %.4f segundos \n", Tau);
fprintf("Ganancia proporcional Ra' = %.4f omhios \n", Ra_prima);

% % ----------------- RESPUESTA AL ESCALÓN ---------------------
% figure;
% [~, t] = step(Gss);  % Obtener el vector de tiempo de la simulación
% step(Gss)
% hold on;
% yLimits = ylim;  % Obtener límites del eje Y
% plot([Tau Tau], yLimits, 'r--', 'LineWidth', 1.5); % Línea en x = Tau
% hold off;
% title('Respuesta al Escalón de Gss');
% xlabel('Tiempo (s)');
% ylabel('Salida');
% grid on;
% legend('Respuesta', 'Tau', 'Location', 'Best');
% 
% % ----------------- DIAGRAMA DE BODE (SOLO MAGNITUD) ---------------------
% figure;
% [magnitude, ~, w] = bode(Gss); % Obtener solo la magnitud
% 
% % Convertir datos en arreglos para graficar
% magnitude = squeeze(20*log10(magnitude)); % Convertir magnitud a dB
% w = squeeze(w);
% 
% % Graficar la magnitud con línea en w = wCorte
% semilogx(w, magnitude, 'b', 'LineWidth', 1.5);
% hold on;
% xline(wCorte, 'r--', 'LineWidth', 1.5); % Línea en w = wCorte
% hold off;
% grid on;
% title('Diagrama de Bode de Gss');
% xlabel('Frecuencia (rad/s)');
% ylabel('Magnitud (dB)');
% legend('Magnitud', 'wCorte', 'Location', 'Best');
