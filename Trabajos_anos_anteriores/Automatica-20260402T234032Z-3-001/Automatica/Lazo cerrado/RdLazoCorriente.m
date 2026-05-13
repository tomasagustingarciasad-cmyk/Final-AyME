Parametros;

id_consigna = 0.5;

% ----------------- PARÁMETROS ---------------------
Pi = -5000;
Fbw = 796; % Hz
wCorte = 2*pi*Fbw; % rad/s

Tau_d = -1/Pi; % seg
Rd_prima = Ld/Tau_d; % Ohms
RdVerificado = wCorte*Ld; % Omhs

% ----------------- FUNCIÓN DE TRANSFERENCIA ---------------------
numGss = 1;
denGss = [Tau_d 1];
Gss = tf(numGss, denGss);

% ----------------- MOSTRAR FUNCIÓN DE TRANSFERENCIA ---------------------
fprintf("La función de transferencia del Lazo de control de corriente id(t) es: \n");
Gss

fprintf("Constante de tiempo Tau = %.4f segundos \n", Tau_d);
fprintf("Ganancia proporcional Rd' = %.4f omhios \n", Rd_prima);