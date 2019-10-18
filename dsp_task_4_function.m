
function speaking = isSpeaking(data_in, fs)
    T = 1/fs;
    N = length(data_in);
    speaking = zeros(1,N);
    snnnr = 0;
    %   START OF COMPUTATION.
    step = floor((30e-3)/T);                             %20 ms
    f_en = abs(data_in.^2);                         %ENERGY OF DATA IN    
    noi = f_en(1:step);
    b = mean(f_en);                                    %mean of the entire signal.
    snnnr = 3.5*log(b/mean(noi))
    
    if(snnnr > 15)
        fprintf("15")
        for i = step:(N-2*step)
            speaking(i) = 1.27 < mean(f_en(i-step/2:i+step))/mean(noi);     % for 25 SNR
        end
    elseif (snnnr > 10)
        fprintf("10")
        for i = step:(N-2*step)
            speaking(i) = 1.427 < mean(f_en(i-step/2:i+step))/mean(noi);     % for 25 SNR
        end
    else 
        fprintf("other")
        for i = step:(N-2*step)
            speaking(i) = b/180 < mean(f_en(i:i+step));     % for 25 SNR  
        end
    end 
    
end
