function [v_a,v_b,v_c]=Controlador(w_cons,theta_m,i_a,i_b,i_c,T_s,g)    
    %%Variables auxiliares
    P_p=3;
    T_sREF = 20;
    alpha_cu=3.9*10^-3;
    R_sREF=1.02;
    theta_r=theta_m*P_p;

    %Variables Observador
    K_obs_theta=9600;
    K_obs_w=30720000
    K_obs_i=3.2768e+10;
    persistent theta_m_obs;
    persistent e_theta_ant;
    persistent int_e_theta_ant;
    persistent w_m_obs_ant;
    persistent dw_m_obs_ant;
    persistent theta_m_obs_ant;
    persistent dtheta_m_obs_ant;

    %Variables PID
    
    persistent T_m_cons;

    %Variables persistentes
    persistent init;
    
    
   if isempty(init)
        init = true;
        
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
    e_theta=theta_m-theta_m_obs
    [int_e_theta,int_e_theta_ant,e_theta_ant]=integralTustin(e_theta,int_e_theta_ant,e_theta_ant);
    dw_m_obs=K_obs_i*int_e_theta+K_obs_w*e_theta+T_m_cons/J_nom;
    [w_m_obs,w_m_obs_ant,dw_m_obs_ant]=integralTustin(dw_m_obs,w_m_obs_ant,dw_m_obs_ant);
    dtheta_m_obs=w_m_obs+K_obs_theta*e_theta;
    [theta_m_obs,theta_m_obs_ant,dtheta_m_obs_ant]=integralTustin(dtheta_m_obs,theta_m_obs_ant,dtheta_m_obs_ant);
    %%PID
    













%%Transformada de park inversa
v_abc = [cos(theta_r), sin(theta_r), 1;
         cos(theta_r - 2*pi/3), sin(theta_r - 2*pi/3), 1;
         cos(theta_r + 2*pi/3), sin(theta_r + 2*pi/3), 1] * [v_q;v_d;v_0];
v_a=v_abc(1);
v_b=v_abc(2);
v_c=v_abc(3);
end

function [y,y_ant,x_ant]=integralTustin(x,y_ant,x_ant)
    y=y_ant+T_s/2 * (x+x_ant);
    y_ant=y;
    x_ant=x;
end