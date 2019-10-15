% dp_dsp_task_4.m
% speech stop and start recognition

%% OPEN FILE.
% [data_in, fs] = audioread('C:\Users\nkseh\OneDrive\Documents\Uni-Vazzy\dp\DSP\Task 4test_files\1.wav');
[data_in, fs] = audioread('C:\Users\nkseh\OneDrive\Documents\Uni-Vazzy\dp\DSP\Task 4test_files\2.wav');

%%  NEW ALGO
clc

T = 1/fs
in_fft = abs(fft(data_in)).^2;
f_fft = linspace(1, fs/2, length(in_fft));  

data_low = lowpass(data_in, 1500, fs);
data_high = highpass(data_low, 200, fs);
in_fft_h = abs(fft(data_high)).^2;


N = length(data_in);
f_en = data_in.^2;
f_en_h = data_high.^2;

figure;
n_plot = 3; %how many plots.
n=0; %plotting number.

speaking = zeros(1, N);
step = 10;
for i = step:(N-step)
   speaking(i) =  sum(f_en_h(1:step)) < sum(f_en_h(i:(i+step-1))); % noise > power.
end

subplot(1, n_plot, 1);
plot(f_fft, in_fft,  f_fft, in_fft_h);
title("FFT");
legend(["Input", "Filtered"])

subplot(1, n_plot, 2);
plot(1:length(f_en), f_en,1:length(f_en), f_en_h, 1:length(speaking), speaking);
title("Energy");
legend(["Energy","ENG FILT", "speaking"])

subplot(1, n_plot, 3);
plot(1:length(f_en), data_in, 1:length(f_en), data_high,1:length(speaking), speaking);
title("data in");
legend(["input", "filtered", "speaking"])

%% fundamental frequency range.
f_sp_low = 85; %low frequency threshold for speech 
f_sp_high = 255 ; %high frequency threshold for speech 

%highest frequency shoulld be at 200Hz
% fs =192e3;          %check this with the specs. Sampling rate of comp.
fn = fs/2;          %niquist frequency
nbits = 1024;
nchans = 1;
T = 1/fs;
ar = audiorecorder(fs, nbits, nchans); %sample the data
pause(10);  %wait for a seocnd.
pause(ar); %stop the player recording.
data_in = getaudiodata(ar, 'int16');

% bandpass the data to remove noise.
data_bp = bandpass(data_in, ...    % Frequency constraints
       'PassbandFrequency1',f_sp_low, ...    
       'PassbandFrequency2',f_sp_high, ...
       'DesignMethod','ls', ...         % Design method
       'SampleRate',fs);               % Sample rate ); %band pass to get only what's in the vocal range.

fft_x = 1:length(speechArray);

function speaking = isSpeaking(speechArray)
   %bandpass to only select 
   bandpass()
   N = length(speechArray); 
   speaking = zeros(1:N);   %init with zeros.
   noise_pw = 0;            %intial noise power.
   for i = 1:N          %for all the discrete samples in speech.
       if (i==1)        %first sample.
           noise_pw = average((abs(fft(speechArray(:, i))).^2))/N;  % make this noise.
       end
       if (speech_pw>noise_pw) % when speech > noise pw
           speaking(i) = 1;    %is speaking = 1
       else 
           speech_pw = average((abs(fft(speechArray(:, i))).^2))/N; % power of speech.           
       end % else , speaking stays at 0.
   end 
end

   %function that returns the energy for an array 
   %using Parseval's Theorem.
    function eng = getEnergy(inputArr)
       x=fft(inputArr);
       y = abs(x);
       z = x.^2;
       eng = z/length(inputArr);
    end 
