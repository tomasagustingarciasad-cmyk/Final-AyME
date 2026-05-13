
% ----------------- DATOS INICIALES ---------------------
syms ketita_s kew_s kewint_s s

% Matriz A ampliada a 3x3 para incluir la dinámica integral
A = [0 1 0; 
     0 0 1;
     0 0 0];  

% Matriz C ampliada (ya que mide posición angular)
C = [1 0 0];

% Matriz de ganancias del observador (ahora con 3 términos)
Ko = [ketita_s; kew_s; kewint_s];

% Matriz nueva del sistema observador
A_obs = A - Ko * C;

% ----------------- CÁLCULO DE LOS POLOS ---------------------
% Determinante de la ecuación característica
char_eq = det(s * eye(3) - A_obs);

% Expandir la ecuación
char_eq = expand(char_eq);

% Polinomio característico deseado con 3 polos en -3200
p_deseado = (s + 3200)^3; % Polos triples en -3200
p_deseado = expand(p_deseado);

% Igualamos coeficientes de s para obtener ecuaciones
eqs = collect(char_eq - p_deseado, s);

% Extraer coeficientes de s
coef_eq = coeffs(eqs, s);

% Resolver para ketita, kew y kewint
sol = solve(coef_eq == 0, [ketita_s, kew_s, kewint_s]);

% ----------------- MOSTRAR RESULTADOS ---------------------
fprintf("\n")
disp('Valores de las ganancias del observador:')
ketita = double(sol.ketita_s);
kew = double(sol.kew_s);
kewint = double(sol.kewint_s);
disp(['ketita = ', num2str(ketita)]);
disp(['kew = ', num2str(kew)]);
disp(['kewint = ', num2str(kewint)]);

% ----------------- VERIFICACIÓN ---------------------
fprintf("\n")
disp('Polos del observador con acción integral:')
A_obs_num = double(subs(A_obs, {ketita_s, kew_s, kewint_s}, {ketita, kew, kewint}));
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

