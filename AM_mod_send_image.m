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

binsig1 = zeros(1, length(t)); %signal1
binsig2 = zeros(1, length(t));

t_high = 10/fs;
totalSig = [1 1];    %FOR INTERNAL TESTING ONLY.

% THIS CODE DRIVES 
for n = 1:8     %for the x axis
    for m = 1:8     %for the y axis 
        sampleImage1 = numToBin(sendImage1(n, m)) %make binary num.
        sampleImage2 = numToBin(sendImage2(n, m))
        % MAKE BINARY STAY IN STATE FOR SZ SECONDS.
        for c = 1:8 %for all the time.
            binsig1(sz*c:sz*c+sz) = sampleImage1(c);  %create digital pulse.
            binsig2(sz*c:sz*c+sz) = sampleImage2(c);
        end
        % CHANGING AMPLIUDES
        x = 0.3*binsig1;    %sum of signals, final signal.
        y = 0.6*binsig2;
        
        %0.3 and 0.6 so we can see when either, or both are high.
        %with enough noise margin!
        x = [startPulse x];
        y = [startPulse y];
%         PLAY SIGNAL HERE.
        totalSigx = [totalSig x];
        totalSigy = [totalSig y];
%       pause(0.05);plot(1:length(x),x); % code to live plot in loop
%   play(x);                %plays the audio.
    end
end

subplot(3, 1, 1)
plot(linspace(1, 1/fs, length(totalSigx)), totalSigx, 'r');
title("Signal 1");
ylabel("Voltage");
legend totalSigX;

subplot(3, 1, 2)
plot(linspace(1, 1/fs, length(totalSigy)), totalSigy, 'm');
title("Signal 2");ylabel("Voltage");
legend totalSigY

subplot(3, 1, 3)
plot(linspace(1, 1/fs, length(totalSigy)), totalSigy+ totalSigx, 'b');
title("Sum of Signals");ylabel("Voltage");
legend SUM
%% FUNCTIONS 
%own function to convert num to binary.
function B = numToBin(D)
    B = zeros(1,8);     %declar array.
    for k = 8:-1:1      %for 8 bits.
      B(k) = mod(D,2);  %save the remainder
      D = (D-B(k))/2;   %save to number.
    end
end
