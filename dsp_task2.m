% dp_dsp_task_2
%  audiorecorder(Fs, NBITS, NCHANS) creates an audiorecorder object with 
%  sample rate Fs in Hertz, number of bits NBITS, and number of channels NCHANS. 
clc
clear
close all
%highest frequency shoulld be at 200Hz
fs = 8e3;
nbits = 8;
nchans = 1;
L = 8; % decimation ratio
M = 8; % upsampling ratio
format short
ar = audiorecorder(fs, nbits, nchans); %sample the data
recordblocking(ar, 1);  %wait for a seocnd.

data = getaudiodata(ar);
plot(1:length(data), data)
%%  local testing 
t = 1:100;
data = sin(t*200/pi);
%% decimation by a factor of 8 ?
clc
close all
fs = 8e3;
t_plot = 1:1000;
L = 8;
N = length(data);                   %length of the data.
x_down = 1:floor((length(data)/8)); % make array 1/8th of total 0-X; round down.

y = decimate_input(data);
z = interp_input(y);

figure;
subplot(2, 2, 1);
plot(t_plot, data(1:length(t_plot)),'r');
ylabel("data IN");
title("Data In");

subplot(2, 2, 2);
plot(t_plot,  y(1:length(t_plot)), 'b');
ylabel("y IN");
title("Decimated Output");

subplot(2, 2, 3);
plot(1:length(z), z, 'g');
ylabel("Z OUT");
title("Interpolated Output");

n = length(data);
dt_fft = (abs(fft(data)).^2)*10;
z_fft = (abs(fft(z)).^2)*10;

f_plot = (0:n-1)*(8e3)/n;

subplot(2, 2, 4);
plot(f_plot, dt_fft,f_plot, z_fft);
ylabel("FFT OUT");
title("Output FFT");
legend(["input fft", "output fft"]);
% digital low pass filter / upsampling 
% theta = 2*pi*f/fs; %use the normalised frequency 
% theta_c = pi/L; %since L and M are the same.
% LOW PASS IS AT 500 HZ
% arr_interp = lowpass(arr_up, 500/8e3);

function de = decimate_input(arr)
%filter 
    data = zeros(1, length(arr));
    data = lowpass(arr, 500, 8e3, 'ImpulseResponse', 'iir');
%decimate 
    sel = [1 (1:length(data)/8)*8];      % array to access 8th samples.
    length(sel)
    de = data(sel);                       %get 8th samples.
end 

function de = interp_input(arr)
%decimate 
    data =  zeros(1, (length(arr)-1)*8); %full array 8* length
    sel =   [1 (1:length(arr)-1)*8]; % array to access 8th samples.
    data(sel) = arr(1:length(sel));
    length(sel)
    length(data)
%filter 
    de = lowpass(data, 500, 8e3, 'ImpulseResponse', 'iir')*8;
end 
