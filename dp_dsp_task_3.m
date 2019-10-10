% Task 3: Digital Demodulation (L1)
close all
clc
clear

fs = 192e3;  %from specs.
bw = 44.1e3; %from specs.
%
t = 1:500;
fc = rand(1);
fm = rand(1);
Ac = rand(1)*10; %carrier amplitude.
Am = rand(1)*10; %modulation amplitude.

c = 0.5*sin(pi*t*fc/20)+0.5*sin(pi*t*fc/17);
m = sin(pi*t*fm*50);
data_carr_wave = Ac*c;
data_mod_wave = Am*m;
data_in_wave = ((Am*m+Ac).*c);

% FFT FOR ALL 
carr_fft = abs(fft(data_carr_wave)).^2;
mod_fft = abs(fft(data_mod_wave)).^2;
in_fft = abs(fft(data_in_wave)).^2;
% SQUARED AND THEN FFT

in2_fft = abs(fft(data_in_wave.^2)).^2;

y = lowpass(data_in_wave.^2, 10000/fs);
y_sq = y.^1/2;

% figure; 
% plot(t, y, t, data_in_wave);
% title("low passed data");
% legend(["lowpassed data in", "data in"]);

figure;
subplot(2, 3, 1);
plot(t, data_mod_wave, t, data_carr_wave, t, data_in_wave);
ylabel("Amplitude");
xlabel("Period");
title("Input waves");
legend(["Modulator", "Carrier", "Output"]);

subplot(2, 3, 2);
plot(t, data_in_wave, t, data_in_wave.^2);
ylabel("Amplitude");
xlabel("Period");
title("Input signal (modulated wave)");
legend(["Data in", "Data in squared"])

subplot(2, 3, 3);
plot(t, mod_fft, t, carr_fft);
ylabel("Amplitude");
xlabel("Hz");
title("Input signal (FFT)");
legend(["Modulator", "Carrier"]);

subplot(2, 3, 4);
plot(t, in_fft, t, in2_fft);
ylabel("Amplitude");
xlabel("Hz");
legend(["input ftt", "input squared fft"])
title("Output signal (FFT)");

subplot(2, 3, 5);
plot(t, lowpass(in_fft.^2, 500/fs));
ylabel("Amplitude");
xlabel("Hz");
title("Output signal (FFT)");

subplot(2, 3, 6);
plot(t, y_sq, t, data_carr_wave.^2,t, (data_carr_wave-y_sq).*sin(72*t) );
ylabel("Amplitude");
xlabel("Hz");
title("Output signals");
legend(["lowpass squared", "Carrier"])
%%
close all
figure;
subplot(1, 2, 1);
wave_out = (data_carr_wave-y_sq).*sin(72*t)
wave_out_fft = abs(fft(wave_out)).^2;

plot(t,wave_out , t, data_in_wave);
legend(["output", "input", "exp"])

subplot(1, 2, 2);
plot(t,wave_out_fft , t, in_fft);
legend(["output", "input", "exp"])

%%
data_in = rand(1, length(t))+sin(t/pi);

f = fft(data_in)
F = abs(f).^2;
subplot(2, 2, 1);
plot(t, data_in);
ylabel("input data");

subplot(2, 2, 2);
plot(t, abs(f).^2);
ylabel("input data");

%find the highest frequency 
% create a sine wave of this frequency
% subtract it from data_in
%%plot the output signal?

max(F)
% subplot(2, 2, 3);
% plot(t, data_in);
% ylabel("input data");
% 
% subplot(2, 2, 4);
% plot(t, data_in);
% ylabel("input data");

title("input data");
%% 
