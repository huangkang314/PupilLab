function  [S,t,f] = op_timefrequency_taper(data,Fs,window,band,fpass)
TW = window*band; % ������Ϊ 2 s����Ƶ�����Ϊ 4��TW = 2*4 = 8��
K = 2*TW - 1; % K = 2*TW -1 = 15
tapers = [TW,K];
params.tapers = tapers;
params.err = 0;
params.Fs = Fs;
params.fpass = fpass ; % show results between 0 and 100 Hz
params.trialave = 0;
movingwin = [window,.01];
[S,t,f] = mtspecgramc_he(data,movingwin,params);