function chanNum = op_select_Maxpowerchan(path,band)
%  这个函数根据输入的频率段，选择在记录的所有LFP通道中，这个频带能量最大的通道
% 输入的band为 'detla';'theta';'alpha';'beta';'gamma'
global detla theta alpha beta gamma Fs band_select

path =  [path(1:end-4),'-lfp.plx'];
% plxfilename = [path(1:end-5),'-lfp.plx'];
plxfilename = path;
band_select = band;
detla = [.5 4];
theta = [5 8];
alpha = [8 12];
beta = [12 30];
gamma = [30 80];

%-----------------read LFP----------------------%
chan = child_plxchan(plxfilename);

Numchan = numel(chan);
power = zeros(1,Numchan);
for i_chan = 1:Numchan
    LFPchan = chan(i_chan);
    
    [Fs,~,~,~,LFP] = plx_ad_v(plxfilename,LFPchan);   % LFP before
    
    [power(i_chan),f] = child_LFPfilter(LFP);
       
end
[~,pos] = max(power);
chanNum = chan(pos);
[~,~,~,~,LFP] = plx_ad_v(plxfilename,chanNum);   % LFP before
% plot(LFP);pause;close gcf
disp(chanNum)
end

function chan = child_plxchan(plxfilename_lfpbef)
[~,chan] = plx_ad_chanmap(plxfilename_lfpbef);
[~,chandata] = plx_adchan_samplecounts(plxfilename_lfpbef);
chan = chan(chandata ~= 0);
end

function [power,f] = child_LFPfilter(LFP)
global detla theta  alpha beta gamma  Fs band_select

LFP = LFP - mean(LFP);
LFP = LFP / std(LFP);
[S,f] = op_LFPspectrum(LFP,Fs);
power_detla = op_LFPspectrum_selection(S,f,detla);
power_theta = op_LFPspectrum_selection(S,f,theta);
power_alpha = op_LFPspectrum_selection(S,f,alpha);
power_beta = op_LFPspectrum_selection(S,f,beta);
power_gamma = op_LFPspectrum_selection(S,f,gamma);

power_detla = power_detla/(power_theta + power_alpha);
power_theta = power_theta/(power_detla + power_alpha);
power_alpha = power_theta/(power_theta + power_beta);
power_beta = power_beta/(power_alpha + power_gamma);
power_gamma = power_gamma/(power_beta + power_alpha);

switch band_select
    case 'detla'
        power = power_detla;
    case 'theta'
        power = power_theta;
    case 'alpha'
        power = power_alpha;
    case 'beta'
        power = power_beta;
    case 'gamma'
        power = power_gamma;
end

end






