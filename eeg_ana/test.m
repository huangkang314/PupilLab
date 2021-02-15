clc;clear;
path = 'G:\data process\NAc\NAc_EPM_electrophysiology\path2.txt';
positiondata = importdata(path);
Num = numel(positiondata);
ind = 1;
for i = 1 : Num
    pathone = positiondata{i};
    pathone = [pathone(1:end-5),'.mat'];
    load(pathone);
    count = numel(NAc);
    NAcT(ind:ind+count-1) = NAc;
    ind = ind+count;
end
pathin = 'G:\data process\NAc\pic';
topC57_ana_EPM_part2(NAcT,pathin)


clc;clear;
path = 'G:\data process\NAc\NAc_photostimulation_freemoving\path.txt';
positiondata = importdata(path);
Num = numel(positiondata);
ind = 1;
for i = 1 : Num
    pathone = positiondata{i};
    pathone = [pathone(1:end-4),'.mat'];
    load(pathone);
    count = numel(NAc);
    NAcT(ind:ind+count-1) = NAc;
    ind = ind+count;
end
pathin = 'G:\data process\NAc\pic';
topC57_ana_EPM_opto(NAcT,pathin)



% %% -------------不同光刺激频率LFP变化-------
% clear;clc;
% path{1} = 'G:\data process\NAc\NAc_photostimulation\20130903\site 1\20130903-01-10Hz.plx';
% path{2} = 'G:\data process\NAc\NAc_photostimulation\20130903\site 1\20130903-01-20Hz.plx';
% path{3} = 'G:\data process\NAc\NAc_photostimulation\20130903\site 1\20130903-01-60Hz.plx';
% for i = 1 : numel(path)
%     op_anesthesia_electrophysiology_ana_lfp(path);
% end
%
%
% clc;clear;
% path = 'G:\data process\NAc\NAc_photostimulation_freemoving\path.txt';
% positiondata = importdata(path);
% Num = numel(positiondata);
% ind = 1;
% for i = 1 : Num
%     pathone = positiondata{i};
%     pathone = [pathone(1:end-4),'.mat'];
%     load(pathone);
%     count = numel(NAc);
%     NAcT(ind:ind+count-1) = NAc;
%     ind = ind+count;
% end
% pathin = 'G:\data process\NAc\pic';
% topC57_ana_EPM_opto(NAcT,pathin)


clc;clear;
path = 'G:\data process\NAc\NAc_photostimulation_freemoving\path.txt';
positiondata = importdata(path);
Num = numel(positiondata);
for i = 1 : Num
    pathone = positiondata{i};
    %     pathone = 'G:\data process\NAc\NAc_photostimulation_freemoving\NAc049\20140422\NAc049-04-22-C57.plx';
    %     op_select_Maxpowerchan(pathone,'theta');
    NAc1day = topC57_NAc_EP_Getdata_optosti(pathone);
end

clc;clear;
path = 'G:\data process\DISC1\photostimulation\path.txt';
positiondata = importdata(path);
Num = numel(positiondata);
ind = 1;
for i = 1 : Num
    pathone = positiondata{i};
    pathone = [pathone(1:end-4),'.mat'];
    load(pathone);
    count = numel(data.ts);
    for i_cell = 1 : count
        data1.ts = data.ts{i_cell};
        data1.wave1elec = data.wave1elec(i_cell, : );
        data1.waveTelec = data.waveTelec(i_cell, :);
        data1.wavetotal = data.wavetotal{i_cell};
        data1.chan_cell = data.chan_cell(i_cell, :);
        data1.LR_T = data.LR_T(i_cell);
        data1.IsoD_T = data.IsoD_T(i_cell);
        data1.Trodalness = data.Trodalness;
        data1.info = data.info;
        data1.event = data.event;
        NAcT(ind) = data1;
        ind = ind + 1;
    end
end
op_disc1_anesthesia_electrophysiology_ana_selec(NAcT,path)


% clc;clear;
path = 'G:\data process\NAc\NAc_photostimulation_freemoving\path.txt';
positiondata = importdata(path);
Num = numel(positiondata);
ind = 1;
for i = 1 : Num
    pathone = positiondata{i};
    pathone = [pathone(1:end-4),'.mat'];
    load(pathone);
    count = numel(NAc);
    NAcT(ind:ind+count-1) = NAc;
    ind = ind+count;
end
pathin = 'G:\data process\NAc\pic';
topC57_ana_EPM_opto(NAcT,pathin)


clc;clear;
path = 'G:\data process\DISC1\photostimulation\path.txt';
positiondata = importdata(path);
Num = numel(positiondata);
ind = 1;
for i = 1 : Num
    pathone = positiondata{i};
    pathone = [pathone(1:end-4),'.mat'];
    load(pathone);
    count = numel(data.ts);
    for i_cell = 1 : count
        data1.ts = data.ts{i_cell};
        data1.wave1elec = data.wave1elec(i_cell, : );
        data1.waveTelec = data.waveTelec(i_cell, :);
        data1.wavetotal = data.wavetotal{i_cell};
        data1.chan_cell = data.chan_cell(i_cell, :);
        data1.LR_T = data.LR_T(i_cell);
        data1.IsoD_T = data.IsoD_T(i_cell);
        data1.Trodalness = data.Trodalness;
        data1.info = data.info;
        data1.event = data.event;
        NAcT(ind) = data1;
        ind = ind + 1;
    end
end
op_disc1_anesthesia_electrophysiology_ana_selec(NAcT,path)

%% ------------- 在homecage里面放电两种光刺激放电率响应 两次实验-----------
clear;clc;
path{1} = 'G:\data process\NAc\NAc_photostimulation_freemoving\NAc043\20140121\NAc043 07-60hz 20140121_mrg.plx';
path{2} = 'G:\data process\NAc\NAc_photostimulation_freemoving\NAc044\20140121\NAc044 07-60hz 20141021_mrg.plx';
for i = 1 : numel(path)
    path1 = path{i};
    path11 = [path1,'1'];
    %     C57_chanselect_DISC1(path11)
    op_anesthesia_electrophysiology_GetdatawithLFP(path1);
end

clc;clear;
path{1} = 'G:\data process\NAc\NAc_photostimulation_freemoving\NAc043\20140121\NAc043 07-60hz 20140121_mrg.mat';
path{2} = 'G:\data process\NAc\NAc_photostimulation_freemoving\NAc044\20140121\NAc044 07-60hz 20140121_mrg.mat';
Num = numel(path);
for i = 1 : Num
    path1 = path{i};
    op_homecage_electrophysiology_ana(path1);
end