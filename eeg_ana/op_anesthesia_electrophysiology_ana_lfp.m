function op_anesthesia_electrophysiology_ana_lfp(file)
LFPchan = 84;
window = 1; % 设置窗长度为 1 s
band = 3;
fpass = [0 200];

for i = 1 : numel(file)
    file1 = file{i};
    [Fs,~,~,~,LFP] = plx_ad_v(file1,LFPchan);
    Event = ReadEvent(file1,32);
    [S,t,f] = op_timefrequency_taper(LFP,Fs,window,band,fpass);
    pcolor(t',f',log10(S')); shading interp;
    ylabel('Frequency [Hz]')
    xlabel('Time [s]')
    op_setfigpar(gca)
    print(gcf,'-dpng','-r300',['G:\data process\NAc\pic\photo stimulation\',file1(end-7:end-4),'.png']);
    close gcf
end













end