function [S,f] = op_LFPspectrum(LFP,Fs)
% LFP = LFP - mean(LFP);
% LFP = LFP / std(LFP);

window = 1; % ���ô�����Ϊ 2 s
band = 3;
TW = window*band; % ������Ϊ 2 s����Ƶ�����Ϊ 4��TW = 2*4 = 8��
K = 2*TW - 1; % K = 2*TW -1 = 15
tapers = [TW,K];
params.tapers = tapers;
params.err = 0;
params.Fs = Fs;
params.fpass = [0 100] ; % show results between 0 and 100 Hz
params.trialave = 0;
movingwin = [4,.1];
[S,f] = mtspectrumsegc_he(LFP',movingwin,params);

end