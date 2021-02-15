function [LFPthetaout,ts_thetaout] = op_LFP_thetaperiod_envelope(LFPtheta,thetaperiodtime)
% Ѱ�� theta period
% ͨ��ϣ�����ر仯����磬���ڼ������緽��
threshold = 3;
if real(LFPtheta(1)) == LFPtheta(1)
    LFP_hilbert = hilbert(LFPtheta);
else
    LFP_hilbert = LFPtheta;
end

abs_LFP = abs(LFP_hilbert);
Big = find(abs_LFP > threshold*std(abs_LFP));   % Ѱ�ҹ���ֵ�ĵ�
Dx1 = diff(Big);                                                    %��һ�ײ��
findvalue = 1;
[pos,long] = op_findsamevalueInterval(Dx1, findvalue);

cc = 0;
for i_piece = 1 : numel(pos)
%     if length(LFPtheta) > Big(pos(i_piece)) + thetaperiodtime && long(i_piece) > thetaperiodtime
        cc = cc + 1;
%         theta_piece = LFPtheta(Big(pos(i_piece)) : Big(pos(i_piece)) + thetaperiodtime -1);
        theta_piece = LFPtheta(Big(pos(i_piece)) : Big(pos(i_piece)) + long(i_piece) -1);
        LFPthetaout{cc,:} = theta_piece;
        ts_thetaout(cc,:) = Big(pos(i_piece));
%     end
end

