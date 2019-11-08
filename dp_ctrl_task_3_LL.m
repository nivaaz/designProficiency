%% DESIGN FOR LEAD LAG CONTROLLER!
% OUR FUNCTION 
%what we want.
clc
clear
close all
%measured tf
num = 0.2152;
den = [1 6.1746 21.0166];

%with delay 
num_d = 0.2152;
den_d = [1 10.2241 66.9617];

OS = 0.05;
ESS = 10; %less than or equal to.
TP = 0.5;

%functions.
zeta =@(os) -log(os)/(sqrt(pi^2+log(os)^2));
wn = @(tp, z) pi/(tp*sqrt(1-z^2));

z_i = zeta(OS);     %working out ideal params
wn_i = wn(TP, z_i);
pole_i = [-z_i*wn_i+j*wn_i*sqrt(1-z_i^2) -z_i*wn_i-j*wn_i*sqrt(1-z_i^2)] %ideal poles.

%transfer function of both.
tf_in_d = tf(num, den, "IODelay", 0.14);
tf_in = tf(num, den)
tfn = @(s) 0.2152/(s^2 + 10.22*s + 66.96);
tfn_d = @(s) exp(-0.14*s)*0.2152/(s^2 + 10.22*s + 66.96);

%ERROR 
err = 1/(0.2152/21.02)
ang = angle(tfn(pole_i(1)))
zc = imag(pole_i(1))/tan(ang) + real(pole_i(1))

% work out ideal tf.
k_pole_i = abs(1/tfn(pole_i(1)))
angle_pole_i = angle(tfn(pole_i(1)));
angle_pole_i = radtodeg(angle_pole_i)

zc = (imag(pole_i(1)))/tand(angle_pole_i) - real(pole_i(1))
pc = 0.001;
s = tf('s');

%lead repsonse.
pcl = -40;
zcl =  real(pole_i(1));

% LAG RESPONSE.
pc = 0.0001;
zc = 0.001*0.1;
zcl =6
pcl = 40

lag = (s+zc)/(s+pc)
lag_s =@(s) (s+zc)/(s+pc)

lead = (s+zcl)/(s+pcl)
lead_s =@(s) (s+zcl)/(s+pcl)

c = lag_s(pole_i)*(tfn(pole_i(1)))
K = 1/abs(c)
final = K*lag*tf_in*lead
f = final/(1+final);
step(13.5*f)
