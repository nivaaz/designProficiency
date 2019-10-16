%% OPEN FILE.
% [data_in, fs] = audioread('C:\Users\nkseh\OneDrive\Documents\Uni-Vazzy\dp\DSP\Task 4test_files\1.wav');
clc
close all
[data_in1, fs] = audioread('C:\Users\nkseh\OneDrive\Documents\Uni-Vazzy\dp\DSP\5.wav');
[data_in2, fs] = audioread('C:\Users\nkseh\OneDrive\Documents\Uni-Vazzy\dp\DSP\15.wav');
[data_in3, fs] = audioread('C:\Users\nkseh\OneDrive\Documents\Uni-Vazzy\dp\DSP\25.wav');
y1 = isSpeaking(data_in1, fs);
y2 = isSpeaking(data_in2, fs);
y3 = isSpeaking(data_in3, fs);

%  NEW ALGO
n_plot = 3;                 %how many plots.
n=0;                        %plotting number.

in_fft = abs(fft(data_in1)).^2;
% data_high = bandpass(data_in1,[200,2000],fs,'Steepness',0.99);       %filtering data.
dt_fft = abs(fft(data_high));
f_fft = linspace(1, fs/2, length(in_fft));
%
figure;
subplot(3, 1, 1);
hold on;
stem(y1);
plot(1:length(data_in1), data_in1);
legend(["Input", "isSpeaking"]);

subplot(3, 1, 2);
hold on;
stem(y1);
plot(1:length(data_in2), data_in2);
legend(["Input", "isSpeaking"]);

subplot(3, 1, 3);
hold on;
stem(y1);
plot(1:length(data_in3), data_in3);
legend(["Input", "isSpeaking"]);
%plot of first really big.

figure;
hold on;
stem(y1);
plot(1:length(data_in1), data_in1);
legend(["Input", "isSpeaking"]);

function speaking = isSpeaking(data_in, fs)
    T = 1/fs;
    N = length(data_in);
    speaking = zeros(1,N);
    
    %   START OF COMPUTATION.
    step = floor((30e-3)/T);                             %20 ms
    f_en = abs(data_in.^2);                              %ENERGY OF DATA IN    
    b = mean(f_en)                                       %mean of the entire signal.
    
    for i = step:(N-2*step)
        speaking(i) = b/150 < mean(f_en(i:i+step));     %magic number.
    end
end
