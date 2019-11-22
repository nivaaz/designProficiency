
% 
% subplot(2, 1, 1);
% plot(t_arr, dt_arr)
% title("Output of Sound Card");
% ylabel("Volts");
% xlabel("Seconds");
% 
% subplot(2, 1, 2);
% plot(1:2000, dt_arr, 'm')
% title("Output of Sound Card");
% ylabel("Volts");
% xlabel("Cell number");

dt_arr = inData/200;

% analysis.
frame_sz = 100;
len = length(inData);
frame_arr = 1:frame_sz-1:len%array of frames.

%for each frame in the data
for f = 1:(length(frame_arr)-1)
   curr_frame = double(dt_arr(frame_arr(f): frame_arr(f+1)))/500;
  % PLOT THE SIGNAL
   subplot(2, 1, 1);
   plot(1:frame_sz, curr_frame);
%     ylim([-2, 2])
   title("Frame - Signal Data");
   xlabel("time");
   ylabel("Voltage");
   
   %PLOT THE FFT
%    [y1, D1] = highpass(curr_frame,300,11025,'Steepness',0.5);
   curr_fft = (abs(fft(curr_frame)).^2)/64;
   ["FRAME NUMBER", "MAX FFT"; f, max(curr_fft)]
   subplot(2, 1, 2);
   plot(linspace(-2*pi, 2*pi,frame_sz), curr_fft, 'r'); %DIVIDED BY 64
%     ylim([0, 60])

%% round 2


% 
% subplot(2, 1, 1);
% plot(t_arr, dt_arr)
% title("Output of Sound Card");
% ylabel("Volts");
% xlabel("Seconds");
% 
% subplot(2, 1, 2);
% plot(1:2000, dt_arr, 'm')
% title("Output of Sound Card");
% ylabel("Volts");
% xlabel("Cell number");

dt_arr = inData/200;

% analysis.
frame_sz = 100;
len = length(inData);
frame_arr = 1:frame_sz-1:len%array of frames.

%for each frame in the data
for f = 1:(length(frame_arr)-1)
   curr_frame = double(dt_arr(frame_arr(f): frame_arr(f+1)))/500;
  % PLOT THE SIGNAL
   subplot(2, 1, 1);
   plot(1:frame_sz, curr_frame);
%     ylim([-2, 2])
   title("Frame - Signal Data");
   xlabel("time");
   ylabel("Voltage");
   
   %PLOT THE FFT
%    [y1, D1] = highpass(curr_frame,300,11025,'Steepness',0.5);
   curr_fft = (abs(fft(curr_frame)).^2)/64;
   ["FRAME NUMBER", "MAX FFT"; f, max(curr_fft)]
   subplot(2, 1, 2);
   plot(linspace(-2*pi, 2*pi,frame_sz), curr_fft, 'r'); %DIVIDED BY 64
%     ylim([0, 60])
    
   xlabel("Frequency (rad)");
   ylabel("Voltage");
   title("FFT");
   pause(0.5);
   
end
%% LOOK AT A SINGLE FRAME
f = 10
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
    
%%
clc
clear
close all
sample_rate = 11100; % This is likely the sound-card's native sample rate
N = 256; % number of samples in a block
p = dsp.AudioRecorder('SampleRate',sample_rate,...
                    'BufferSizeSource','Property',...
                    'BufferSize',N, 'SamplesPerFrame', 256);
gain = 1.0;
factor = 1.05;
figure;
len = 256;


for k=1:2000 % Push 1000 blocks of audio to the play queue
  curr_frame = step(p); % Push the block of samples onto the queue
  curr_fft = abs(fft(curr_frame(:, 2))).^2;
  if (k==1)
    tframe = curr_frame(:, 2)';
  else 
      tframe = [tframe curr_frame(:, 2)'];
  end
  
%     subplot(2, 1, 1);
%     plot(1:len, curr_frame*10);
%     ylim([0 1]);
%     title("frame");
% 
%     % PLOT THE FFT
%     subplot(2, 1, 2);
%     plot(linspace(-2*pi, 2*pi,len), curr_fft, 'r'); %DIVIDED BY 64
%     ylim([0, 5])
%     max(curr_fft)
%     x = find(curr_fft == max(curr_fft))
%     
%     
%     
%     title("FFT");
%     pause(0.09)
end % Finish the outer run loop -- you can also just type ctrl-C.

release(p);
plot(tframe)
    
   xlabel("Frequency (rad)");
   ylabel("Voltage");
   title("FFT");
   pause(0.5);
   
end
%% LOOK AT A SINGLE FRAME
f = 10
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
    
%%
clc
clear
close all
sample_rate = 11100; % This is likely the sound-card's native sample rate
N = 256; % number of samples in a block
p = dsp.AudioRecorder('SampleRate',sample_rate,...
                    'BufferSizeSource','Property',...
                    'BufferSize',N, 'SamplesPerFrame', 256);
gain = 1.0;
factor = 1.05;
figure;
len = 256;

for k=1:2000 % Push 1000 blocks of audio to the play queue
  curr_frame = step(p); % Push the block of samples onto the queue
  curr_fft = abs(fft(curr_frame)).^2;
  if (k==1)
    tframe = curr_frame(2);
  else 
      tframe = [tframe curr_frame(2)];
  end
  
  subplot(2, 1, 1);
    plot(1:len, curr_frame);
    %     ylim([-2 2]);
    title("frame");

    % PLOT THE FFT
    subplot(2, 1, 2);
    plot(linspace(-2*pi, 2*pi,len), curr_fft, 'r'); %DIVIDED BY 64
    %     ylim([0, 60])
    title("FFT");
    pause(0.01)
    
end % Finish the outer run loop -- you can also just type ctrl-C.

release(p);
  plot(under)
