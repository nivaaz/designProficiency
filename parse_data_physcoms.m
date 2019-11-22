% file to parse the output of the sound card.
%open csv 
clc
dt = table2array(sigSum1);
%%
size(dt)

t_arr = dt(:, 1); %time in seconds.

dt_arr = dt(:, 2);

subplot(2, 1, 1);
plot(t_arr, dt_arr)
title("Output of Sound Card");
ylabel("Volts");
xlabel("Seconds");

subplot(2, 1, 2);
plot(1:2000, dt_arr, 'm')
title("Output of Sound Card");
ylabel("Volts");
xlabel("Cell number");

% analysis.
frame_sz = 200;
len = length(dt);
frame_arr = 1:frame_sz-1:len%array of frames.

%%
clc
close all

for f = 1:(length(frame_arr)-1)
   curr_frame = dt_arr(frame_arr(f): frame_arr(f+1));
  % PLOT THE SIGNAL
   subplot(2, 1, 1);
   plot(1:frame_sz, curr_frame);
   ylim([-2, 2])
   title("Frame - Signal Data");
   xlabel("time");
   ylabel("Voltage");
   
   %PLOT THE FFT
   curr_fft = (abs(fft(curr_frame)).^2)/64;
   ["FRAME NUMBER", "MAX FFT"; f, max(curr_fft)]
   subplot(2, 1, 2);
   plot(linspace(-2*pi, 2*pi,frame_sz), curr_fft, 'r'); %DIVIDED BY 64
   ylim([0, 60])
   xlim([-6.5, 6.5]) 
   xlabel("Frequency (rad)");
   ylabel("Voltage");
   title("FFT");
   pause(0.5);
   
end
%% LOOK AT A SINGLE FRAME
f = 4
    clc    
    close all
    curr_frame = dt_arr(frame_arr(f): frame_arr(f+1)); % get frame
    curr_fft = abs(fft(curr_frame)).^2;                 % get fft.
    
    % PLOT THE FRAME 
    figure;
    subplot(2, 1, 1);
    plot(1:frame_sz, curr_frame);
    ylim([-2 2]);
    title("frame");
    
    % PLOT THE FFT
    subplot(2, 1, 2);
    plot(linspace(-2*pi, 2*pi,frame_sz), curr_fft/64, 'r'); %DIVIDED BY 64
    ylim([0, 60])
    title("FFT");
    
    x = 1;
