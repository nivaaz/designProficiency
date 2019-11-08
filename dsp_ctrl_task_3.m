close all
clear
clc

%what we want.
OS = 0.05;
ESS = 0;
TP = 0.5;

%function.
zeta =@(os) -log(os)/(sqrt(pi^2+log(os)^2));
wn = @(tp, z) pi/(tp*sqrt(1-z^2));

% work out ideal tf.
z_i = zeta(OS)
wn_i = wn(TP, z_i)
pole_i = [-z_i*wn_i+j*wn_i*sqrt(1-z_i^2) -z_i*wn_i-j*wn_i*sqrt(1-z_i^2)]

%tp = pi/(wn*sqrt(1-zeta^2));
%os = -100*zeta*pi/exp(1-zets^2)

%measured tf
num = 0.2152;
den = [1 6.1746 21.0166];

%with delay 
num_d = 0.2152;
den_d = [1 10.2241 66.9617];

%transfer function of both.
tf_in_d = tf(num, den, "IODelay", 0.14);
tf_in = tf(num, den)

tfn = @(s) 0.2152/(s^2 + 10.22*s + 66.96);
tfn_d = @(s) exp(-0.14*s)*0.2152/(s^2 + 10.22*s + 66.96);

fprintf(2, "------ EQUATING THE CHAR EQNS ------")
'coef of s'
2*z_i*wn_i
'wn^2'
wn_i^2

%characteristics 
dc_gain = dcgain(tf_in);
p_in = pole(tf_in);
% zero(tf_in)

%   without delay. 
%         0.2152
%   ---------------------
%   s^2 + 10.22 s + 66.96

%   with delay. 
%                         0.2152
%   exp(-0.14*s) * ---------------------
%                  s^2 + 10.22 s + 66.96

%ideal char
fprintf(2, "------ IDEAL CHAR EQNS ------")
s = tf('s');
ideal_char = (s-pole_i(2))*(s-pole_i(1))

% ROOT LOCUS.
%gain 
close all
pt_c = tfn(pole_i(1));  %point at s=ideal poles.
gain_c = 1/abs(pt_c)    
angle_c = angle(pt_c)
radtodeg(angle_c)

%angle contribution.
ang = real(pole_i(1))/tan(angle_c) %+ abs(real(p_in(1)))

% step(tf_in);
% output for a pd controller.
Kp = (75.38-66.96)/0.2152
Kd = (11.98-10.22)/0.2152

Gpd = 8.42+s*1.76;  %pd controller.
Gpi = (s+5.9)/s   %pi controller. 

f = 12*Gpd*Gpi*tf_in

step((f)/(1+(f)))

[y, t] = step(f/(1+f));

