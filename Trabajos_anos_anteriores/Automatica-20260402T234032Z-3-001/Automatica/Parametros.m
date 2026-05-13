% CONDICIONES INICIALES %
tita0 = 0;
wm0 = 0;
iq0 = 0;
id0 = -0.5;
io0 = 0;
Ts0 = 40;

% MODELO DE LA CARGA %
g = 9.81;                           %m/s^2      Gravedad
bl = 0.1;                           %N.m/rad/s  Coeficiente de fricción de la articulación
m = 1;                              %kg         Masa del brazo
Lcm = 0.25;                         %m          Distancia de la articulación al centro de masa del brazo
Jcm = 0.0208;                       %kg.m^2     Momento de inercia del brazo
Ll = 0.5;                           %m          Longitud total del brazo
ml = 1.5;                           %kg         Puede variar entre 0 y 1.5kg, masa que recoge el brazo
Jl = m * Lcm^2 + Jcm + ml * Ll^2;   %kg.m^2     Momento de inercia total del brazo mas la carga
Tld = 0;                            %N.m        Puede variar entre 0 y 5N.m, torque de carga
kl = m * Lcm + ml * Ll;             %kg.m       Constante para calcular momento debido al peso del brazo y de la carga

% MODELO DEL MOTOR Y CAJA REDUCTORA %
r = 120;                            %Relación de transmisión de la caja reductora
Jm = 14 * 10^(-6);                  %kg.m^2     Inercia del rotor mas caja reductora
bm = 15 * 10^(-6);                  %N.m/rad/s  Coeficiente de fricción del rotor mas caja reductora
Pp = 3;                             %Pares de polos del estator
lambda_m = 0.016;                   %V/rad/s    Flujo concatenado
Lq = 5.8 * 10^(-3);                 %H          Inductancia del eje en cuadratura
Ld = 6.6 * 10^(-3);                 %H          Inductancia del eje directo
Lls = 0.8 * 10^(-3);                %H          Inductancia de dispersión
Rs = 1.02;                          %Ohm        Resistencia de cada estator a 20ºC
alfa = 3.9 * 10^(-3);               %1/ºC       Coeficiente de aumento de la resistencia
Cts = 0.818;                        %W/ºC/s     Capacitancia termica del estator
Rts_amb = 149.7;                    %ºC/W       Resistencia termica entre el estator y el ambiente
Tau_t = Rts_amb * Cts;              %s          Constante de tiempo del sistema térmico
KTeq = (3/2) * Pp * lambda_m;       %Nm/A       Constante de Torque
KEeq = (2/3) * KTeq;                %V/rad/s    Constante de inducción

% PARAMETROS EQUIVALENTES DEL SISTEMA MOTOR + CAJA + CARGA %
Jeq = Jm + Jl/(r^2);                %kg.m^2     Momento de inercia equivalente de todo el sistema mecánico
beq = bm + bl/(r^2);                %N.m/rad/s  Coeficiente de fricción equivalente de todo el sistema mecánico

% ESPECIFICACIONES DE OPERACIÓN
Wlnom = 2*pi;                       %rad/s      Velocidad nominal (salida)
Tqnom = 17;                         %Nm         Torque nominal (salida)
Wmnom = 691.15;                     %rad/s      Velocidad nominal rotor
Vslnom = 30;                        %V          Tensión nominal de línea
Vflnom = Vslnom/sqrt(3);            %V          Tensión nominal de fase
Isnom = 0.4;                        %A          Corriente nominal
Ismax = 2;                          %A          Corriente máxima
Tsmax = 115;                        %°C         Tenperatura maxima
Vslmax = 48;                        %V          Módulo de tensión de línea máximo
Vsat = Vslmax * sqrt(2) / sqrt(3);  %V          Limite de saturación
femax = 330;                        %Hz         Frecuencia síncrona máxima