% ----------------- DATOS INICIALES ---------------------
syms ketita_s kew_s s

% Matriz A reducida
A = [0 1; 
     0 0];  

% Matriz C reducida
C = [1 0];

% Matriz de ganancias del observador
Ko = [ketita_s; kew_s];

% Matriz del sistema observador
A_obs = A - Ko * C;

% ----------------- CÁLCULO DE LOS POLOS ---------------------
% Determinante de la ecuación característica
char_eq = det(s * eye(2) - A_obs);

% Expandir la ecuación
char_eq = expand(char_eq);

% Ecuación deseada con polos reales en -3200
p12 = -3200;
polos_deseados = (s - p12)^2; % Ecuación para ambos polos en -3200 + j*0
polos_deseados = expand(polos_deseados);

% Igualamos coeficientes de s y termino independiente
eqs = collect(char_eq - polos_deseados, s);

% Extraer coeficientes de s
coef_eq = coeffs(eqs, s);

% Resolver para ketita y kew
sol = solve(coef_eq == 0, [ketita_s, kew_s]);

% ----------------- MOSTRAR RESULTADOS ---------------------
disp('Valores de las ganancias del observador:')
ketita = double(sol.ketita_s);
kew = double(sol.kew_s);
kewint = 0;
disp(['ketita = ', num2str(ketita)]);
disp(['kew = ', num2str(kew)]);
disp(['kewint = ', num2str(kewint)]);

% ----------------- VERIFICACIÓN ---------------------
disp('Polos del observador reducido:')
A_obs_num = double(subs(A_obs, {ketita_s, kew_s}, {ketita, kew}));
poles_obs = eig(A_obs_num);
disp(poles_obs);

% ----------------- GRAFICACIÓN DE LOS POLOS ---------------------
% figure;
% hold on;
% grid on;
% axis equal;
% 
% % Graficar polos del sistema
% plot(real(poles_obs), imag(poles_obs), 'rx', 'MarkerSize', 10, 'LineWidth', 2);
% 
% % Dibujar ejes
% xline(0, '--k', 'LineWidth', 1); % Eje y (Imaginario)
% yline(0, '--k', 'LineWidth', 1); % Eje x (Real)
% 
% % Etiquetas
% title('Diagrama de Polos del observador reducido de estados');
% xlabel('Eje Real');
% ylabel('Eje Imaginario');
% legend({'Polos del sistema'},'Location','best');
% hold off;
