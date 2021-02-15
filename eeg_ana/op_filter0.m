function out = op_filter0(lfp,name)
% 用fir1 做零相位滤波器，zero-phase-delay filter，根据Joshua A. Gordon 的paper
% Impaired hippocampal–prefrontal synchrony in a genetic mouse model of
% schizophrenia 等。采用的滤波器。这个滤波器提取theta频率段的LFP
% Fs = 1000;
% thetaband = [4 12];
% betaband = [14 20];
if size(lfp,1) == 1   % lfp 换位列向量
	lfp = lfp(:);
end
% thetabandw = thetaband/Fs/2;
% betabandw = betaband/Fs/2;
% b_beta = fir1(515,betabandw);
% b_theta = fir1(515,thetabandw)
load(name);
% freqz(b_beta,1)

if mod(length(b),2)~=1
	error('filter order should be odd');
end

shift = (length(b)-1)/2;

[lfp_fil z] = filter(b,1,lfp);

out = [lfp_fil(shift+1:end,:) ; z(1:shift,:)];

% assignin('base','out',out);

end