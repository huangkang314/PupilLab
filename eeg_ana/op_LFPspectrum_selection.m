function  power_select= op_LFPspectrum_selection(S,f,band)
% 从selcet band中选出要选的频率段的能量
f_begin = find(f < band(1),1,'last');
f_end = find(f > band(2),1,'first');
power_select = sum(S(f_begin:f_end));
end