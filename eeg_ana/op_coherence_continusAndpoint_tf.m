function [C,t,f] = op_coherence_continusAndpoint_tf(lfp,spk,Fs,window,band,fpass)
% 利用coherence 工具包计算一个点序列和连续过程的的coherence关系
TW = window*band; % 窗长度为 2 s，半频带宽度为 4；TW = 2*4 = 8；
K = 2*TW - 1; % K = 2*TW -1 = 15
tapers = [TW,K];
params.tapers = tapers;
params.Fs = Fs;
params.fpass = fpass ; % show results between 0 and 100 Hz
params.trialave = 1;
params.tapers = tapers;
params.err = [2,15];
movingwin = [window,.1];

[C,phi,S12,S1,S2,t,f,zerosp,confC,phistd,Cerr] = cohgramcpt_he(lfp,spk,movingwin,params,0);


