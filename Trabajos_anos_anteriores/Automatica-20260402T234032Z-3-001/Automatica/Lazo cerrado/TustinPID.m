% Cargar parámetros y polos del PID
Parametros;
PolosPID;

% Definir la variable de Laplace
s = tf('s');

% Controlador PID en tiempo continuo
C_s = ba + Ksa/s + Ksia/(s^2);

% Mostrar la función de transferencia del PID en continuo
disp('Función de transferencia del Controlador PID en tiempo continuo:')
C_s

% ------------------------ 2. Determinar el Periodo de Muestreo (Ts) ------------------------
wn = 114.3976; % frecuencia natural dominante del sistema
% Usando la regla de Nyquist (10 veces la frecuencia máxima)
Ts = 1 / (10 * (wn / (2*pi)));  % Ts <= 1/(10*f_max) con f_max = wn/(2*pi)

% Mostrar el valor calculado de Ts
disp(['Periodo de muestreo seleccionado: Ts = ', num2str(Ts), ' seg'])

% ------------------------ 3. Discretización con el Método de Tustin ------------------------
Ts = 0.0001;  % Fijamos el período de muestreo 

% Discretizar el PID con el método de Tustin (Trapecios)
C_z = c2d(C_s, Ts, 'tustin');

% Mostrar el controlador discretizado en tiempo discreto
disp('Función de transferencia Controlador PID en tiempo discreto (dominio z):')
C_z

% ------------------------ 4. Extraer Numerador y Denominador ------------------------
[num_PIDTZ, den_PIDTZ] = tfdata(C_z, 'v');  % Extrae los coeficientes en forma de vector

% Mostrar los coeficientes del numerador y denominador
disp('Coeficientes del Numerador (num):');
disp(num_PIDTZ);

disp('Coeficientes del Denominador (den):');
disp(den_PIDTZ);

% ------------------------ 5. Comparar Respuesta en Tiempo ------------------------
% Crear un sistema de prueba para comparar respuestas
G_s = 1 / (s^2 + 2*zitta*wn*s + wn^2); % Ejemplo de sistema de segundo orden

% Sistema en lazo cerrado con PID continuo
CL_s = feedback(C_s * G_s, 1);

% Sistema en lazo cerrado con PID discreto
CL_z = feedback(C_z * c2d(G_s, Ts, 'tustin'), 1);

% Simulación de la respuesta al escalón
t = 0:Ts:1; % Tiempo de simulación
[y_s, t_s] = step(CL_s, t(end)); % Respuesta del sistema continuo
[y_z, t_z] = step(CL_z, t); % Respuesta del sistema discreto

% ------------------------ 6. Graficar Comparación ------------------------
% figure;
% plot(t_s, y_s, 'b', 'LineWidth', 2); hold on;
% stairs(t_z, y_z, 'r--', 'LineWidth', 2); % Escalonado para discretización
% xlabel('Tiempo (s)');
% ylabel('Salida');
% title('Comparación de Respuesta del PID Continuo vs Discreto');
% legend('PID Continuo', 'PID Discreto');
% grid on;
