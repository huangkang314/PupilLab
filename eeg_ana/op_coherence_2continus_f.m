function [C,f] = op_coherence_2continus_f(data1,data2,Fs,window,band,fpass)
% ����coherence ���߰����������������е�coherence��ϵ
TW = window*band; % ������Ϊ 2 s����Ƶ�����Ϊ 4��TW = 2*4 = 8��
K = 2*TW - 5; % K = 2*TW -1 = 15
tapers = [TW,K];
params.tapers = tapers;
params.Fs = Fs;
params.fpass = fpass ; % show results between 0 and 100 Hz
params.trialave = 1;
params.tapers = tapers;
params.err = [2,15];



[C,phi,S12,S1,S2,f,confC,phistd,Cerr] = coherencyc_he(data1',data2',params);
