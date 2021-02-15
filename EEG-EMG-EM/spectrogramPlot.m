function [S,F,T,P] = spectrogramPlot(data, Fs, fI, fRes, shift)
%spectrogramPlot 时频图绘制函数
% Input:
%       data: 单个通道一段时间的LFP数据
%       Fs: 采样率
%       fI: 频率显示区间
%       fRes: 频率分辨力
%       shift: 时间分辨率
% hk, 2016.06.17
% 判断是否需要把数据转置
if size(data,1) < size(data,2)
    data = data';
end
lfft = 4096; %短时傅里叶变换的长度
winlgh = 512; % 窗大小
frmlgh = shift * Fs;  % 数据帧大小
noverlap = winlgh - frmlgh;
data = 2.0*data/max(abs(data));
[S,F,T,P] = spectrogram(data, winlgh, noverlap, lfft, Fs);
end

