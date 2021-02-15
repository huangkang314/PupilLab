function op_homecage_electrophysiology_ana(path)
data = importdata(path);
Num = numel(data.ts);
event = data.event;
info = data.info;
lfp = data.LFP;
sti_frequency{1} = '07Hz';
sti_frequency{2} = '60Hz';
select_param(1,:) = [-20 40];
select_param(2,:) = [-.1 .2];
select_param(3,:) = [-0.008 0.02];
bin(1) = 1;
bin(2) = .003;
bin(3) = .0001;
dot = 'show';
shuffletime = 10000;
maxshuff = zeros(1,shuffletime);
minshuff = zeros(1,shuffletime);
alpha = .0001;
Fs = 1000;
ratetotal = zeros(Num,3);
xlswrite([path(1 :68),'pic\rate'],{'base','7Hz','60Hz'},'C1:E1')

timerange = 100; % ms
% bin = 10; % ms
confidence_level = [];
% tsref = data.ts{2};%tsref(tsref > 300) = [];
% tstar = data.ts{3};%tstar(tsref > 300) = [];
% cross_correlation = spk_cross_correlation(tsref,tstar,timerange,bin,confidence_level,'a','on');

tsforsti = cell(Num,2);


for i_cell= 1 : Num
    ts1 = data.ts{i_cell};
    wave1 = data.wave1elec(i_cell,:);
    chan1 = data.chan_cell(i_cell,:);
    Dx1 = diff(event);
    findvalue = 0.2;
    [pos,long] = op_findsamevalueInterval(Dx1, findvalue);
    pos(long < 10) = []; long(long < 10) = [];
    
    tsbase = ts1(ts1 < event(1));
    ratebase = numel(tsbase)/max(tsbase);
    
    lfp = lfp - mean(lfp);
    lfp = lfp/std(lfp);
    window = 1; % 设置窗长度为 2 s
    band = 3;
    TW = window*band; % 窗长度为 2 s，半频带宽度为 4；TW = 2*4 = 8；
    K = 2*TW - 1; % K = 2*TW -1 = 15
    tapers = [TW,K];
    params.tapers = tapers;
    params.err = [2 .05];
    params.Fs = Fs;
    fpass = [0 100];
    win = 3;
    params.fpass = fpass ; % show results between 0 and 100 Hz
    
