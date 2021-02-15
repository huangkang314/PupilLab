function op_anesthesia_electrophysiology_ana(path)
file = importdata([path,'\data.mat']);
names = fieldnames(file);
Num = numel(names);
file = struct2cell(file);
if ~strcmpi(path(end),'x')
    samecell = importdata([path,'\same.txt']);
end
%  先寻找同样的细胞
% for i = 1 : Num:size(samecell,1)
%     tf = zeros(1,Num);
%     wave = cell(1,Num);
%     for j = 1:Num
%         samechan1 = samecell(i+j-1,:);
%         if sum(samechan1) ~= 0
%             chan1 = file{j}.chan_cell;
%             pos1 = ismember(chan1,samechan1,'rows');
%             pos1 = find(pos1 == 1, 1);
%             if ~isempty(pos1)
%                 tf(j) = 1;
%                 wave1 = file{j}.wave1elec;
%
%             else
%                 tf(j) = 0;
%             end
%         else
%             tf(j) = 0;
%         end
%
%     end
%     corrcoef(wave{1},wave{4})
% end

for i_sti = 1 : Num
    file1 = file{i_sti};
    ts = getfield(file1,'ts');
    chan = getfield(file1,'chan_cell');
    wave1Electrode = getfield(file1,'wave1elec');
    info = getfield(file1,'info');
    event = getfield(file1,'event');
    
    Dx1 = diff(event);
    findvalue = Dx1(1) + 1;
    pos = op_findsamevalueInterval(Dx1, findvalue);
    event = event(pos);
    
    for j_cell = 1 : numel(file1.ts)
        ts1 = ts{j_cell}  ;
        chan1 = chan(j_cell,:);
        wave1 = wave1Electrode(j_cell,:);
        select_param = [-10 30];
        bin = 1;
        dot = 'show';
        shuffletime = 10000;
        maxshuff = zeros(1,shuffletime);
        minshuff = zeros(1,shuffletime);
        alpha = .0001;
        Fs = 40000;
        
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
        
        [preevent,xx,cc] = op_perievent(event,ts1,select_param,bin,dot,'on');
        
%         bin_begin = find(xx>shuffle_time(1)/bin,1,'first');
%         bin_end = find(xx > shuffle_time(2)/bin,1,'last');
%         if max(preevent(bin_begin:bin_end)) > maxconInterval 
%             char = 'sig Incre';
%         elseif min(preevent(bin_begin:bin_end)) < minconInterval
%             char = 'sig Decre';
%         else
%             char = 'Non';
%         end
        
        print(gcf,'-dpng','-r300',[path,'\pic\',names{i_sti},'_chan ',num2str(chan1),'  ',char,'  preevent.png']);
        close gcf
        
%         x1 = 1/Fs:1/Fs:1/Fs*numel(wave1);
%         x1 = x1*1000;
%         plot(x1,wave1','k','linewidth',2);xlabel('Time [ms]');ylabel('Amplitude [mv]')
%         op_setfigpar(gca)
%         
%         print(gcf,'-dpng','-r300',[path,'\pic\',names{i_sti},'_chan ',num2str(chan1),'  ',char,'  wave.png']);
%         close gcf
        
    end
    
end
end
