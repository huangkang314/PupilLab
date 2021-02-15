function [S,F,T,P] = spectrogramPlot(data, Fs, fI, fRes, shift)
%spectrogramPlot ʱƵͼ���ƺ���
% Input:
%       data: ����ͨ��һ��ʱ���LFP����
%       Fs: ������
%       fI: Ƶ����ʾ����
%       fRes: Ƶ�ʷֱ���
%       shift: ʱ��ֱ���
% hk, 2016.06.17
% �ж��Ƿ���Ҫ������ת��
if size(data,1) < size(data,2)
    data = data';
end
lfft = 4096; %��ʱ����Ҷ�任�ĳ���
winlgh = 512; % ����С
frmlgh = shift * Fs;  % ����֡��С
noverlap = winlgh - frmlgh;
data = 2.0*data/max(abs(data));
[S,F,T,P] = spectrogram(data, winlgh, noverlap, lfft, Fs);
end

