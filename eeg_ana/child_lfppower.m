function child_lfppower(NAc,event)
% global path
% 提取每一次实验的 LFP，因为NAc 中是按照细胞排布，则要删除重复的 trial
info = op_getfield(NAc,'info');
[~,index] = unique(info,'first');
index = sort(index);
NAc1=NAc(index);
event1=event(index);
% index(end + 1) = Numcell;
cc = 1;

Thetapower = zeros(numel(NAc1),2);
% S_total = zeros(8921,213);
Fs = 1000;
findvalue = 1;
timeperiod = 3.5;
nrow = 16;
ncol = 82;
Fs = 1000;
window = 2; % 设置窗长度为 2 s
band = 4;
TW = window*band; % 窗长度为 2 s，半频带宽度为 4；TW = 2*4 = 8；
K = 2*TW - 1; % K = 2*TW -1 = 15
tapers = [TW,K];
params.tapers = tapers;
params.err = 0;
params.Fs = Fs;
params.fpass = [0 80] ; % show results between 0 and 100 Hz
params.trialave = 0;
win = 5;
movingwin = [10,.5];
nfft = 2^nextpow2(movingwin(1) * Fs);
df = Fs/nfft;
f = 0:df:Fs; 
pointlong = nnz(f >= params.fpass(1) & f<= params.fpass(end));

lfp_power_low = cell(1,numel(NAc1));  %%stim
lfp_power_high = cell(1,numel(NAc1));
lfp_power_all = cell(1,numel(NAc1));%no stim
Hd = notch60hz;
Hd1 = notch;
% S_close = zeros(nrow, ncol, numel(NAc));
% S_open = zeros(nrow, ncol, numel(NAc));
for i_trial = 1 : numel(NAc1)
    disp( i_trial )
%     Pos = NAc{i_trial}.Pos;
    time = NAc1{i_trial}.time;
    LFP = NAc1{i_trial}.lfp;
    high=event1(i_trial).high;
    low=event1(i_trial).low;

    lfp_power_high_piece = cell(1,numel(high));

    for j_piece = 1 : numel(high)
                timetrain=high{j_piece};
                timebegin =  timetrain(1);
                timeend = timetrain(end);
                timepoint_high(j_piece,:)=[fix(timebegin *Fs), fix(timeend * Fs)];
                lfp1 = LFP(fix(timebegin *Fs) :  fix(timeend * Fs));
               lfp1 = filtfilt(Hd.sosMatrix,Hd.ScaleValues,lfp1);
                lfp1 = filtfilt(Hd1.sosMatrix,Hd1.ScaleValues,lfp1);
%                 lfp1 = (lfp1 - mean(lfp1))/std(lfp1);

            lfp_power_high_piece{j_piece}= mtspectrumsegc_he(lfp1,movingwin,params);

    end
    lfp_power_high_piece = cell2mat(lfp_power_high_piece);    
    if isempty(mean(lfp_power_high_piece,2))
         lfp_power_high{i_trial}=zeros(ncol,1);
    else
        lfp_power_high{i_trial} = mean(lfp_power_high_piece,2);
    end

    
     lfp_power_low_piece = cell(1,numel(low));

    for j_piece = 1 : numel(low)
                timetrain=low{j_piece};
                timebegin =  timetrain(1);
                timeend = timetrain(end);
                timepoint_low(j_piece,:)=[fix(timebegin *Fs), fix(timeend * Fs)];
                lfp1 = LFP(fix(timebegin *Fs) :  fix(timeend * Fs));
                lfp1 = (lfp1 - mean(lfp1))/std(lfp1);

            [lfp_power_low_piece{j_piece},f]= mtspectrumsegc_he(lfp1,movingwin,params);

    end
    lfp_power_low_piece = cell2mat(lfp_power_low_piece);    
    if isempty(mean(lfp_power_low_piece,2))
         lfp_power_low{i_trial}=zeros(ncol,1);
    else
        lfp_power_low{i_trial} = mean(lfp_power_low_piece,2);
    end

        
         
timepoint=[timepoint_high;timepoint_low];
marker=zeros(numel(LFP),1);
for i=1:size(timepoint,1)
    marker(timepoint(i,1):timepoint(i,2))=1;
