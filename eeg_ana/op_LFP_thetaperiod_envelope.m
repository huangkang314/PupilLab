function [LFPthetaout,ts_thetaout] = op_LFP_thetaperiod_envelope(LFPtheta,thetaperiodtime)
% 寻找 theta period
% 通过希尔伯特变化求包络，大于几倍包络方差
threshold = 3;
if real(LFPtheta(1)) == LFPtheta(1)
    LFP_hilbert = hilbert(LFPtheta);
else
    LFP_hilbert = LFPtheta;
end

abs_LFP = abs(LFP_hilbert);
Big = find(abs_LFP > threshold*std(abs_LFP));   % 寻找过阈值的点
Dx1 = diff(Big);                                                    %　一阶差分
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

