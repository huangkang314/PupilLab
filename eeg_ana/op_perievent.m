function [preevent,xx,cc] = op_perievent(event, ts, timespan, bin, dot, show,Interval,type)
% 计算preevent raster
% 如果
color = 'r';
if nargin < 5
    dot = 'show';
end
if nargin<8
    Interval=[];
end
xx = timespan(1) : bin : timespan(2);
Num = numel(event);
preevent = zeros(Num,numel(xx));
for i = 1 : Num
    event1 = event(i);
    ts_diff = ts - event1;
    fitbin = histc(ts_diff,xx);
    preevent(i,:) = fitbin;
end
% xx = xx*1000;%转化为毫秒
dotpoint = preevent;

if strcmpi(type,'freq')
    preevent = smooth(mean(preevent,1)/bin,10);      % Hz
    ylabel_str = 'Frequency [Hz]';
elseif strcmpi(type,'prob')
    preevent = sum(preevent,1)/numel(event);  % Probability
    ylabel_str = 'Probability';
end

cc = [];
if strcmp(show,'on');
    h = bar(xx,preevent,'k','edgecolor',color);
    set(h,'facecolor',color,'edgecolor',color)
    set(gcf,'color',[1 1 1])
    xlabel('Time [s]');
    %     ylabel('Rate [Hz]');
    ylabel(ylabel_str);
    box off
    gap = .02;
    hold on
    gcaxlim = xlim;
    ax1 = gca;
    
%         line([-10 20],[Interval(1), Interval(1)],'linewidth',2,'color','r','linestyle','--')
    %     line([-10 20],[Interval(2), Interval(2)],'linewidth',2,'color','r','linestyle','--')
    
    if strcmp(dot,'show')
        ybegin = 1;
        set(gca,'position',[.1 .12 .8 .45])
        
        ax2 = axes('position',[.1 .57 .8 .4],'xlim',[gcaxlim(1),gcaxlim(end)]);
        hold on
        cc = 1;
        for i_trial = 1 : size(dotpoint,1)
            dot1 = dotpoint(i_trial,:);
            if sum(dot1) > 0
                logicaldot1 = logical(dot1);
                plot(ax2,xx(logicaldot1),ybegin + gap*cc,[color,'o'],'markersize',2,'MarkerFaceColor',color);
                cc = cc+1;
            end
        end
        set(gca,'box','off');axis off
        
    end
    set(ax1,'xlim',timespan)
    
    if strcmp(dot,'show')
        set(ax2,'xlim',timespan)    
        op_setfigpar(ax2)
    end
    
    
    %     set(ax1,'xlim',[-0.0103 0.02] * 1000)
        set(ax1,'ylim',[60 70])
    op_setfigpar(ax1)

end