%% matlab send image file.

clc
clear
close all
% code to read the image file
% https://au.mathworks.com/help/matlab/ref/imread.html
% I = imread('download.jpg');
% https://au.mathworks.com/help/matlab/ref/tiff.read.html
% whos I
% imshow(I)
% imfinfo('puppu.bmp')

%% STEPS.
% generate the image 
% generate another image.
% modulate the image
% modualte another image 
% send the image 
%demodulate the image on the other computer 

% WRITING THE IMAGE 
A = rand(50);
imwrite(A,'myGray.png')
imfinfo('myGray.png')

A = rand(50);
imwrite(A,'myGray.png')
imfinfo('myGray.png')

X =imread(A)
% newmap = copper(81);
% imwrite(A,newmap,'copperclown.png');
% imshow(A)
%%
clc
fs = 48e3;
N = length(A);
y = zeros(N);

B = A';         %change the signal to an array.
B = B(:)';      %fina output is an array.

fmod = modulateSignal()

for n = 1:N
    x = B(n:n+N-1);
    y(n, :) = x;
    p = audioplayer(x, fs);
    play(p, fs);
end

%%
function modulated = modulateSignal(inputSig)
    %input signal can be an array.
    fc = 13.7e3;                 %carrier frequency, this may need to change. 
    dt = 1/Fs;                   % seconds per sample
    StopTime = 0.25;             % seconds
    t = (0:dt:StopTime-dt)';     % seconds
    %%Sine wave:
    Fc = 60;                     % hertz
    x = cos(2*pi*Fc*t);
    modulated = x.*inputSig;
%     plot(x);
end
