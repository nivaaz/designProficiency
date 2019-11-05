%% task 2 control dp 
% https://au.mathworks.com/help/daq/ref/addanalogoutputchannel.html?searchHighlight=addAnalogOutputChannel&s_tid=doc_srchtitle#bsnnump-1-measurementType
% RUN IN AND OUT SIMULT.
%     https://au.mathworks.com/help/daq/examples/acquire-data-and-generate-signals-at-the-same-time.html

%desired sampling & driving frequency
fs = 240;

%getting the devices.
devices = daq.getDevices
devices(1)

%getting the DAQ
s = daq.createSession('ni');

% ----- IO SET UP
%INPUT CHANNELS
addAnalogInputChannel(s,'Dev2', 0, 'Voltage');
addAnalogInputChannel(s,'Dev2', 1, 'Voltage');
%OUTPUT CHANNELS.
addAnalogOutputChannel(s,'Dev2', 'ao0', 'Voltage');

%% ----- GENERATE DATA 
% DURATION OF SAMPLING TIME
s.DurationInSeconds = 15

fs = 1000
f = 33.1e3;
dur = 5;

% generate a 30 Hz square wave:
[t, x0] = getPWM(f, fs, dur, 50);
[t, x1] = getPWM(f, fs, dur, 50);         %get to steady state.
[t, x2] = getPWM(f, fs, dur, 65);       %get to 

pwm_out = [x0, x1, x2];     %concat the two arrays.
len = length(pwm_out);      %len of the two arrays.
t = linspace(0, 3*dur, len);  %plotting sig the two arrays.

plot(t, pwm_out);
ylabel("AMPLITUDE (VOLTS)")
xlabel("TIME (S)")
title("PWM OUT")

% ----- LOAD DATA.
queueOutputData(s,pwm_out)

% ----- SAMPLE THE DATA & OUTPUT PWM 
[captured_data,time] = s.startForeground();

% ----- PLOT THE DATA.
plot(time,captured_data);       
ylabel('Voltage');
xlabel('Time');
title('Acquired Signal');

%% SINGLE SCAN FOR TESTING.
 data = s.inputSingleScan 
 [data,time] = s.startForeground; %blocks all matlab until aqc is complete.

%% testing output samples.
clc
fs = 1000
f = 33.1e3;
dur = 5;

% generate a 30 Hz square wave:
[t, x0] = getPWM(f, fs, dur, 50);
[t, x1] = getPWM(f, fs, dur, 50);         %get to steady state.
[t, x2] = getPWM(f, fs, dur, 65);       %get to 

pwm_out = [x0, x1, x2];     %concat the two arrays.
len = length(pwm_out);      %len of the two arrays.
t = linspace(0, 3*dur, len);  %plotting sig the two arrays.

plot(t, pwm_out);
ylabel("AMPLITUDE (VOLTS)")
xlabel("TIME (S)")
title("PWM OUT")

%%FUNCTION TO GENERATE A PWM SIGNAL
% - F IS THE FREQUENCY 
% - FS IS THE SAMPLING FREQUENCY 
% - DUR IS THE DURATION OF THE SIGNAL
% - DUTY IS THE DURATION OF THE SIGNAL
% THE AMPLITUDE IS A DEFAULT 5 VOLTS
function [t, pwm] = getPWM(f, fs, dur, duty)
    [f, fs, dur]    
    t_step = 1/fs; 
    t = 0:t_step:dur;
    pwm = 2.5*square(2*pi*f*t, duty)+2.5;
end
