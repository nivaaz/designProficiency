clc
close all

% MAKE A RANDOM IMAGE
sendImage = floor(rand([8 8])*255);

% modulate signal
fs = 10e3;
fc1 = 9.3e3;        %carrier off frequency 1
fc2 = 1.1e3;        %carrier off frequency 1

t = 0:1/fs:10e-3;            %timing
sz = floor(length(t)/9);
len = length(t);

carr1 = sin(2*pi*t*fc1);    %carrier signal 1
carr2 = sin(2*pi*t*fc2);    %carrier signal 2

sig1 = zeros(1, length(t)); %signal1
sig2 = zeros(1, length(t));

sampleImage1 = 0.5*[1 1 1 0 1 1 1 0];    %sample signal
sampleImage2 = 0.5*[0 0 0 1 1 1 0 0];    %sample signal

t_high = 10/fs;
%
for c = 1:8%for all the time.
    sig1(sz*c:sz*c+sz) = sampleImage1(c);
    sig2(sz*c:sz*c+sz) = sampleImage2(c);
end

modsig1 = sig1.*carr1;  %modulated signal 1
modsig2 = sig2.*carr2;  %modulated signal 2
x = modsig1+modsig2;

% plotting code.
subplot(4, 1, 1);
plot(t, sig1 ,t, carr1);
legend(["signal input" "carrier signal"])

subplot(4, 1, 2);
plot(t, sig2 ,t, carr2);
legend(["signal input" "carrier signal"])

subplot(4, 1, 3);
plot(t, x);
legend(["Output Signal (Modulated)"])

f = abs(fft(x)).^2;
subplot(4, 1, 4);
plot(t, modsig1, t, modsig2);
legend(["one" "two"])
