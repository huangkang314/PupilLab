function [lags, crosscorr, max_crosscorr_lag,p_value] = op_amp_crosscorr(sig1,sig2,samp_freq,time_selec,bin,flag)
% Gordon ��Ĵ��ݷ�����㷽��
% amp_crosscorr calculates the crosscorrelation of the amplitude envelope of the��signals
% and returns the crosscorrelation as an output.
% USAGE: [lags, crosscorr, max_crosscorr_lag]=amp_crosscorr(eeg1,eeg2,samp_freq)
%INPUTS:
% sig1-vector containing local field potential from brain area 1
% sig2-vector containing local field potential from brain area 2
%OUTPUTS:
% lags-vector contaning lags from -100 ms to +100 ms, over which the
% crosscorrelation was done
% crosscorr-vector with the crosscorrelation of the amplitude of sig1 sig2
% max_crosscorr_lag-lag at which the crosscorrelation peaks. Negative
% max_crosscorr_lag indicates that sig1 is leading sig2.
% check inputs

%check consistency of data
Fs = 1000;
shuffletime = 1000;
% time = [-10 : .1: -5 , 5 : .1 :10];
time = 0 : .1 : numel(sig1)/Fs;

point = time * Fs;
if length(sig1) ~= length(sig2);
    error('ERROR in amp_crosscorr. eeg1 and eeg2 must be vectors of the same size;')
end

% sig1 = sig1(3*Fs : numel(sig1) - 3*Fs);
hilb1 = hilbert(sig1); %calculates the Hilbert transform of sig1
amp1 = abs(hilb1);%calculates the instantaneous amplitude of sig1
amp1 = (amp1-mean(amp1)); %removes mean of the signal because the DC component of a signal does not change the correlation

% sig2 = sig2(3*Fs : numel(sig1) - 3*Fs);
hilb2 = hilbert(sig2);%calculates the Hilbert transform of sig2
amp2 = abs(hilb2);%calculates the instantaneous amplitude of sig2
amp2 = (amp2-mean(amp2));


amp1_selec = amp1(time_selec(1)*Fs+1:time_selec(2)*Fs);
amp2_selec = amp2(time_selec(1)*Fs+1:time_selec(2)*Fs);

amp1_selec = op_epoch(amp1_selec,Fs*bin);
amp2_selec = op_epoch(amp2_selec,Fs*bin);

crosscorr = zeros(size(amp1_selec,1),2*round(samp_freq/10) + 1);
max_crosscorr_lag = zeros(size(amp1_selec,1),1);
max_crosscorr = zeros(size(amp1_selec,1),1);

max_crosscorr_shuffle = zeros(size(amp1_selec,1),shuffletime);
for i = 1 : size(amp1_selec,1)
    amp1_piece = amp1_selec(i,:);
    amp2_piece = amp2_selec(i,:);
    [crosscorr(i,:),lags] = xcorr(amp1_piece, amp2_piece,round(samp_freq/10),'coeff'); %calculates crosscorrelations between amplitude vectors
    lags = (lags./samp_freq)*1000;                   %converts lags to miliseconds
    g = crosscorr(i,:) == max(crosscorr(i,:));      %identifies index where the crosscorrelation peaks
    max_crosscorr_lag(i) = lags(g);                      %identifies the lag at which the crosscorrelation peaks
    max_crosscorr(i) = max(crosscorr(i,:));
    
%     for j = 1 : shuffletime
%         r = randi(numel(time),1) ;
%         shiftbit = fix(point(r));
%         amp1_shuffle = circshift(amp1_piece',shiftbit)';
%         crosscorr_shuffle = xcorr(amp1_shuffle, amp2_piece,round(samp_freq/10),'coeff');
%         max_crosscorr_shuffle(i,j) = max(crosscorr_shuffle);
%     end
    
end

for i = 1 : shuffletime
    r = randi(numel(time),1) ;
    shiftbit = fix(point(r));
    amp1_shuffle = circshift(amp1,shiftbit);
    amp1_shuffle_selec = amp1_shuffle(time_selec(1)*Fs+1:time_selec(2)*Fs);
    amp1_shuffle_selec = op_epoch(amp1_shuffle_selec,Fs*bin);
        for j = 1 : size(amp1_selec,1)
            amp1_piece_shuffle = amp1_shuffle_selec(j, :);
            amp2_piece = amp2_selec(j,:);
            [crosscorr_shuffle,lags] = xcorr(amp1_piece_shuffle, amp2_piece,round(samp_freq/10),'coeff');
            max_crosscorr_shuffle(j,i) = max(abs(crosscorr_shuffle));
        end
end

p_value = zeros(1,size(amp1_selec,1));
for i = 1 :  size(amp1_selec,1)
    p_value(i) = op_shuffpvalue(max_crosscorr_shuffle(i,:),max_crosscorr(i));
end


if flag == 1
    figure('color',[1 1 1])
    plot(lags, crosscorr,'color',[0 0 1],'linewidth',2),hold on %plots crosscorrelations
    plot(lags(g),crosscorr(g),'rp','markerfacecolor',[1 0 0],'markersize',10)%plots marker at the peak of the cross correlation
    plot(lags, 0.95*min(crosscorr), 'color',[0 0 0],'linestyle',':', 'linewidth',2) %plots dashed line at zero lag
    plot(lags, 1.05*max(crosscorr), 'color',[0 0 0],'linestyle',':', 'linewidth',2) %plots dashed line at zero lag
    set(gca,'xtick',[-100 -50 0 50 100])
    axis tight, box off, xlim([-101 100])
    xlabel('Lag (ms)','fontsize',14)
    ylabel('Crosscorrelation','fontsize',14)
end

