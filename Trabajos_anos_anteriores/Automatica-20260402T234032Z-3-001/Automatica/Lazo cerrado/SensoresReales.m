%% Sensor de corriente real
wn_corriente = 18000;  
zeta_corriente = 1;  

A_corriente = [0 1; -wn_corriente^2 -2*zeta_corriente*wn_corriente];
B_corriente = [0; wn_corriente^2];
C_corriente = [1 0];
D_corriente = 0;

fprintf('\nFunción de Transferencia del sensor de corriente Real Gi(s) =\n');
[num_C, den_C] = ss2tf(A_corriente, B_corriente, C_corriente, D_corriente);
Gis = tf(num_C, den_C)

%% Encoder Real
wn_tita = 6000;  
zeta_tita = 1;  

A_tita = [0 1; -wn_tita^2 -2*zeta_tita*wn_tita];
B_tita = [0; wn_tita^2];
C_tita = [1 0];
D_tita = 0;

fprintf('\nFunción de Transferencia del encoder real Gtita(s) =\n');
[num_C, den_C] = ss2tf(A_tita, B_tita, C_tita, D_tita);
Gis = tf(num_C, den_C)

%% Sensor de temperatura real
tau_temp = 20;

A_temp = -1/tau_temp;
B_temp = 1/tau_temp;
C_temp = 1;
D_temp = 0;

fprintf('\nFunción de Transferencia del sensor de temperatura real GTemp(s) =\n');
[num_C, den_C] = ss2tf(A_temp, B_temp, C_temp, D_temp);
GTemps = tf(num_C, den_C)

%% Inversor trifásico de tensión real
wn_inv = 18000;  
zeta_inv = 1;   
Vs_max = 48 * sqrt(2) / sqrt(3); % Límite de saturación

A_inv = [0 1; -wn_inv^2 -2*zeta_inv*wn_inv];  
B_inv = [0; wn_inv^2]; 
C_inv = [1 0];  
D_inv = 0;  

fprintf('\nFunción de Transferencia del inversor trifásico de tensión real Ginv(s) =\n');
[num_C, den_C] = ss2tf(A_inv, B_inv, C_inv, D_inv);
Ginvs = tf(num_C, den_C)