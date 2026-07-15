function [v_a,v_b,v_c,theta_m_obs_s,w_m_est,T_m_cons_s]=Controlador(w_m_cons,i_d_cons,theta_m,i_a,i_b,i_c,T_s,g)    
    %%Variables auxiliares
    P_p=3;
    T_sREF = 20;
    alpha_cu=3.9*10^-3;
    R_sREF=1.02;
    J_nom=1.9785e-5;

    theta_r=theta_m*P_p;
    

    %Variables Observador
    K_obs_theta=6400;
    K_obs_w=10240000;
    persistent theta_m_obs;
    persistent w_m_obs_ant;
    persistent dw_m_obs_ant;
    persistent theta_m_obs_ant;
    persistent dtheta_m_obs_ant;

    %Variables PID

    w_n_PID=800;
    zeta_PID=0.75;

    b_a=J_nom*(2*zeta_PID+1)*w_n_PID;
    K_a=J_nom*(2*zeta_PID+1)*w_n_PID^2;
    K_ai=J_nom*w_n_PID^3;
    
    persistent T_m_cons;
    persistent theta_m_cons_ant;
    persistent w_m_cons_ant;
    persistent int_e_theta_m_PID_ant;
    persistent e_theta_m_PID_ant;


    %Variables persistentes
    persistent init;
    
    
   if isempty(init)
        init = true;
        
        theta_m_obs=0;
        w_m_obs_ant=0;
        dw_m_obs_ant=0;
        theta_m_obs_ant=0;
        dtheta_m_obs_ant=0;

        T_m_cons=0;
        theta_m_cons_ant=0;
        w_m_cons_ant=0;
        int_e_theta_m_PID_ant=0;
        e_theta_m_PID_ant=0;
   end
    %%
    %%Estimacion de resistencia
    R_s=R_sREF*(1+alpha_cu*(T_s-T_sREF));
    
    %%
    %%Transformada de park directa
    i_qd0 = 2/3 * [cos(theta_r), cos(theta_r - 2*pi/3), cos(theta_r + 2*pi/3);
                    sin(theta_r), sin(theta_r - 2*pi/3), sin(theta_r + 2*pi/3);
                    1/2, 1/2, 1/2] * [i_a;i_b;i_c];
    i_q=i_qdo(1);
    i_d=i_qd0(2);
    i_0=i_qd0(3);
    %%
    %%Observador
    e_theta_m_obs=theta_m-theta_m_obs;
    dw_m_obs=K_obs_w*e_theta_m_obs+T_m_cons/J_nom;
    [w_m_obs,w_m_obs_ant,dw_m_obs_ant]=integralTustin(dw_m_obs,w_m_obs_ant,dw_m_obs_ant);
    dtheta_m_obs=w_m_obs+K_obs_theta*e_theta_m_obs;
    [theta_m_obs,theta_m_obs_ant,dtheta_m_obs_ant]=integralTustin(dtheta_m_obs,theta_m_obs_ant,dtheta_m_obs_ant);
    w_m_est=dtheta_m_obs;
    %%
    %%PID
    e_w_m_PID=w_m_cons-w_m_est;
    [theta_m_cons,theta_m_cons_ant,w_m_cons_ant]=integralTustin(w_m_cons,theta_m_cons_ant,w_m_cons_ant);
    e_theta_m_PID=theta_m_cons-theta_m;
    [int_e_theta_m_PID,int_e_theta_m_PID_ant,e_theta_m_PID_ant]=integralTustin(e_theta_m_PID,int_e_theta_m_PID_ant,e_theta_m_PID_ant);
    T_m_cons=b_a*e_w_m_PID+K_a*e_theta_m_PID+K_ai*int_e_theta_m_PID;
    %%
    %%MODULADOR DE TORQUE
    %Desacople de tensiones
    i_q_cons=(T_m_cons+b_nom*w_m_est+(k_l_nom*g)/(r)*sin(theta_m/r))/(3*P_p/2*((L_d-L_q)*i_d+lambda_m));
    %Lazos de corriente
    v_q_cons=R_q(i_q_cons-i_q);
    v_d_cons=R_d(i_d_cons-i_d);
    v_0_cons=R_0(i_0_cons-i_0);

    v_q=v_q_cons+R_s*i_q+(lambda_m+L_d*i_d)*P_p*w_m_est;
    v_d=v_d_cons+R_s*i_d-L_q*i_q*P_p*w_m_est;
    v_0=v_0_cons+R_s*i_0;

    %%Transformada de park inversa
    v_abc = [cos(theta_r), sin(theta_r), 1;
             cos(theta_r - 2*pi/3), sin(theta_r - 2*pi/3), 1;
             cos(theta_r + 2*pi/3), sin(theta_r + 2*pi/3), 1] * [v_q;v_d;v_0];
    v_a=v_abc(1);
    v_b=v_abc(2);
    v_c=v_abc(3);

    %Salidas persistentes
    theta_m_obs_s=theta_m_obs;
    T_m_cons_s=T_m_cons;
end

function [y,y_ant,x_ant]=integralTustin(x,y_ant,x_ant)
    y=y_ant+T_s/2 * (x+x_ant);
    y_ant=y;
    x_ant=x;
end