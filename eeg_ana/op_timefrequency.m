function [tfr,t,f] = op_timefrequency(data,Fs,freq,res)
if size(data,1) < size(data,2)
    data = data';
end
method = @op_spwv;
fs = Fs;
bin = fs/2/res;
frequencypiece = res;
beginfreq = fix(freq(1)/frequencypiece+1);
endingfreq = fix(freq(2)/frequencypiece+1);
data = data-mean(data);
data_hilbert = hilbert(data);
n = length(data_hilbert);
gn = n/10+1-rem(n/10,2);
hn = n/4+1-rem(n/4,2);
g = hamming(gn);
h = hamming(hn);
[tfr,t,f] = feval(method,data_hilbert,1:n,bin,g,h,0);
tfr = tfr(beginfreq:endingfreq,:);
tfr = flipud(tfr);
f = fs*f(beginfreq:endingfreq,:);
t = t/fs;
f = flipud(f);
tfr = tfr';
% pcolor(t,f,tfr); shading interp
% xlabel('time[s]');ylabel('frequency[Hz]');
% set(gcf,'color',[1 1 1])
end