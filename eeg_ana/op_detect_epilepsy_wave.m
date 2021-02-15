function [spikes,indexo,waveform,thr] = op_detect_epilepsy_wave(sig,sig_fil,par,thr)
% Detect spikes with amplitude thresholding. Uses median estimation.
% Detection is done with filters set by fmin_detect and fmax_detect. Spikes
% are stored for sorting using fmin_sort and fmax_sort. This trick can
% eliminate noise in the detection but keeps the spikes shapes for sorting.
global pre post deadtime detectype stdmin stdmax 
fs = par.fs;
pre = par.pre;
post = par.post;
deadtime = par.deadtime;
detectype = par.detectype; 
stdmin = par.stdmin;
stdmax = par.stdmax;

if nargin == 4
    thruse = thr;
else
    thruse = [];
end    
    
[spikes,thr,index,waveform] = child_dectect_median(sig_fil',sig,fs,thruse);
indexo = index/fs;
% plot(sig_fil);hold on;plot(index,sig_fil(index),'ro','markerfacecolor','r')

end

function  [spikes,thr,index,waveform] = child_dectect_median(sig_fil,sig_raw,fs,thruse)
global pre post deadtime stdmin stdmax 
timewave = 0.5;  % 0.5s
Npoints = fs*timewave;
%noise_std_detect = median(abs(sig_fil)/0.6745);
noise_std_detect = std(sig_fil);

if ~isempty(thruse)
    thr = thruse;
else
    thr = stdmin*noise_std_detect;        %thr for detection is based on detected settings.
end

thrmax = stdmax*noise_std_detect;     %thrmax for artifact removal is based on sorted settings.

% located spike times
% 负向检测spike
nspk = 0;
xpos = find(sig_fil(pre+2:end-post-2) < -thr)+pre+1;
% xpos = find(sig_fil(pre+2:end-post-2) > thr)+pre+1;
%plot(sig_fil);hold on;plot(xpos,sig_fil(xpos),'ro','markerfacecolor','r')
xpos0 = 0;
index = zeros(1,length(xpos));
for i = 1:length(xpos)
    if xpos(i) >= xpos0 + deadtime
        [~, iposx] = min((sig_fil(xpos(i):xpos(i)+floor(deadtime/2))));    %introduces alignment
            nspk = nspk + 1;
            index(nspk) = iposx + xpos(i)-1;
            xpos0 = index(nspk);
%             fprintf('minvalue %f \n', minvalue)
    end
end

index = nonzeros(index);
if isempty(index)
    spikes = [];
    %thr = [];
    index = [];
    waveform = [];
    return;
end

% spike sorting
ls = pre+post;
spikes = zeros(nspk,ls+6);index_out = zeros(1,nspk); % 多加入6个点，因为最后 spike alignment 时会删除一些点
waveform = zeros(nspk,2*Npoints);
sig_fil = [sig_fil zeros(1,post)];
for i = 1:nspk                          % 尾迹检测
    spkraw = sig_fil(index(i)-pre:index(i)+post);
    if max(abs(spkraw)) < thrmax 
            spikes(i,:) = sig_fil(index(i)-pre-1:index(i)+post+4);
            if index(i) > Npoints && index(i) < length(sig_raw)-Npoints
                waveform(i,:) = sig_raw(index(i)-Npoints+1:index(i)+Npoints);  % 该spike附近的waveform
            else
                waveform(i,:) = waveform(i,:);
            end
            index_out(i) = index(i);
    end
end
index = index_out';
artifact_x = sum(spikes,2) == 0;       %  删除因为噪音错误检测到的尾迹
spikes(artifact_x,:) = [];
index(artifact_x) = [];
waveform(artifact_x,:) = [];

if isempty(spikes)
    spikes = [];
    index = [];
    waveform = [];
end
end

