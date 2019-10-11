% dp_dsp_task_4.m
%speech stop and start recognition

f_sp_low ; %low frequency threshold for speech 
f_sp_high ; %high frequency threshold for speech 

%highest frequency shoulld be at 200Hz
fs =192e3;          %check this with the specs. Sampling rate of comp.
nbits = 1024;
nchans = 1;

ar = audiorecorder(fs, nbits, nchans); %sample the data
pause(10);  %wait for a seocnd.
pause(ar); %stop the player recording.
data_in = getaudiodata(ar, 'int16');

% bandpass the data to remove noise.
data_bp = bandpass(data_in, ...    % Frequency constraints
       'PassbandFrequency1',f_sp_low, ...    
       'PassbandFrequency2',f_sp_high, ...
       'DesignMethod','ls', ...         % Design method
       'SampleRate',fs);               % Sample rate ); %band pass to get only what's in the vocal range.
       
       
%% FUNCTION DECLARATION

amIspeaking(speechArray)


function isSpeakingArr = amISpeaking(speech)
    N = length(speech)    ;
    isSpeakingArr = zeros(1, N);
    for i = 1:N 
        f_power = (abs(fft(speech(i))).^2)/N;
        if (i==1)
            noise_power = f_power;
        else  
         isSpeakingArr(i) = (noise_power > f_power);
    end 
    end 
            
end
