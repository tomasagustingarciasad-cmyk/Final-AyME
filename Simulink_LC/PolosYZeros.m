numLA=[(L_q), (R_sREF)];
denLA=[(J_eq * L_q), (L_q * b_eq + J_eq * R_sREF), (R_sREF * b_eq + 1.5 * P_p^2 * lambda_m^2), 0];
numLi=1;
denLi=[L_q/R_q , 1];
numLC=[b_a,K_a,K_ai];
denLC=[J_eq,b_a,K_a,K_ai];
HLA=tf(numLA,denLA);
HLi=tf(numLi,denLi);
HLC=tf(numLC,denLC);

% Generación de la figura y gráfica del mapa de polos de los 3 sistemas
figure;
hold on;
grid on;

% Dibujar ejes primero (así quedan de fondo y no interfieren con la leyenda)
xline(0, '--k', 'LineWidth', 1, 'HandleVisibility', 'off'); % Eje y (Imaginario)
yline(0, '--k', 'LineWidth', 1, 'HandleVisibility', 'off'); % Eje x (Real)

% Dibujar polos del sistema HLA (rojo, cruz)
plot(real(pole(HLA)), imag(pole(HLA)), 'rx', 'MarkerSize', 8, 'LineWidth', 1.5);

% Dibujar polos del sistema HLi (verde, triángulo)
plot(real(pole(HLi)), imag(pole(HLi)), 'g^', 'MarkerSize', 8, 'LineWidth', 1.5);

% Dibujar polos del sistema HLC (violeta, cuadrado)
plot(real(pole(HLC)), imag(pole(HLC)), 's', 'Color', [0.5 0 0.5], 'MarkerSize', 8, 'LineWidth', 1.5);

title('Mapa de Polos - Sistema');
xlabel('Eje Real');
ylabel('Eje Imaginario');
legend({'Polos LA', 'Polos Li', 'Polos LC'}, 'Location', 'best');

% Fijar límites de los ejes manualmente (un poco más amplios que el rango de datos)
xlim([-5500 500]);
ylim([-2000 2000]);

hold off;


% --- Parámetros fijos ---

% --- Barrido de m_l ---
m_l_vec = linspace(0, 1.5, 50); % 50 puntos entre 0 y 1.5 kg

% --- Preasignar almacenamiento de polos ---
% HLC tiene 3 polos (denominador de orden 3), ajustar si es distinto
n_polos = length(denLC) - 1;
polos_LC = zeros(n_polos, length(m_l_vec));

% --- Calcular J_eq y polos para cada m_l ---
for i = 1:length(m_l_vec)
    m_l = m_l_vec(i);
    J_l = (m*(L_cm^2) + J_cm) + m_l*(L_l^2);
    J_eq_i = J_m + J_l/(r^2);
    
    denLC_i = [J_eq_i, b_a, K_a, K_ai];
    HLC_i = tf(numLC, denLC_i);
    
    p = pole(HLC_i);
    polos_LC(:,i) = p;
end

% --- Gráfico del desplazamiento de polos ---
figure;
hold on;
grid on;

xline(0, '--k', 'LineWidth', 1, 'HandleVisibility', 'off');
yline(0, '--k', 'LineWidth', 1, 'HandleVisibility', 'off');

% Colormap para representar la variación de m_l (de azul a rojo)
cmap = jet(length(m_l_vec));

for i = 1:length(m_l_vec)
    plot(real(polos_LC(:,i)), imag(polos_LC(:,i)), 's', ...
        'Color', cmap(i,:), 'MarkerSize', 6, 'LineWidth', 1.2, ...
        'HandleVisibility', 'off');
end

% Marcar inicio (m_l = 0) y fin (m_l = 1.5) para referencia
plot(real(polos_LC(:,1)), imag(polos_LC(:,1)), 'ko', ...
    'MarkerSize', 10, 'LineWidth', 2, 'DisplayName', 'm_l = 0 kg');
plot(real(polos_LC(:,end)), imag(polos_LC(:,end)), 'kp', ...
    'MarkerSize', 12, 'LineWidth', 2, 'DisplayName', 'm_l = 1.5 kg');

title('Desplazamiento de los Polos de LC al variar m_l (0 a 1.5 kg)');
xlabel('Eje Real');
ylabel('Eje Imaginario');
legend('Location', 'best');

colormap(jet);
cb = colorbar;
cb.Label.String = 'm_l (kg)';
caxis([0 1.5]);

hold off;
