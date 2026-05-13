Parametros;  % Archivo donde están los valores iniciales

% ----------------- SISTEMA EN ESPACIO DE ESTADOS ---------------------
A = [  0,   1,        0;    
       0, -beq/Jeq, KTeq/Jeq;    
       0, -KEeq/Lq, -Rs/Lq  ];  

Bc = [ 0; 0; 1/Lq];
Bd = [0; -1/Jeq; 0];
C = [1, 0, 0];
C_vel = [0, 1, 0]; % Matriz de salida para Wm
D = 0;

disp('Matriz de estado A :');
disp(A);
disp('Matriz de control Bc :');
disp(Bc);
disp('Matriz de perturbación Bd :');
disp(Bd);
disp('Matriz de salida C :');
disp(C);
disp('Matriz de transmisión directa D :');
disp(D);

% Crear el modelo en espacio de estados
sys_ss = ss(A, Bc, C, D);
sys_ss_vel = ss(A, Bc, C_vel, D); % Sistema con salida como Wm

% ----------------- ANÁLISIS DEL SISTEMA ---------------------
disp('-------------------- Análisis del Sistema --------------------')

% FUNCIÓN DE TRANSFERENCIA DEL SISTEMA PARA CONTROL Y PERTURBACIÓN
[num_C, den_C] = ss2tf(A, Bc, C, D);
num_C = double(num_C);  % Convertir a valores numéricos
den_C = double(den_C);

[num_D, den_D] = ss2tf(A, Bd, C, D);
num_D = double(num_D);  
den_D = double(den_D);

% ----------------- CREAR FUNCIÓN DE TRANSFERENCIA ---------------------
fprintf('\nFunción de Transferencia de control Gv(s) =\n');
Gvs = tf(num_C, den_C)
fprintf('\nFunción de Transferencia de perturbación Gt(s) =\n');
Gts = tf(num_D, den_D)

% POLOS Y CEROS DEL SISTEMA
fprintf('\n');
disp('Polos del sistema con matriz de control:');
poles_C = pole(Gvs);
disp(poles_C);

disp('Ceros del sistema con matriz de control:');
zeros_C = zero(Gvs);
disp(zeros_C);

disp('Polos del sistema con matriz de perturbación:');
poles_D = pole(Gts);
disp(poles_D);

disp('Ceros del sistema con matriz de perturbación:');
zeros_D = zero(Gts);
disp(zeros_D);

% Buscar el polo con parte imaginaria (polo complejo conjugado)
polo_complejo = poles_C(imag(poles_C) ~= 0); % Extrae el polo complejo

% Extraer la parte real e imaginaria del polo complejo
omega = real(polo_complejo(1)); % Parte real del polo complejo (decaimiento)
wd = abs(imag(polo_complejo(1))); % Parte imaginaria del polo complejo (frecuencia amortiguada)

% Calcular la frecuencia natural wn (Teorema de Pitágoras)
wn = sqrt(omega^2 + wd^2); 

% Calcular el factor de amortiguamiento zitta
zitta = abs(omega / wn); 

% Ganancia del sistema
Kgan = num_C/wn^2;
Kgan = Kgan(4);

% ----------------- MOSTRAR RESULTADOS ---------------------
disp('Parámetros del sistema:')
disp(['Ganancia del sistema (K): ', num2str(Kgan)]);
disp(['Frecuencia Natural (wn): ', num2str(wn), ' rad/s']);
disp(['Frecuencia Natural Amortiguada (wd): ', num2str(wd), ' rad/s']);
disp(['Tasa de amortiguamiento / Decaimiento (omega): ', num2str(omega), ' rad/s']);
disp(['Factor de Amortiguamiento (zitta): ', num2str(zitta)]);

% ----------------- OTRAS CARACTERÍSTICAS/PRÁMETROS ---------------------
% Constante de tiempo equivalente
teq = 1 / (zitta * wn);

