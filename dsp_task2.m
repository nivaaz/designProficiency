% dp_dsp_task_2
%  audiorecorder(Fs, NBITS, NCHANS) creates an audiorecorder object with 
%  sample rate Fs in Hertz, number of bits NBITS, and number of channels NCHANS. 
clc
clear
%highest frequency shoulld be at 200Hz
fs = 8e3;
nbits = 1024;
nchans = 1;
L = 8; % decimation ratio
M = 8; % upsampling ratio
ar = audiorecorder(fs, nbits, nchans); %sample the data
pause(1);  %wait for a seocnd.
pause(ar); %stop the player recording.
data = getaudiodata(ar, 'int16');
% p = play(ar); %play the recording.
%%  local testing 
t = 1:100;
data = sin(t*200/pi);
% plot(data)
%% decimation by a factor of 8 ?
close all
clc
clear
%   sample data for testing.
t = 1:500;
% data = sin(t*200/pi);
data = square(t);
fs = 8e3;

L = 8;
N = length(data);                   %length of the data.
x_down = 1:floor((length(data)/8)); % make array 1/8th of total 0-X; round down.

y = decimate_input(data);
z = interp_input(y);

figure;
subplot(2, 2, 1);
plot(1:length(data), data,'r');
ylabel("data IN");
title("Data In");

subplot(2, 2, 2);
plot(1:length(data),  y, 'b');
ylabel("y IN");
title("Decimated Output");

subplot(2, 2, 3);
plot(1:length(z), z, 'g');
ylabel("Z OUT");
title("Interpolated Output");

subplot(2, 2, 4);
plot(1:length(z), abs(fft(z)).^2, 1:length(data), abs(fft(data)).^2);
ylabel("FFT OUT");
title("Output FFT");
legend(["output fft", "input fft"]);
% digital low pass filter / upsampling 
% theta = 2*pi*f/fs; %use the normalised frequency 
% theta_c = pi/L; %since L and M are the same.
% LOW PASS IS AT 500 HZ
% arr_interp = lowpass(arr_up, 500/8e3);
clc
function data = decimate_input(arr)
    %filter 
    data = zeros(1, length(arr));
    data = lowpass(arr, 500, 1e3)
    %decimate 
    sel = [1 (1:length(data)/8)*8];      % array to access 8th samples.
    de = data(sel);                       %get 8th samples.
end 

function data = interp_input(arr)
%decimate 
    data =  zeros(1, length(arr)*8);          %full array.
    sel =   [1 (1:length(arr)/8)*8];      % array to access 8th samples.
    de(sel) = arr(1:length(sel));                       %get 8th samples.
%filter 
    data = lowpass(de, 500, 8e3)*8;
end 
