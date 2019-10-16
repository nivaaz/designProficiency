
function speaking = isSpeaking(data_in, fs)
    T = 1/fs;
%     in_fft = abs(fft(data_in)).^2;             %FFT 
%     f_fft = linspace(1, fs/2, length(in_fft)); %PLOTTING CODE FOR FFT 

    data_high = bandpass(data_in,[250,1000],fs,'Steepness',0.99);       %filtering data.
    in_fft_h = abs(fft(data_high)).^2;                                  %FFT data.

    N = length(data_in);        %length data.
    f_en = data_in.^2;          %ENERGY OF DATA IN
    f_en_h = log(data_high.^2); %LOG OF ENERGY OF DATA IN
    
    speaking = zeros(1, N);
    step = floor((30e-3)/T)    %20 ms
    a = sum(f_en(1:step))    %noise sum of the energy
    b = mean(f_en)           %mean of the entire signal.
    m = max(f_en)
    for i = step:(N-2*step)
    %    speaking(i) =  1.5*sum(f_en_h(1:step)) < sum(f_en_h(i:(i+step))); % noise > power.
        speaking(i) =  1.5*a< sum(f_en(i:(i+1.2*step))); % noise > power.
    end
%     p = audioplayer(data_in, fs);
%     play(p, fs);
end
