%% SEND WHOLE IMAGE WITH AM ONLY.
clear
clc
close all

% modulate signal
fs = 40e3;                      %MUST BE THE SAME AS THE SENDER MACHINE!
s = 1/fs;
t = 0:1/fs:10e-3;            %timing
sz = floor(length(t)/9);
len = length(t);

dur_start = 32*s;

startPulse(1:16) = 1;               %high pulse
startPulse(17:32) = -1;             %low pulse
startPulse(33:48) = 1;              %high pulse
startPulse(49:64) = -1;             %low pulse

% MAKE A RANDOM IMAGE
sendImage1 = floor(rand([8 8])*255);
sendImage2 = floor(rand([8 8])*255);

sig1 = zeros(1, length(t)); %signal1
sig2 = zeros(1, length(t));

t_high = 10/fs;
totalSig = [1 1];    %FOR INTERNAL TESTING ONLY.

for n = 1:8     %for the x axis
    for m = 1:8 %for the y axis 
        sampleImage1 = numToBin(sendImage1(n, m)); %make binary num.
        sampleImage2 = numToBin(sendImage2(n, m));
        for c = 1:8 %for all the time.
            sig1(sz*c:sz*c+sz) = sampleImage1(c);  %create digital pulse.
            sig2(sz*c:sz*c+sz) = sampleImage2(c);
        end
        x = 0.3*sig1+0.6*sig2;    %sum of signals, final signal.
        %0.3 and 0.6 so we can see when either, or both are high.
        %with enough noise margin!
        if ((n==1) &&(m==1))
            x = [startPulse x];
%             play(x); 
        end
        totalSig = [totalSig x];
%         pause(0.1);
%         plot(1:length(x),x);
%   play(x);                %plays the audio.
    end
end

plot(1:length(totalSig), totalSig);

%% FUNCTIONS 
%own function to convert num to binary.
function B = numToBin(D)
    B = zeros(1,8);     %declar array.
    for k = 8:-1:1      %for 8 bits.
      B(k) = mod(D,2);  %save the remainder
      D = (D-B(k))/2;   %save to number.
    end
end