% Tiempo de subida (Rise time)
tr = 1.8 / wn;

% Tiempo de establecimiento con criterio 2% (Setting time)
ts = 4 / (zitta * wn);

% Tiempo de pico
tp = pi / wd;

% Sobreimpulso máximo
Mp = 100 * exp((-pi * zitta) / sqrt(1 - zitta^2));

fprintf("Constante de tiempo equivalete teq = %.4f seg\n", teq);
fprintf("Tiempo de subida tr = %.4f seg\n", tr);
fprintf("Tiempo de establecimiento ts = %.4f seg\n", ts);
fprintf("Tiempo de pico tp = %.4f seg\n", tp);
fprintf("Sobreimpulso máximo Mp = %.2f%%\n", Mp);

% ----------------- INFORMACION DE RESPUESTA VELOCIDAD ---------------------
info_escalon = stepinfo(sys_ss_vel);
% Error en estado estacionario para entrada escalón
error_estado_estacionario = abs(1 - dcgain(sys_ss_vel));
disp(['Error en estado estacionario: ', num2str(error_estado_estacionario)]);

% ----------------- DISEÑO DEL OBSERVADOR DE LUENBERGER ---------------------
fprintf("\n")
PolosDeseadosObs = [-500; -550; -600];  % Polos deseados

% Cálculo de la matriz de ganancias del observador Ko
Ko = place(A', C', PolosDeseadosObs)';

% Matriz A del observador
A_observer = A - Ko * C;

disp('Polos del Observador de Luenberger:');
poles_Observer = eig(A_observer);
disp(poles_Observer);

% ----------------- ANÁLISIS DE OBSERVABILIDAD Y CONTROLABILIDAD ---------------------
Co_Vq = ctrb(A, Bc); % Matriz de controlabilidad desde vq(t)
Co_Tl = ctrb(A, Bd); % Matriz de controlabilidad desde Tl(t)
Ob_tita = obsv(A, C); % Matriz de observabilidad desde tita_m(t)
Ob_wm = obsv(A, C_vel); % Matriz de observabilidad desde wm(t)

% Vq(t)
disp('Matriz de controlabilidad Co desde Vq(t):');
disp(Co_Vq);
disp('Rango de la matriz de controlabilidad desde Vq(t):');
disp(rank(Co_Vq));

% Tl(t)
disp('Matriz de controlabilidad Co desde Tl(t):');
disp(Co_Tl);
disp('Rango de la matriz de controlabilidad desde Tl(t):');
disp(rank(Co_Tl));

% tita_m(t)
disp('Matriz de observabilidad Ob desde tita_m(t):');
disp(Ob_tita);
disp('Rango de la matriz de observabilidad desde tita_m(t):');
disp(rank(Ob_tita));

% wm(t)
disp('Matriz de observabilidad Ob desde wm(t):');
disp(Ob_wm);
disp('Rango de la matriz de observabilidad desde wm(t):');
disp(rank(Ob_wm));

% Vq(t)
if rank(Co_Vq) == size(A,1)
    disp('El sistema es completamente controlable desde Vq(t)');
else
    disp('El sistema NO es completamente controlable desde Vq(t)');
end

% Tl(t)
if rank(Co_Tl) == size(A,1)
    disp('El sistema es completamente controlable desde Tl(t)');
else
    disp('El sistema NO es completamente controlable desde Tl(t)');
end

% tita_m(t)
if rank(Ob_tita) == size(A,1)
    disp('El sistema es completamente observable desde tita_m(t)');
else
    disp('El sistema NO es completamente observable desde tita_m(t)');
end

% wm(t)
if rank(Ob_wm) == size(A,1)
    disp('El sistema es completamente observable desde wm(t)');
else
    disp('El sistema NO es completamente observable desde wm(t)');
end


% ----------------- RESPUESTA AL ESCALÓN ---------------------
t_step = 0:0.01:10;
[y_step, ~] = step(sys_ss, t_step);
[y_step_vel, ~] = step(sys_ss_vel, t_step);