peak = max(y)
ss = y(length(y))
os = (peak - ss)/ss * 100
% 
% %% PID
% %PD 
% clc
% close all
% 
% OS = 0.05;
% ESS = 0;
% TP = 0.5;
% 
% z_i = zeta(OS)
% wn_i = wn(TP, z_i)
% pole_i = [-z_i*wn_i+j*wn_i*sqrt(1-z_i^2) -z_i*wn_i-j*wn_i*sqrt(1-z_i^2)]
% 
% K = 1;
% Kd = 0;
% 
% pt_c = tfn(pole_i(1));  %point at s=ideal poles.
% gain_c = 1/abs(pt_c)    
% angle_c = angle(pt_c);  % ANGLE CONTRIBUTION @ IDEAL.
% 'angle contribution'
% radtodeg(angle_c)       %in degrees.
% 
% cl = tf_in/(1+tf_in)    %closedloop transfer function
% Kd = abs(imag(pole_i(1))/tan(angle_c) - real(pole_i(1))) %finding the zero loc.
% pd = @(s) (s+Kd)   %PD transfer function
% 
% K = abs(1/((tfn(pole_i(1))*pd(pole_i(1))))) % gain compensation
% pd_s =@(s) K*(s+Kd) %symbolic function 
% pd_tf = K*(s+Kd)        %transfer function
% 
% %PI controller.
% Ki = 0.0001   %pole for the pi
% pi_tf = (s+Ki)/s           % PI TRANSFER FUNCTION
% pi_s = @(s)(s+Ki)/s;   % 
% 
% pid = pi_tf*pd_tf;
% final_tf = tfn(pole_i(1))*pd_s(pole_i(1))*pi_s(pole_i(1))
% Kpi = abs(1/final_tf)
% 
% pid_tf = pid*tf_in %final transfer function
% 
% [y, t] = step(pid_tf/(1+pid_tf));
% peak = max(y)
% ss = y(length(y))
% os = (peak - ss)/ss * 100
% 
% step(pid_tf/(1+pid_tf))
% %% PD Overshoot less than or equal to 1% (%?? ? 1), peak time less than or equal to 1 sec (?? ? 1)
% % and zero steady state error (??? = 0%).
% close all
% 
% OS = 0.01
% TP = 1
% % working out new ideal poles.
% z_i = zeta(OS)
% wn_i = wn(TP, z_i)
% pole_i = [-z_i*wn_i+j*wn_i*sqrt(1-z_i^2) -z_i*wn_i-j*wn_i*sqrt(1-z_i^2)]
% 
% pt_c = tfn(pole_i(1));  %point at s=ideal poles.
% gain_c = 1/abs(pt_c)    
% angle_c = angle(pt_c)
% radtodeg(angle_c)
% 
% a = 2*z_i*wn_i - 66.96
% 
% b = wn_i^2 - 66.96
% 
% Gpd = a+s*b;
% 
% step(-Gpd*tf_in)
% 
% %% PID
% close all
% OS = 0.1
% TP = 2
% % working out new ideal poles.
% z_i = zeta(OS)
% wn_i = wn(TP, z_i)
% pole_i = [-z_i*wn_i+j*wn_i*sqrt(1-z_i^2) -z_i*wn_i-j*wn_i*sqrt(1-z_i^2)]
% 
% %PD 
% pt_c = tfn(pole_i(1));  %point at s=ideal poles.
% gain_c = 1/abs(pt_c)    
% angle_c = angle(pt_c)
% radtodeg(angle_c)
% 
% K = 1/gain_c
% 
% zd = imag(pole_i(1))/tan(angle_c) - real(pole_i(1)) %finding the zero loc.
% pd = s + zd
% 
% %PI
% pi = (s+0.00005)/s
% 
% pid = pi*zd;
% pid_tf = pid*tf_in
% dcgain(pid_tf)
% 
% step(pid_tf)
% %% lead lag?
% close all
% clc
% fprintf(2, "------ LEAD LAG ------")
% % Design a lead-lag controller that can satisfy an overshoot of less than or equal to 5% (%?? ? 5), a
% % peak time of less than or equal to 1 sec (?? ? 1) and a steady state error of less than or equal to 10%
% % (??? ? 10%).
% OS = 0.05
% Tp = 1
% ESS = 0.1;
% 
% zlead = 1;
% plead = 1;
% zlag = 1;
% plag = 1;
% leadlag =(s+zlead)*(s+zlag)/((s+plead)*(s+plag))
% 
% %ideal poles
% z_i = zeta(OS)
% wn_i = wn(TP, z_i)
% pole_i = [-z_i*wn_i+j*wn_i*sqrt(1-z_i^2) -z_i*wn_i-j*wn_i*sqrt(1-z_i^2)]
% 
% ideal = s^2 + 2*(z_i*wn_i)*s + wn_i^2
% 
% pt_c = tfn(pole_i(1));  %point at s=ideal poles.
% gain_c = 1/abs(pt_c)    
% angle_c = angle(pt_c);
% radtodeg(angle_c)
% 
% %starting with lag design.
% plag = 0.001;
% 
% %%
