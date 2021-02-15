function out = op_filter0(lfp,name)
% ��fir1 ������λ�˲�����zero-phase-delay filter������Joshua A. Gordon ��paper
% Impaired hippocampal�Cprefrontal synchrony in a genetic mouse model of
% schizophrenia �ȡ����õ��˲���������˲�����ȡthetaƵ�ʶε�LFP
% Fs = 1000;
% thetaband = [4 12];
% betaband = [14 20];
if size(lfp,1) == 1   % lfp ��λ������
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