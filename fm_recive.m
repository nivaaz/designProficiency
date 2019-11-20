clc
close all
clear

fs = 9e3;
p = audiorecorder();
x = zeros(1, 256)

figure;
plot(1:256, x)
pause(1)
while (1)
   record(p, 60e-3); 
   stop(p);
   x = getaudiodata(p)
   plot(1:256, x)
end 
record(p);
stop(p);
x = getaudiodata(p)'

 plot(0:length(x):0.01, x)
 
 length(x)
