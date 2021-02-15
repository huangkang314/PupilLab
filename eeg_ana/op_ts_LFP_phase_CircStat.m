function [phasespike,mu,unwrappedout,pval,pvalori,r] = op_ts_LFP_phase_CircStat(LFP,tsLFP,ts,Fs,plotselec)
% 输入LFP为输入的piece，tsLFP为piece截取的时间点
% Compute phase and amplitude using Hilbert transform
Numpiece = numel(tsLFP);

% PhaseOri = zeros(Numpiece,LFPlong);
phasespike = [];
unwrappedout = [];
for i_piece = 1 : Numpiece
%     disp(i_piece);
    if iscell(LFP)
        LFP_1piece = LFP{i_piece,:};
    else
        LFP_1piece = LFP(i_piece,:);
    end
    t_1piece = tsLFP(i_piece);
    
    if real(LFP_1piece(1)) == LFP_1piece(1)
        h = hilbert(LFP_1piece);
    else
        h = LFP_1piece;
    end
    
    phase = mod(angle(h),2*pi);
    unwrapped = unwrap(phase);
%     PhaseOri{i_piece,:} = phase;
    
    %     circ_plot(phase,'hist',[],20,true,true,'linewidth',2,'color','r')
    
    pvalori = circ_rtest(phase);
    
    % 截取中间 300 s 数据
    %     phasetime = t_1piece/Fs - period/2/Fs : 1/Fs :  t_1piece/Fs + period/2/Fs -1/Fs;
    period = length(LFP_1piece);
    phasetime = t_1piece/Fs - period/Fs/2: 1/Fs :  t_1piece/Fs + period/Fs/2 -1/Fs;
    tsin = ts(find(ts > min(phasetime),1,'first') : find(ts < max(phasetime),1,'last'));
    maxGap = Inf;
    if strcmp(plotselec,'yes')
        plot(phasetime,LFP_1piece,'r','linewidth',2);hold on;
        for i_ts = 1 : numel(tsin)
            line([tsin(i_ts),tsin(i_ts)],[-1,-1.2],'marker','none','LineStyle','-','LineWidth',2,'Color','b');title(i_piece)
        end
        set(gcf,'position',[ 268 790 1312 203])
        op_setfigpar(gca)
    end
    
    if ~isempty(tsin) && pvalori > .05
        [~,~,~,loc] = match(tsin,phasetime,'match','closest','error',maxGap);
        phase_1piece = phase(loc);
        unwrapped_1piece = unwrapped(loc);
        phasespike = [phasespike,phase_1piece];
        unwrappedout = [unwrappedout,unwrapped_1piece];
    end
    
end


selectN = 500;
if ~isempty(phasespike) && numel(phasespike) > selectN
    select = randperm(numel(phasespike));
    select= select(1 : selectN);
    phasespike = phasespike(select);
    pval = circ_rtest(phasespike');
    r = circ_r(phasespike');
    mu = circ_mean(phasespike');
else
    pval = NaN;
    r = NaN;
    mu = NaN;
end

% % circ_plot(phasespike,'hist',[],20,true,true,'linewidth',2,'color','r')
% circ_plot(phasespike,'hist',[],20,true,true,'linewidth',2,'color','r')
