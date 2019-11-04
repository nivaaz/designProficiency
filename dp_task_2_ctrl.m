%% task 2 control dp 
%https://au.mathworks.com/help/daq/ref/addanalogoutputchannel.html?searchHighlight=addAnalogOutputChannel&s_tid=doc_srchtitle#bsnnump-1-measurementType
devices = daq.getDevices
devices(1)

s = daq.createSession('ni');
addAnalogInputChannel(s,'Dev2', 0, 'Voltage');
addAnalogInputChannel(s,'Dev2', 1, 'Voltage');
addAnalogOutputChannel(s,'Dev2', 'ao0', 'Voltage');

s.Channels(2).Terminal
s.Rate = 240; %sampling rate.

%writing pwm to the daq
ch = s.Channels(2);
ch.Frequency = 10;
ch.InitialDelay = 0.5;
ch.DutyCycle = 0.75;
s.Rate = 1000;
s.DurationInSeconds = 1;

% 
% % this line aqcuires a single scan.
% data = s.inputSingleScan
% 
% [data,time] = s.startForeground; %blocks all matlab until aqc is complete.
% 
% plot(time,data);
% xlabel('Time (secs)');
% ylabel('Voltage')
% s.DurationInSeconds = 10;
% s
% [data,time] = s.startForeground;
% plot(time,data);
% xlabel('Time (secs)');
% ylabel('Voltage')