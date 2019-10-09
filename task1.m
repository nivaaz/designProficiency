%% TASK 1 DP DSP
close all;
clc
clear
fs = 10e3;       %sampling frequnecy
or = 10;
% t = 0:1:10e3;   %frequency sweep values.
% x = sin((2*pi)/t) 

x = randn(20000,1);

fc_low = 1e3;   %low cut off freq
fc_high = 4e3;  % high cut off freq

fs_low = 100;   %low stop band cut off
fs_high = 4500;  %high stop band cut off must be -17db or more.

% order must be 

% band_fir = designfilt('bandpassfir','FilterOrder',10,'StopbandFrequency1',fs_low, 'PassbandFrequency1',fc_low,'PassbandFrequency2',fc_high, 'StopbandFrequency2',fs_high,'SampleRate', fs)
%  fvtool(band_fir)
% band_iir = designfilt('bandpassiir','FilterOrder',10,'HalfPowerFrequency1',900,'HalfPowerFrequency2',4500, 'SampleRate', fs);
xx = designfilt('bandpassiir', 'FilterOrder', 10, 'PassbandFrequency1', fc_low/fs, 'PassbandFrequency2', fc_high/fs)

% freqz(band_fir)
fvtool(xx)
fc = (fc_low + fc_high)/2

%%
f = @(R1, R2, C1, C2) 1/sqrt(2*pi*R1*R2*C1*C2)

R1 = 32e3;
R2 = 16e3;
C1 = 10e-9;
C2 = 10e-9;

f1_low = f(R1+0.05*R1, R2+0.05*R2, C1+0.1*C1, C2+0.1*C2)
f1_high = f(R1-0.05*R1, R2-0.05*R2, C1-0.1*C1, C2-0.1*C2)

R1 = 2550;
R2 = 3105;
C1 = 20e-9;
C2 = 10e-9;

f2_low = f(R1+0.05*R1, R2+0.05*R2, C1+0.1*C1, C2+0.1*C2)
f2_high = f(R1-0.05*R1, R2-0.05*R2, C1-0.1*C1, C2-0.1*C2)