figure;
subplot(2,1,1);
plot(t_step, y_step, 'b', 'LineWidth', 1.5);
title('Respuesta al escalón - Tita');
xlabel('Tiempo (s)');
ylabel('Tita (rad)');
grid on;

subplot(2,1,2);
plot(t_step, y_step_vel, 'r', 'LineWidth', 1.5);
title('Respuesta al escalón - Wm');
xlabel('Tiempo (s)');
ylabel('Wm (rad/s)');
grid on;

% ----------------- RESPUESTA AL IMPULSO ---------------------
t = 0:0.001:10;
[y_impulse, ~] = impulse(sys_ss, t);
[y_impulse_vel, ~] = impulse(sys_ss_vel, t);

figure;
subplot(2,1,1);
plot(t, y_impulse, 'b', 'LineWidth', 1.5);
title('Respuesta al impulso - Tita');
xlabel('Tiempo (s)');
ylabel('Tita (rad)');
grid on;

subplot(2,1,2);
plot(t, y_impulse_vel, 'r', 'LineWidth', 1.5);
title('Respuesta al impulso - Wm');
xlabel('Tiempo (s)');
ylabel('Wm (rad/s)');
grid on;

% ----------------- RESPUESTA A UNA RAMPA ---------------------
rampa = t;
[y_rampa, ~] = lsim(sys_ss, rampa, t);
[y_rampa_vel, ~] = lsim(sys_ss_vel, rampa, t);

figure;
subplot(2,1,1);
plot(t, y_rampa, 'b', 'LineWidth', 1.5);
hold on;
plot(t, rampa, 'k--', 'LineWidth', 1);
title('Respuesta a una entrada rampa - Tita');
xlabel('Tiempo (s)');
ylabel('Tita (rad)');
grid on;

subplot(2,1,2);
plot(t, y_rampa_vel, 'r', 'LineWidth', 1.5);
title('Respuesta a una entrada rampa - Wm');
xlabel('Tiempo (s)');
ylabel('Wm (rad/s)');
grid on;

% ----------------- RESPUESTA A UNA SEÑAL SENOIDAL ---------------------
frec = 1;
senoidal = sin(2 * pi * frec * t);
[y_senoidal, ~] = lsim(sys_ss, senoidal, t);
[y_senoidal_vel, ~] = lsim(sys_ss_vel, senoidal, t);

figure;
subplot(2,1,1);
plot(t, y_senoidal, 'b', 'LineWidth', 1.5);
hold on;
plot(t, senoidal, 'k--', 'LineWidth', 1);
title('Respuesta a una entrada senoidal - Tita');
xlabel('Tiempo (s)');
ylabel('Tita (rad)');
grid on;

subplot(2,1,2);
plot(t, y_senoidal_vel, 'r', 'LineWidth', 1.5);
title('Respuesta a una entrada senoidal - Wm');
xlabel('Tiempo (s)');
ylabel('Wm (rad/s)');
grid on;

% ----------------- GRÁFICO MANUAL DE POLOS Y CEROS ---------------------
figure;
hold on;
grid on;

% Dibujar polos del sistema (rojo, cruz)
plot(real(poles_C), imag(poles_C), 'rx', 'MarkerSize', 10, 'LineWidth', 2);

% Dibujar ceros del sistema (azul, círculo)
plot(real(zeros_D), imag(zeros_D), 'bo', 'MarkerSize', 10, 'LineWidth', 2);

% Dibujar ejes
xline(0, '--k', 'LineWidth', 1); % Eje y (Imaginario)
yline(0, '--k', 'LineWidth', 1); % Eje x (Real)

% Configurar el gráfico
title('Diagrama de Polos y Ceros');
xlabel('Eje Real');
ylabel('Eje Imaginario');
legend({'Polos del sistema', 'Ceros del sistema'},'Location','best');

axis equal;
hold off;