%     [S,t,f] = op_timefrequency_taper(lfp,Fs,window,band,fpass);
%     pcolor(t',f',log10(S')); shading interp;ylabel('Frequency [Hz]');xlabel('Time [s]')
%     print(gcf,'-dpng','-r300',[path(1 :68),'pic\timefrequency.png']);
%     close gcf
    
    event_mrg(:,1) = event(pos);event_mrg(:,2) = event(pos+long);
    [~,type] = unique(long,'first');
    type(end + 1) = numel(long) + 1;
    ratesti_total = zeros(numel(type) - 1,1);
    ratebef_total = ratesti_total;
    cohsti_total = zeros(numel(type) - 1,410);
    cohbef_total = cohsti_total;
    for j_type = 1 : numel(type) - 1
        event_type1 = event_mrg(type(j_type) : type(j_type + 1) - 1, :);
        pp(:,1) = pos; pp(:,2) = pos+long;
        ppcat = pp(type(j_type), 1) : pp(type(j_type + 1) - 1, 2);
        event_type2 = event(ppcat);
        
        %% shuffle 求一下confedence interval
        %         show = 'off';
        %         shuffle_time = [0 0.02];
        %         for i_shuff = 1:shuffletime
        %             anospikes = op_shuffleisi(ts1,event, shuffle_time);
        %             preevent = op_perievent(event,anospikes,select_param,bin,dot,show);
        %             maxshuff(i_shuff) = max(preevent);
        %             minshuff (i_shuff) = min(preevent);
        %         end
        %         conInterval = confidence_interval(maxshuff',alpha);
        %         maxconInterval = max(conInterval);
        %
        %         conInterval = confidence_interval(minshuff',alpha);
        %         minconInterval = min(conInterval);
        %%
        
        ratesti = zeros(size(event_type1,1),1);
        cohsti = zeros(size(event_type1,1),410);
        ratebefsti = ratesti;
        cohbef = zeros(size(event_type1,1),410);
        tsinsti = [];
        for i_trial = 1 : size(event_type1,1)
            duration = event_type1(i_trial,2) - event_type1(i_trial,1);
            ts1sti = ts1(ts1 > event_type1(i_trial,1) & ts1 < event_type1(i_trial,2)); tsinsti = [tsinsti;ts1sti];
            ratesti(i_trial) = numel(ts1sti)/(event_type1(i_trial,2) - event_type1(i_trial,1));
            lfp_sti = lfp(fix(event_type1(i_trial,1) * Fs) : fix(event_type1(i_trial,2) * Fs));
            ts1sti_r = ts1sti - event_type1(i_trial,1);
            [C1_sti,~,~,~,~,~,~,~, ~,~] = coherencysegcpt_he(lfp_sti,ts1sti_r,win,params);
            cohsti(i_trial,:) = C1_sti;
            
            ts1bef = ts1(ts1 > event_type1(i_trial,1) - duration & ts1 < event_type1(i_trial,1));
            ratebefsti(i_trial) = numel(ts1bef)/duration;
            lfp_bef = lfp(fix((event_type1(i_trial,1) -duration) * Fs) : fix(event_type1(i_trial,1)) * Fs);
            ts1bef_r = ts1bef - event_type1(i_trial,1) + duration;
            [C1_bef,~,~,~,~,f,~,~, ~,~] = coherencysegcpt_he(lfp_bef,ts1bef_r,win,params);
            cohbef(i_trial,:) = C1_bef;
        end
        tsforsti{i_cell, j_type} = tsinsti;
        
        ratesti_total(j_type) = mean(ratesti);
        ratebef_total(j_type) = mean(ratebefsti);
        
        op_perievent(event_type1(:,1) ,ts1,select_param(1,:),bin(1),'noshow','on');
        ylim([0 20])
        %% 判断是兴奋还是抑制了
        %         bin_begin = find(xx>shuffle_time(1)/bin,1,'first');
        %         bin_end = find(xx > shuffle_time(2)/bin,1,'last');
        %         if max(preevent(bin_begin:bin_end)) > maxconInterval
        %             char = 'sig Incre';
        %         elseif min(preevent(bin_begin:bin_end)) < minconInterval
        %             char = 'sig Decre';
        %         else
        %             char = 'Non';
        %         end
        %%  画图
%         
%                 print(gcf,'-dpng','-r300',[path(1 :68),'pic\',num2str(chan1),' chan type 1 ' sti_frequency{j_type},'   preevent.png']);
%                 close gcf
%         
%                 op_perievent(event_type2 ,ts1,select_param(1 + j_type,:),bin(1 + j_type),'show','on');
%                 print(gcf,'-dpng','-r300',[path(1 :68),'pic\',num2str(chan1),' chan type 2 ' sti_frequency{j_type},'   preevent.png']);
%                 close gcf
%         
%                 x1 = 1/Fs:1/Fs:1/Fs*numel(wave1);
%                 x1 = x1*1000;
%                 plot(x1,wave1','k','linewidth',2);xlabel('Time [ms]');ylabel('Amplitude [mv]')
%                 op_setfigpar(gca)
%         
%                 print(gcf,'-dpng','-r300',[path(1 :68),'pic\',num2str(chan1),' chan wave .png']);
%                 close gcf
        
%         aa = mean(cohsti,1);
%         bb = mean(cohbef,1);
%         plot(f,bb);hold on;plot(f,aa,'r');legend({'bef','sti'});ylabel('Coherence');title(sti_frequency{j_type})
%         print(gcf,'-dpng','-r300',[path(1 :68),'pic\',num2str(chan1),' chan type 1 ' sti_frequency{j_type},'   coherence.png']);
%         close gcf
        
    end
    
    ratetotal(i_cell, :) = [mean(ratebef_total),ratesti_total'];
%     xlswrite([path(1 :68),'pic\rate'],chan1,['A',num2str(i_cell+1),' : B',num2str(i_cell+1)]);
%     xlswrite([path(1 :68),'pic\rate'],ratetotal(i_cell,:),['C',num2str(i_cell+1),' : E',num2str(i_cell+1)])
end

combos = combntns(1: Num,2);
for i_combin = 1 : size(combos,1)
    ref = combos(i_combin, 1);
    tar = combos(i_combin, 2);
    refbase = setdiff(data.ts{ref},cat(1,tsforsti{ref,1},tsforsti{ref,2}));
    tarbase = setdiff(data.ts{tar},cat(1,tsforsti{tar,1},tsforsti{tar,2}));
    [basefire,t] = spk_cross_correlation(refbase,tarbase,timerange,bin,confidence_level,'a','off');
    basefire = child_nor(basefire,t);
    
    stitype1 = spk_cross_correlation(tsforsti{ref,1},tsforsti{tar,1},timerange,bin,confidence_level,'a','off');
    stitype1 = child_nor(stitype1,t);
    
    stitype2 = spk_cross_correlation(tsforsti{ref,2},tsforsti{tar,2},timerange,bin,confidence_level,'a','off');
    stitype2 = child_nor(stitype2,t);
    
    timeselec = t > -50 & t < 75;
    
%     plot(t(timeselec),basefire(timeselec),'b');hold on; ylim([-3 3])
%     plot(t(timeselec),stitype1(timeselec),'r')
%     plot(t(timeselec),stitype2(timeselec),'g')
%     close gcf
    
    
end
end

function datanor = child_nor(data,t)
ref = t < 0;
meanval = mean(data(ref));
datanor = (data - meanval)./meanval;
end


% 画一个raw data 的图
% filename = 'G:\data process\NAc\NAc_photostimulation_freemoving\NAc043\20140121\NAc043 60hz 20140121.plx';
% channel = 0;
% load('filter300high.mat');
% for i = [0 1 2 3 12 13 14 15 20 21 22 23]
% [~, ~, ~, ~, ad] = plx_ad_v(filename,i);
% adfreq{i + 1} = filter(Hd,ad);
% end
% [~,event] = plx_event_ts(filename,32);
% 
% Dx1 = diff(event);
% findvalue = 0.2;
% [pos,long] = op_findsamevalueInterval(Dx1, findvalue);
% pos(long < 10) = []; long(long < 10) = [];
% event = event(pos);
% Fs = 40000;
% for i = [0 1 2 3 12 13 14 15 20 21 22 23]
%     sig = adfreq{i + 1}((event(1) - 10)*Fs :  (event(1)+30)*Fs );
%     t = 1/Fs:1/Fs:numel(sig)*1/Fs;
%     plot(t,sig,'k');axis off
%     pause 
%     close gcf
% %     print(gcf,'-dpng','-r500',['G:\data process\NAc\NAc_photostimulation_freemoving\NAc043\20140121\raw.png']);
% %     close gcf
% end




