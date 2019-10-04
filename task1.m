% Task 1

freq_c = @(f,r) 1/(2*pi*f*r)
freq_r = @(f,r) 1/(2*pi*f*r)

fL = 1e3
fH = 4e3

fc = sqrt(fL*fH)
fbw = fH-fL

Q = fc/fbw

20*log(Q)

% low pass 
cL = 0.1e-6;
RL = 1/(2*pi*fL*cL);
RL/(1e3);%kohms
fprintf("\n RL,%d k ohms", RL/(1e3))

% high pass
cH = 0.1e-6;
RH = 1/(2*pi*fH*cH);
RH/(1e3); %kohms
fprintf("\n RH,%d k ohms", RH/(1e3))

%% plotting code 
Fs = 10e3;
t = (0:2*pi)'/Fs; 
x = sin(2*pi*xx);

lowpass()
