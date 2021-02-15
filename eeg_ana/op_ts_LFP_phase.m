function [phasespike,amplitudeout,unwrappedout,r_total,pval,pvalori,num] = op_ts_LFP_phase(LFP,ts,Fs,shiftbin,shifttime)
% 输入LFP为输入的piece，tsLFP为piece截取的时间点
% Compute phase and amplitude using Hilbert transform
h = hilbert(LFP);
phase = mod(angle(h),2*pi);
amplitude = abs(h);
unwrapped = unwrap(phase);
PhaseOri = phase;
alpha = .05;
%     circ_plot(phase,'hist',[],20,true,true,'linewidth',2,'color','r')

pvalori = circ_rtest(phase);

phasetime = 0 : 1/Fs :  numel(LFP)*1/Fs -1/Fs;
tsin = ts(find(ts > min(phasetime),1,'first') : find(ts < max(phasetime),1,'last'));
maxGap = Inf;

if ~isempty(shifttime)
    num = shifttime/shiftbin * 2 + 1;
    phasespike_total = cell(num,1);
    amplitude_total = cell(num,1);
    unwrapped_total = cell(num,1);
    r_total = zeros(num,1);
    pval = zeros(num,1);
    cc = 1;
    
    for i_shift = - shifttime : shiftbin : shifttime
        tsin_shift1 = tsin + i_shift;  % 移动time bin
        tsin_shift1(tsin_shift1 < 0) = [];
        tsin_shift1(tsin_shift1 > max(phasetime)) = [];
        [~,~,~,loc] = match(tsin_shift1,phasetime,'match','closest','error',maxGap);
        phasespike_total{cc} = phase(loc);
        amplitude_total{cc} = amplitude(loc);
        unwrapped_total{cc} = unwrapped(loc);
        r_total(cc) = circ_r(phase(loc));
        pval(cc) = circ_rtest(phase(loc));
        cc = cc + 1;
    end
    
    phasespike = phasespike_total{pval == min(pval)};
    amplitudeout = amplitude_total{pval == min(pval)};
    unwrappedout = unwrapped_total{pval == min(pval)};
    
else
    [~,~,~,loc] = match(tsin,phasetime,'match','closest','error',maxGap);
    phasespike = phase(loc);
    amplitudeout = amplitude(loc);
    unwrappedout = unwrapped(loc);
    r_total = circ_r(phase(loc));
    pval = circ_rtest(phase(loc));
    num = 1;
end

% ransel = 200;
% if ~isempty(phasespike) %&& numel(phasespike) > ransel
% %     phasespike = op_randselectinData(phasespike,ransel);
%
%     pval = circ_rtest(phasespike);
% else
%     pval = NaN;
% end

% % circ_plot(phasespike,'hist',[],20,true,true,'linewidth',2,'color','r')
% circ_plot(phasespike,'hist',[],20,true,true,'linewidth',2,'color','r')
