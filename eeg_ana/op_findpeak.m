function [pos,peak] = op_findpeak(sig,t)
% 找到一个波形中的peak和其对应的位置
diff1 = diff(sig);
signV = sign(diff1);
signV1 = signV(2:end);
signV1(end+1) = signV(end);
prod1 = signV.*signV1;
pos = find(prod1 == -1)+1;

% plot(sig)
% hold on
% plot(pos,sig(pos),'ro')

peak = sig(pos);
pos = t(pos);
end