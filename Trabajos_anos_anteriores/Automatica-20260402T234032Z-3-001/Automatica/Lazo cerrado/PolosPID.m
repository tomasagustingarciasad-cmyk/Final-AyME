% ----------------- DATOS INICIALES ---------------------
syms ba Ksa_s Ksia_s s

% Parámetros del sistema
wn = 800;
zitta = 0.75;

% ----------------- CÁLCULO DE LOS POLOS DEL PID --------------------- 
% Polinomio característico del sistema con el PID
char_eq = s^3 + (ba/Jeq) * s^2 + (Ksa_s/Jeq) * s + (Ksia_s/Jeq);

% Polinomio deseado
polos_deseados = expand((s + wn)*(s^2 + 2*zitta*wn*s + wn^2));

% Igualar coeficientes de s^3, s^2, s y término constante
eqs = collect(char_eq - polos_deseados, s); % Agrupa términos
coef_eq = coeffs(eqs, s); % Extrae coeficientes

% Resolver para ba, Ksa y Ksia
sol = solve(coef_eq == 0, [ba, Ksa_s, Ksia_s]);

% ----------------- MOSTRAR RESULTADOS ---------------------
fprintf("\n")
disp('Valores de las constantes del PID:')

% Extraer valores correctamente
ba = double(sol.ba);
Ksa = double(sol.Ksa_s);
Ksia = double(sol.Ksia_s);

fprintf("\n")
disp(['ba = ', num2str(ba), ' N.m/rad/s']);
disp(['Ksa = ', num2str(Ksa), ' N.m/rad']);
disp(['Ksia = ', num2str(Ksia), ' N.m/rad.s']);

% ----------------- VERIFICACIÓN ---------------------
fprintf("\n")
disp('Polos del sistema con el PID:')
coeffs_pid = [Jeq, ba, Ksa, Ksia];
poles_pid = roots(coeffs_pid);
disp(poles_pid);

% ----------------- SEGUNDA VERIFICACIÓN --------------------
n = 2 * zitta + 1;

ba = Jeq * n * wn;
Ksa = Jeq * n * wn^2;
Ksia = Jeq * wn^3;

disp(['ba = ', num2str(ba), ' N.m/rad/s']);
disp(['Ksa = ', num2str(Ksa), ' N.m/rad']);
disp(['Ksia = ', num2str(Ksia), ' N.m/rad.s']);

% ----------------- GRAFICACIÓN DE LOS POLOS ---------------------
% figure;
% hold on;
% grid on;
% axis equal;
% 
% Graficar polos del sistema
% plot(real(poles_pid), imag(poles_pid), 'rx', 'MarkerSize', 10, 'LineWidth', 2);
% 
% Dibujar ejes
% xline(0, '--k', 'LineWidth', 1); % Eje y (Imaginario)
% yline(0, '--k', 'LineWidth', 1); % Eje x (Real)
% 
% Etiquetas
% title('Diagrama de Polos del Sistema PID');
% xlabel('Eje Real');
% ylabel('Eje Imaginario');
% legend({'Polos del sistema'},'Location','best');
% hold off;
