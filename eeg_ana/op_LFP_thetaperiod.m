function [LFPthetaout,ts_thetaout] = op_LFP_thetaperiod(LFPtheta,LFPbeta,thetaperiodtime,threshold)
% Ѱ�� theta period, "Oscillatory Entrainment of Striatal Neurons in Freely Moving Rats
% ѡ�� theta���ļ���ֵ�㣬ѡ��һ����С����ֵ�������������ң����ϵ����������ֵ���������ֵ�պ�ֻ�õ�һ�� epoch ʱ��
% ѡ�������ֵ��Ȼ���á�threshold * ��ֵ��ѡ����theta epoch

% plot(LFPtheta(3000:4000))
mode = 'peaks';
method = 'zero';
ts = linspace(1,numel(LFPtheta),numel(LFPtheta))';
[t,peaks] = sineWavePeaks([ts,LFPtheta],method,mode);

value = std(LFPtheta);
count = 99;
while (count > 1)
    
    count = sum(peaks >= value);
    value = value + value/1000;
    
end

value = value * threshold;
t = t(peaks >= value);
index = zeros(numel(t),1);

for i_piece = 1 : numel(t)
    if length(LFPtheta) > t(i_piece) + thetaperiodtime/2-1 &&  t(i_piece) - thetaperiodtime/2> 1
        theta_piece = LFPtheta(t(i_piece) - thetaperiodtime/2 : t(i_piece) + thetaperiodtime/2 -1);
        beta_piece = LFPbeta(t(i_piece) - thetaperiodtime/2 : t(i_piece) + thetaperiodtime/2 -1);
        power_theta_piece = sum(theta_piece.^2);
        power_beta_piece = sum(beta_piece.^2);
%         if power_theta_piece > 3 * power_beta_piece
            index(i_piece) = true;
%         end
    end
end

t = t(logical(index));

LFPthetaout = zeros(numel(t),thetaperiodtime);
ts_thetaout = t;

for i_piece = 1:numel(t)
    
    LFPthetaout(i_piece,:) = LFPtheta(t(i_piece) - thetaperiodtime/2 : t(i_piece) + thetaperiodtime/2 -1);
    
end
