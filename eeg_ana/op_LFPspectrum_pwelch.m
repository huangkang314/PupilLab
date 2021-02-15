function [S,f] = op_LFPspectrum_pwelch(data,window,noverlap,nfft,Fs,range)
% data = data - mean(data);
% data = data / std(data);

[S,f] = pwelch(data,window,noverlap,nfft,Fs,range);