function  power_select= op_LFPspectrum_selection(S,f,band)
% ��selcet band��ѡ��Ҫѡ��Ƶ�ʶε�����
f_begin = find(f < band(1),1,'last');
f_end = find(f > band(2),1,'first');
power_select = sum(S(f_begin:f_end));
end