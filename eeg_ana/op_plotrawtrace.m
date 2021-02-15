function op_plotrawtrace(filename,chan,timelong,follow,pathsave)

load('filter300high.mat');
[adfreq, ~, ts, ~, ad] = plx_ad_v(filename,chan);

if ~isempty(ts)
    ad = cat(1,zeros(adfreq * ts, 1),ad);
end

ad = filter(Hd,ad);

[~,event] = plx_event_ts(filename,32);

sig = ad(timelong(1) * adfreq + 1 : timelong(2) * adfreq);
t = 1/adfreq:1/adfreq:numel(sig)*1/adfreq;
plot(t,sig,'k','linewidth',.5);xlabel('Time [s]');ylabel('Amplitude (mV)')
op_setfigpar(gca);
ylim([-.15 .15])
hold on

if strcmpi(follow,'yes')
    event_selec = event(event > timelong(1) & event < timelong(2));
    event_selec = event_selec - timelong(1);
    
    for i_event = 1 : numel(event_selec)
        plot(event_selec(i_event), .13,'.','markersize',24,'color',[0.04 0.52 0.78])
    
    end
    
end

% print(gcf,'-dpng','-r600',pathsave);
% close gcf

% aa1 = aa1(43 * 40000 : 50*40000);
% t = 1/40000:1/40000:numel(aa1)*1/40000;
% plot(t,aa1,'k');xlabel('Time [s]');ylabel('Amplitude (mV)')
% op_setfigpar(gca);

end


