function [ts_T,wave1elec,waveTelec,chan_cell,firewave,LR_T,IsoD_T,Trodalness,info] = op_readcell_single(filename,DSPchan)
%--------------预定义变量-----------------------%
cc = 1;
ts_T = [];    % cell 结构
wave1elec = [];
waveTelec = [];
chan_cell = [];
firewave = []; % cell 结构
LR_T = [];
IsoD_T = [];
% -----------把 cell 的信息读取出来--------------%
[info,~,~,~,Trodalness] = plx_information(filename);
for i_chan = 1 : size(DSPchan,1);    % 每一个通道
    disp(i_chan)
    Numcell = DSPchan(i_chan,2);
    DSPchanNum = DSPchan(i_chan,1);
    
    spikewavetotal = cell(Numcell,Trodalness);
    cellwaveunsorted = cell(1,Trodalness);
    ts = cell(Numcell,1);
    %------------读取每一个细胞的数据--------------%
    for i_cell = 1:Numcell
        [~,~,ts{i_cell},spikewavetotal{i_cell}] = plx_waves_v(filename,...
            DSPchanNum,i_cell);
    end
    %------------把每一个通道中没有sorting的波形也读取出来,计算Lratio和Isodistance要用-----------%
    for i_electrode = 1:Trodalness
        [~,~,~,cellwaveunsorted{i_electrode}] = plx_waves_v(filename,DSPchanNum,0);
    end
    for i_cell = 1:Numcell
        spikewavebase  = spikewavetotal;
        spikewaveOnecell = spikewavebase(i_cell,:);
        spikewavebase(i_cell,:) = [];
        spikenoise = cat(1,spikewavebase,cellwaveunsorted);
        
        spikewave = spikewaveOnecell{1};
        noisewave = spikenoise{1};
        wave = cat(1,spikewave,noisewave);
        
        norm = 1;
        Feaspike_Norm = F_WavePCA(wave,norm);
        
        norm = 0;
        Feaspike_UnNorm = F_WavePCA(wave,norm);
        
        Fea_energy = F_Energy(wave);
        Feaspike_Norm = cat(2,Feaspike_Norm,Fea_energy);
        Feaspike_UnNorm = cat(2,Feaspike_UnNorm,Fea_energy);
        
        cellindex = [ones(1,size(spikewaveOnecell{1},1)),zeros(1,size(spikenoise{1},1))];
        
        wave1 = mean(spikewaveOnecell{1});
        spikewaveOnecell = cell2mat(spikewaveOnecell);
        
        [~,LR(1),IsoD(1)] = child_spkremove(Feaspike_Norm,cellindex);
        [~,LR(2),IsoD(2)] = child_spkremove(Feaspike_UnNorm,cellindex);
        LR = min(LR);IsoD = max(IsoD);
        
        ts_T{cc} = ts{i_cell};
        wave1elec  = [wave1elec; wave1];
        waveTelec  = [waveTelec;wave1];
        chan_cell1 = [DSPchan(i_chan),i_cell];
        chan_cell = [chan_cell;chan_cell1];
        firewave{cc} = spikewaveOnecell;
        LR_T = [LR_T;LR];
        IsoD_T = [IsoD_T;IsoD];
        cc = cc+1;
        
    end
end

if numel(unique([numel(ts_T),size(wave1elec,1),size(waveTelec,1),size(chan_cell,1),numel(firewave),...
        numel(LR_T),numel(IsoD_T)])) ~= 1
    error('cell number error');
end

DE = LR_T > .2 | IsoD_T < 15;
ts_T (DE) = [];
wave1elec(DE,:) = [];
waveTelec(DE,:) = [];
chan_cell(DE,:) = [];
firewave(DE) = [];
LR_T(DE) = [];
IsoD_T(DE) = [];
end

function [removeIndex,Lratio, IsoDistance]= child_spkremove(Fea,cellindex)
Lratio = L_Ratio(Fea,cellindex);
IsoDistance = IsolationDistance(Fea,cellindex);
if numel(Lratio) ~= numel(IsoDistance)
    error('cell number is incorrect')
end
De = find(Lratio > .2 | IsoDistance < 15);
removeIndex = De;
end