end
LFP1=LFP(1:600*1000);
LFP1= filtfilt(Hd.sosMatrix,Hd.ScaleValues,LFP1);
LFP1= filtfilt(Hd1.sosMatrix,Hd1.ScaleValues,LFP1);
% LFP1(find(marker==1))=[];
% LFP1 = (LFP1 - mean(LFP1))/std(LFP1);
 lfp_power_all{i_trial}= mtspectrumsegc_he(LFP1,movingwin,params);

%     Posvalue = NAc{i_trial}.thetapower;
%     Thetapower(i_trial,1) = nanmean(Posvalue(CloseArm.c));
%     Thetapower(i_trial,2) = nanmean(Posvalue(OpenArm.c));
    
    %     child_plot(Pos,Posvalue,OCarm,'')
    %     set(gcf,'Render','zbuffer')
    %     print(gcf,'-dtiff','-r900',[path,'\epm theta\',num2str(i_trial),'_theta.tiff']);
    %     close gcf
    
end

lfp_power_high = cell2mat(lfp_power_high);
lfp_power_low = cell2mat(lfp_power_low);
lfp_power_all = cell2mat(lfp_power_all);

% zerosindex=union(find(mean(lfp_power_close,1)==0),find(mean(lfp_power_open,1)==0));
% 
% lfp_power_close(:,zerosindex)=[]; lfp_power_open(:,zerosindex)=[];
% S_close = mean(S_close, 3);
% S_open = mean(S_open, 3);
% pcolor(t1,f1,S_close');shading interp; caxis([0 0.04]);
% ylabel('Frequency [Hz]','Fontsize',14);xlabel('Time [s]','Fontsize',14);title('Close arm','Fontsize',14)
% set(gca,'Fontsize',14,'box','on','linewidth',3);set(gcf,'color',[1 1 1]);
% colorbar('fontsize',14,'ytick',[-13 -7],'box','off','ycolor','w')
%
% pcolor(t1,f1,S_open');shading interp;caxis([0 0.04])
% ylabel('Frequency [Hz]','Fontsize',14);xlabel('Time [s]','Fontsize',14);title('Open  arm','Fontsize',14)
% set(gca,'Fontsize',14,'box','on','linewidth',3);set(gcf,'color',[1 1 1]);
% colorbar('fontsize',14,'ytick',[-13 -7],'box','off','ycolor','w')
% diff = S_close-S_open;
% pcolor(t1,f1,diff'); shading interp;

Pthetaclose = zeros(size(lfp_power_high,2),1);
Pthetaopen = zeros(size(lfp_power_all,2),1);
band = [6 12];
for i = 1 : size(lfp_power_all,2)
    %     plot(f,lfp_power_close(:,i));hold on;
    %     plot(f,lfp_power_open(:,i),'r');pause;close gcf
    power_close1 = lfp_power_close(:, i);
    power_open1 = lfp_power_open(:, i);
    Pthetaclose(i) = op_LFPspectrum_selection(power_close1,f,band);
    Pthetaopen(i) = op_LFPspectrum_selection(power_open1,f,band);
end
H = ttest(Pthetaclose,Pthetaopen);

Pmean(1,:) = nanmean(lfp_power_all,2);
Ppverr(1,:) = h_mse(lfp_power_all');
Pmean(2,:) = nanmean(lfp_power_high,2);
Ppverr(2,:) = h_mse(lfp_power_high');

color{1} = 'k';
color{2} = 'r';
legend_str = {'closed arm','open arm'};
threshold = [0 80];
ylimvalue = [.1 .4];
op_plot_varCloud(Pmean,Ppverr,f,color,threshold,'Power','Frequency[Hz]',legend_str,ylimvalue)
if H == 1
    patch([6,12,12,6],[0,0,.05,.05],[.8 .8 .8],'FaceAlpha', .6, 'LineStyle', 'none','linewidth',2);
end
set(gca,'YTick',[0 0.025 0.05],'TickDir','out','FontSize',20)
print(gcf,'-dtiff','-r300',[path,'\epm theta\theta-pv.tiff']);
close gcf

end


