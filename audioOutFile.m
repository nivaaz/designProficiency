sample_rate = 44100; % This is likely the sound-card's native sample rate
N = 256; % number of samples in a block
n = 0:(N-1); % Each block of audio starts with a carrier phase of 0 so as
             % to minimize the audible impact of discrete jumps in the
             % amplitude between blocks.
phase = n/64; % Important that N is whole number of periods
phase = phase - round(phase); % Because trig is not perfectly periodic
wform = sin(2*pi*phase)';
p = dsp.AudioPlayer('SampleRate',sample_rate,...
                    'BufferSizeSource','Property',...
                    'BufferSize',N,...
                    'QueueDuration',N/sample_rate,...
                    'OutputNumUnderrunSamples',true);
gain = 1.0;
factor = 1.05;

for k=1:1000 % Push 1000 blocks of audio to the play queue

  block = wform * gain; % create the next block of audio samples
  under = step(p,block); % Push the block of samples onto the queue

  % Check for underflow - unlikely, but if there is queue under-run, you should
  % increase QueueDuration and/or BufferSize.  In this example, we make
  % all the delay quantities divisible by N samples so that the step function
  % should return at regular intervals, with a playback delay of
  % QueueDuration + 2*N/sample_rate seconds.  As set up above, this delay is
  % 3*N/sample_rate seconds.  If you increase QueueDuration to 2*N/sample_rate,
  % the delay increases a little, but you get a queue with two blocks of N
  % samples, which will greatly reduce the likelihood of queue under-run.
  % If you still get under-run, increase N.  Very occasional under-run might
  % not hurt you much, depending on how you use the sound-card signal to
  % drive the PWM signal to the motor.  Remember to use the trimpot to
  % adjust the PSM setting so that the motor does not stall when there is
  % no sound-card signal.

  % Note: on older versions of Matlab, the dsp.AudioPlayer does not
  % report buffer underruns.  In this case you will find first that you
  % need to omit the last line from the configuration call above and
  % second that you need to call step(p,block) as a function that has
  % no return value -- it seems that Matlab checks return signatures
  % in deciding which overloaded function to call, which could leave you
  % with a confusing message resulting from invocation of the wrong step
  % function.

  if (under > 0)
    under
  end

  % This is where you would read from the sound-card input queue, but that
  % is up to you.

  % Finally, modulate the intensity of the waveform as a demonstration that
  % everything works.

  gain = gain * factor;
  if (gain > 2)
    gain = 2;
    factor = 1/factor;
  elseif (gain < 0.1)
    gain = 0.1;
    factor = 1/factor;
  end

end % Finish the outer run loop -- you can also just type ctrl-C.

release(p);
