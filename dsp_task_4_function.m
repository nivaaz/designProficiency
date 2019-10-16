% dp_dsp_task_4.m
% speech stop and start recognition

%% OPEN FILE.
% [data_in, fs] = audioread('C:\Users\nkseh\OneDrive\Documents\Uni-Vazzy\dp\DSP\Task 4test_files\1.wav');
clc
close all

[data_in, fs] = audioread('C:\Users\nkseh\OneDrive\Documents\Uni-Vazzy\dp\DSP\9.wav');

%  NEW ALGO
function speaking = isSpeaking(data_in, fs)
    T = 1/fs;
    in_fft = abs(fft(data_in)).^2;
    f_fft = linspace(1, fs/2, length(in_fft));  

    data_high = bandpass(data_in,[200,1000],fs,'Steepness',0.99);       %filtering data.
    in_fft_h = abs(fft(data_high)).^2;                                  %FFT data.

    N = length(data_in);    %length data.
    f_en = data_in.^2;
    f_en_h = log(data_high.^2);

    figure;
    n_plot = 3; %how many plots.
    n=0; %plotting number.

    speaking = zeros(1, N);
    step = floor((30e-3)/T)    %20 ms
    a = sum(f_en_h(1:step))
    b = mean(f_en_h)

    for i = step:(N-2*step)
    %    speaking(i) =  1.5*sum(f_en_h(1:step)) < sum(f_en_h(i:(i+step))); % noise > power.
        speaking(i) =  (a-b) < sum(f_en_h(i:(i+1.2*step))); % noise > power.
    end

%     p = audioplayer(data_in, fs);
%     play(p, fs);
end

% subplot(1, n_plot, 1);
% plot(f_fft, in_fft,  f_fft, in_fft_h);
% title("FFT");
% legend(["Input", "Filtered"])
% 
% subplot(1, n_plot, 2);
% plot(1:length(f_en), f_en,1:length(f_en), f_en_h, 1:length(speaking), speaking);
% title("Energy");
% legend(["Energy","ENG FILT", "speaking"])
% % stem(1:length(speaking), speaking);
% % title("Speaking");

% subplot(1, n_plot, 3);
plot(1:length(data_in), data_in, 1:length(speaking), speaking);
hold on;
stem(speaking);
title("data in");
legend(["input", "speaking"])
