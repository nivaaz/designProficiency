
function speaking = isSpeaking(data_in, fs)
    T = 1/fs;
    N = length(data_in);
    speaking = zeros(1,N);
    data_snr = snr(data_in)
    %   START OF COMPUTATION.
    step = floor((30e-3)/T);                             %20 ms
    f_en = abs(data_in.^2);                         %ENERGY OF DATA IN    
    b = mean(f_en);                                    %mean of the entire signal.
    noi = f_en(1:step);
    
    if (data_snr < 15)
        for i = step:(N-2*step)
    %         speaking(i) = b/180 < mean(f_en(i:i+step));     % for 25 SNR
            speaking(i) = 1.49 < mean(f_en(i-step/2:i+step))/mean(noi);     % for 25 SNR
        end
    else 
        for i = step:(N-2*step)
    %         speaking(i) = b/180 < mean(f_en(i:i+step));     % for 25 SNR
            speaking(i) = 1.43 < mean(f_en(i-step/2:i+step))/mean(noi);     % for 25 SNR
        end
    end 
end
