function op_lfp_power_change_by_optosti(file, fpass, pathsave)
[~,chan] = plx_ad_chanmap(file);
[~,freqs] = plx_adchan_freqs(file);
[~,chandata] = plx_adchan_samplecounts(file);
chan = chan(chandata ~= 0 & freqs == 1000);
Numchan = numel(chan);

window = 4; % 设置窗长度为 1 s
band = 3;

for j = 1 : 1
    [Fs,~,~,~,lfp] = plx_ad_v(file,chan(j));
    event = ReadEvent(file,32);
    Dx1 = diff(event);
    findvalue = 0.2;
    [pos,long] = op_findsamevalueInterval(Dx1, findvalue);
    pos(long < 1000) = []; 
    event = event(pos);
    sig = lfp((event(1) - 10)*Fs :  (event(end)+40)*Fs);
    load('filter50Hz.mat')
    sig = filter(Hd,sig);
    
    [S,t,f] = op_timefrequency_taper(sig,Fs,window,band,fpass);
    plot_matrix_he(S,t,f)
    h = colorbar;
    ylabel('Frequency [Hz]')
    xlabel('Time [s]')
    op_setfigpar(gca)
    op_setfigcolorbar(h,'Log(power)',[])
    print(gcf,'-dpng','-r600',pathsave);
    close gcf
end
