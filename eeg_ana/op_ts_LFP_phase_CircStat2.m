function [phasespike,mu,unwrappedout,pval,pvalori,r] = op_ts_LFP_phase_CircStat2(LFP,tsLFP,ts,Fs)
% 输入LFP为输入的piece，tsLFP为piece截取的时间点
% Compute phase and amplitude using Hilbert transform
Numpiece = numel(LFP);

% PhaseOri = zeros(Numpiece,LFPlong);
phasespike = [];
unwrappedout = [];
for i_piece = 1 : Numpiece
    if iscell(LFP)
        LFP_1piece = LFP{i_piece};
    else
        LFP_1piece = LFP(i_piece,:);
    end
    t_1piece = tsLFP(i_piece,: );
    
    if real(LFP_1piece(1)) == LFP_1piece(1)
        h = hilbert(LFP_1piece);
    else
        h = LFP_1piece;
    end
    
 phase = mod(angle(h),2*pi);
%     phase = angle(h);
    unwrapped = unwrap(phase);
%     PhaseOri{i_piece,:} = phase;
    
    %     circ_plot(phase,'hist',[],20,true,true,'linewidth',2,'color','r')
    
    pvalori = circ_rtest(phase);
    
    % 截取中间 300 s 数据
    period = length(LFP_1piece);
    phasetime = t_1piece(1): 1/Fs :  t_1piece(1) + period/Fs -1/Fs;
    tsin = ts(find(ts > min(phasetime),1,'first') : find(ts < max(phasetime),1,'last'));
    maxGap = Inf;
    
    if ~isempty(tsin) && pvalori > .05
        [~,~,~,loc] = match(tsin,phasetime,'match','closest','error',maxGap);
        phase_1piece = phase(loc);
        unwrapped_1piece = unwrapped(loc);
        phasespike = [phasespike;phase_1piece];
        unwrappedout = [unwrappedout;unwrapped_1piece];
    end
    
end


selectN = 200;
if ~isempty(phasespike) %&& numel(phasespike) > selectN
    select = randperm(numel(phasespike));
    select= select(1 : selectN);
    phasespike = phasespike(select);
    pval = circ_rtest(phasespike);
    r = circ_r(phasespike);
    mu = circ_mean(phasespike);
end

% % circ_plot(phasespike,'hist',[],20,true,true,'linewidth',2,'color','r')
% circ_plot(phasespike,'hist',[],20,true,true,'linewidth',2,'color','r')
