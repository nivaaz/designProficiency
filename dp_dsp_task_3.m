% task 3
% Task 3: Digital Demodulation (L1)
close all
clc
clear

X=load('C:\Users\nkseh\OneDrive\Documents\Uni-Vazzy\dp\DSP\Task 3 Datasets\Set7.mat');
Y=load('C:\Users\nkseh\OneDrive\Documents\Uni-Vazzy\dp\DSP\Task 3 Datasets\Noise.mat');
noise_in = Y.noise;  %noise to subtract later..

fs = 192e3;
t = 1:length(noise_in);

data_in_wave = X.S - noise_in;              %removing the noise.
in_fft = abs(fft(data_in_wave)).^2;         %input signal fft.
n = length(data_in_wave);                   % number of samples
t_fft = (0:n-1)*(fs/n);                     % frequency range (fs = sampling frequency)

%DE MODULATION ALGO.
data_out_wave = data_in_wave;               %DATA OUTPUT WAVE.
f_amp_max = max(in_fft)
f_max = find(in_fft(2:length(in_fft)) == f_amp_max)          %find the max ampl location.
fx = t_fft(f_max(1))                                        %CARRIER FREQUENCY.
fx = 10750;

% FFT FOR OUTPUT SIGNALS.
% out_fft = abs(fft(data_out_wave)).^2;       %input signal fft.
% m_fft = abs(fft(m_wave)).^2;                %input signal fft.
% plot(t_fft, in_fft)
t = (0:length(data_in_wave)-1)/fs;
data_out_wave = data_in_wave.*cos(2*pi*fx*t) ;
data_out_wave1 = data_in_wave.*sin(2*pi*fx*t) ;

% filter out aliased copies
[num,den] = butter(14,fx/fs);
sigI = filter(num,den,data_out_wave);    
sigQ = filter(num,den,data_out_wave1);

p = audioplayer(sigI, fs);
play(p, fs);

%% 1
p = audioplayer(sigI, fs);
play(p, fs);

%% 2
p = audioplayer(sigI, fs);
play(p, fs);
%% 3
p = audioplayer(sigQ, fs);
play(p, fs);

%% 4
p = audioplayer(sigI, fs);
play(p, fs);

%% 5
p = audioplayer(sigI, fs);
play(p, fs);

%% 6
p = audioplayer(sigI, fs);
play(p, fs);

%%
p = audioplayer(sigQ, fs);
play(p, fs);

%% plotting code.
figure;
subplot(3, 1, 1);
plot(t, data_out_wave);
title("data input wave");
legend(["input", "output0"]);

subplot(3, 1, 2);
plot(t_fft, in_fft, t_fft, out_fft, t_fft, m_fft);
title("input wave fft")
legend(["input", "output", "sin wave test"]);

subplot(3, 1, 3);
plot(t, data_out_wave, t, data_out_wave1);
title("data input wave");
legend(["out sin", "out cos"]);
