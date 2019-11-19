clc
clear
close all
% MAKE A RANDOM IMAGE
x_image = 8;
y_image = 8;

sendImage1 = floor(rand([x_image y_image])*255);    %creating a random image.
sendImage2 = floor(rand([x_image y_image])*255);    %creating another random image.

% modulate signal
fs = 40e3;           %sampling rate.
fc1 = 9.99e3;        %carrier off frequency 1
fc2 = 5.75e3;        %carrier off frequency 2
dur = 0.05;          %length of time the signal goes for in seconds.

t = 0:1/fs:dur;              %timing
sz = floor(length(t)/9);     %the size of each high or low.
len = length(t);

carr1 = sin(2*pi*t*fc1);    %carrier signal 1
carr2 = sin(2*pi*t*fc2);    %carrier signal 2

sampleImage1 = zeros(1, 8);     %will hold the binary image.   
sampleImage2 =  zeros(1, 8);    

t_high = 10/fs;

% start of the signal pulse.
startPulse(1:16) = 1;               %high pulse
startPulse(17:32) = -1;             %low pulse
startPulse(33:48) = 1;              %high pulse
startPulse(49:64) = -1;             %low pulse

modsig1 = zeros(1, 64+len);         %initliasing the modsig
modsig2 = zeros(1, 64+len);

%notes: may need to check scale at output!

for ycount = 1:y_image  %for all the rows
    for xcount = 1:x_image %for all the cols.
        % grab the image pixel.
        sampleImage1 = numToBin(sendImage1(xcount, ycount));    %sample signal
        sampleImage2 = numToBin(sendImage2(xcount, ycount));     %sample signal
        % modulate the signal
        modsig1 = [startPulse sampleImage1.*carr1];  %modulated signal 1
        modsig2 = [startPulse sampleImage2.*carr2];  %modulated signal 2
        % SUM OF BOTH THE SIGNALS FOR ONE COMPUTER TESTING
%         sigSum = modsig1+modsig2;    %sum of modulated signals & offset.
        % SET UP THE AUDIO
        AudioImage1 = audioplayer(modsig1, fs);
        AudioImage2 = audioplayer(modsig2, fs);
%         AudioImageSum = audioplayer(sigSum, fs);
        %PLAY THE SIGNAL
        play(AudioImage1, fs);
        play(AudioImage2, fs);
%         play(AudioImageSum, fs);
    end
end


% plotting code.
subplot(4, 1, 1);
plot(linspace(1, 1/fs, length(sigSum)), sigSum);
title("Sum of both Signals")
ylabel("Amplitude (Volts)")
legend(["SigSum"])

subplot(4, 1, 2);
plot(t, binsig1, t, binsig2);
title("Binary Signals")
ylabel("Volts")
legend(["sig1" "sig2"])

subplot(4, 1, 3);
plot(t, modsig1);
ylabel("Volts")
title("Modulated Signal 1")
legend(["ModSig1"])

subplot(4, 1, 4);
plot(t, modsig2);
title("Modulated Signal 2")
ylabel("Volts")
legend(["ModSig2"])

%% FUNCTIONS 
%own function to convert num to binary.
function B = numToBin(D)
    B = zeros(1,8);     %declar array.
    for k = 8:-1:1      %for 8 bits.
      B(k) = mod(D,2);  %save the remainder
      D = (D-B(k))/2;   %save to number.
    end
end
