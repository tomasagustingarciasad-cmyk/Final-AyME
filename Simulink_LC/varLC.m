clc, clear
% CONDICIONES INICIALES %
tita0 = 0;
wm0 = 0;
iq0 = 0;
id0 = 0.5;
io0 = 0;
Ts0 = 40;


% MODELO DE LA CARGA %
g = 9.80665;                        %m/s^2      Gravedad
b_l = 0.1;%%%%                      %N.m/rad/s  Coeficiente de fricción de la articulación
m = 1;                              %kg         Masa del brazo
L_cm = 0.25;                        %m          Distancia de la articulación al centro de masa del brazo
J_cm=0.0208;                        %kg.m^2     Momento de inercia del brazo
L_l = 0.5;                          %m          Longitud total del brazo
m_l = 0;%%%%                        %kg         Puede variar entre 0 y 1.5kg, masa que recoge el brazo
J_l=(m*(L_cm^2)+J_cm)+m_l*(L_l^2);  %kg.m^2     Momento de inercia total del brazo mas la carga
k_l = m * L_cm + m_l * L_l;         %kg.m       Constante para calcular momento debido al peso del brazo y de la carga
%T_ld = 2.5;  (Ver especificaciones de operación)



% CAJA REDUCTORA %
r = 120/1;                          %Relación de transmisión de la caja reductora



% PARÁMETROS: tolerancia error +/- 1% %
J_m = 14.0*10^-6;                   %kg.m^2   Momento de inercia (motor y caja) 
b_m = 15.0*10^-6;                   %N*m/rad/s   Coef. de fricción viscosa (motor y caja)
P_p = 3;                            %Pares de polos del estator
lambda_m = 0.016;                   %V/rad/s    Flujo magnetico equivalente de imanes concatenado por espiras del bobinado del estator
L_q=5.8 * 10^(-3);                  %H          Inductancia de estator (eje en cuadratura)
L_d = 6.6 * 10^(-3);                %H          Inductancia del estator (eje directo)
L_ls = 0.8 * 10^(-3);               %H          Inductancia de dispersión de estator
R_sREF=1.02;                        %Ohm        Resistencia de estator por fase a 20ºC (Rs)
T_sREF = 20;
alpha_cu=3.9*10^-3;                 %1/ºC       Coeficiente de aumento de la resistencia Rs con T°
C_ts=0.818;                         %W/ºC/s     Capacitancia termica del estator
R_ts_amb=146.7;                     %ºC/W       Resistencia termica entre el estator y el ambiente
tau_ts_amb=R_ts_amb*C_ts;           %s          Constante de tiempo del sistema térmico



% PARAMETROS EQUIVALENTES DEL SISTEMA MOTOR + CAJA + CARGA %
J_eq = J_m + J_l/(r^2);
b_eq = b_m + b_l/(r^2);


% ESPECIFICACIONES DE OPERACIÓN
T_amb = 40;%%%%%%%%%%%              %°C      Rango de temperatura ambiente: −15°𝐶≤𝑇𝑎𝑚𝑏° (𝑡)≤40°C




% Cálculo de Rs a la temperatura inicial (Ts0)
R_s_actual = R_sREF * (1 + alpha_cu * (Ts0 - 20));




% ESPECIFICACIONES DE OPERACIÓN
T_ld = 2.5;  %%%%                   %N.m        Puede variar entre -5 y 5 N.m, torque de carga (Asumir funcion escalon)
nl_nom = 2*pi; %(60 rpm)            %rad/s      Velocidad nominal (salida)
Tq_nom = 17;                        %Nm         Torque nominal (salida)
Tq_max = 45;                        %Nm         Torque pico (salida) (corta duracion, aceleracion)
nm_nom = 691.15;                    %rad/s      Velocidad nominal rotor (6600rpm)
V_sl_nom = 30;                      %V          Tensión nominal de línea
Vflnom = V_sl_nom/sqrt(3);          %V          Tensión nominal de fase
Isnom = 0.4;                        %A          Corriente nominal (regimen continuo)
Ismax = 2;                          %A          Corriente máxima (corta duración)
Tsmax = 115;                        %°C         Tenperatura maxima
%Rango de temperatura ambiente −15°𝐶≤𝑇𝑎𝑚𝑏° (𝑡)≤40°C
Vslmax = 48;                        %V          Módulo de tensión de línea máximo
Vsat = Vslmax * sqrt(2) / sqrt(3);  %V          Limite de saturación
femax = 330;                        %Hz         Frecuencia síncrona máxima (rango de -330 a 330)

%Lazo de control
R_q=29;
R_d=33;
R_0=4;

%PID

w_n_PID=800;
zeta_PID=0.75;

b_a=J_eq*(2*zeta_PID+1)*w_n_PID;
K_a=J_eq*(2*zeta_PID+1)*w_n_PID^2;
K_ai=J_eq*w_n_PID^3;

%Observador

K_obs_theta=6400;
K_obs_w=10240000;

