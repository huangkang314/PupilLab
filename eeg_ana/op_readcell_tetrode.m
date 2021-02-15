function [ts_T,wave1elec,waveTelec,chan_cell,firewave,LR_T,IsoD_T,Trodalness,info] = op_readcell_tetrode(filename,chan)
%--------------Ԥ�������-----------------------%
cc = 1;
ts_T = [];    % cell �ṹ
wave1elec = [];
waveTelec = [];
chan_cell = [];
firewave = []; % cell �ṹ
LR_T = [];
IsoD_T = [];
%--------------�ҵ���spike��ͨ��---------------%
chanindex = find(chan(:,1) == 100) - 1; %��chan��д��100,200,300....��Щ��ͷ�����ֶ���ÿһ��chanϸ���ı��(�ڼ���ϸ����������)
DSPchan = chan(chanindex,:);                % ��Ӧ��chan�ı��
% -----------�� cell ����Ϣ��ȡ����--------------%
[info,~,~,~,Trodalness,wavelong,~,~,~,~,~,~,~] = plx_information(filename);
for i_chan = 1 : size(DSPchan,1);    % ÿһ��ͨ��
    disp(i_chan)
    Numcell = DSPchan(i_chan,2);
    DSPchanNum = DSPchan(i_chan,1);
    
    spikewavetotal = cell(Numcell,Trodalness);
    cellwaveunsorted = cell(1,Trodalness);
    ts = cell(Numcell,1);
    %------------��ȡÿһ��ϸ��������--------------%
    for i_cell = 1:Numcell
        %------------һ�������缫(tetrode)-------------%
        for i_electrode = 1:Trodalness
            [~,~,ts{i_cell},spikewavetotal{i_cell,i_electrode}] = plx_waves_v(filename,...
                DSPchanNum + i_electrode-1,i_cell);
        end
    end
    %------------��ÿһ��ͨ����û��sorting�Ĳ���Ҳ��ȡ����,����Lratio��IsodistanceҪ��-----------%
    for i_electrode = 1:Trodalness
        [~,~,~,cellwaveunsorted{i_electrode}] = plx_waves_v(filename,DSPchanNum + i_electrode-1,0);
    end
    % --------------��ÿ��cell����Ϣ----------------%
    if i_chan ~= size(DSPchan,1)
        cellbegin = chan(chanindex(i_chan)+1:chanindex(i_chan+1)-1,:);
    else
        cellbegin = chan(chanindex(i_chan)+1:end,:);
    end
    cellbegin(cellbegin >= 100) = cellbegin(cellbegin >= 100)/100;
    for i_cell = 1:size(cellbegin,1)/4
        spikewavebase  = spikewavetotal;
        spikewaveOnecell = spikewavebase(i_cell,:);
        spikewavebase(i_cell,:) = [];
        spikenoise = cat(1,spikewavebase,cellwaveunsorted);
        
        feature_index = cellbegin(2+(i_cell-1)*4:4+(i_cell-1)*4,:);
        Num_dim = size(feature_index,1);
        Feaspike_Norm = zeros(size(spikewaveOnecell{1},1) + size(cell2mat(spikenoise),1),4);
        Feaspike_UnNorm = Feaspike_Norm;
        for i_dimension = 1:Num_dim
            feature1index= feature_index(i_dimension,:);
            spikewave = spikewaveOnecell{feature1index(1)};
            noisewave = spikenoise(:,feature1index(1));
            noisewave = cell2mat(noisewave);
            wave = cat(1,spikewave,noisewave);
            
            norm = 1;
            Fea = F_WavePCA(wave,norm);
            Fea = Fea(:,feature1index(2));
            Feaspike_Norm(:,i_dimension + 1) = Fea;
            
            norm = 0;
            Fea = F_WavePCA(wave,norm);
            Fea = Fea(:,feature1index(2));
            Feaspike_UnNorm(:,i_dimension + 1) = Fea;
            
        end
        aa = spikewaveOnecell{cellbegin((i_cell-1)*4+1,2)};
        bb =  cell2mat(spikenoise(:,cellbegin((i_cell-1)*4+1,2)));
        
        Feaspike_Norm(:,1) = F_Energy(cat(1,aa,bb));
        Feaspike_UnNorm(:,1) = Feaspike_Norm(:,1);
        
        spikewaveOnecell_elec = spikewaveOnecell(cellbegin((i_cell-1)*4+1,2));
        spikewaveOnecell_elec = cell2mat(spikewaveOnecell_elec);
        spikenoise = spikenoise(:,cellbegin((i_cell-1)*4+1,2));
        spikenoise = cell2mat(spikenoise);
        
        cellindex = [ones(1,size(spikewaveOnecell_elec,1)),zeros(1,size(spikenoise,1))];
        
        spikewaveOnecell = cell2mat(spikewaveOnecell);
        wave = mean(spikewaveOnecell);wave1 = wave((cellbegin((i_cell-1)*4+1,2)-1)*wavelong+1:(cellbegin((i_cell-1)*4+1,2)*wavelong));
        
        [~,LR(1),IsoD(1)] = child_spkremove(Feaspike_Norm,cellindex);
        [~,LR(2),IsoD(2)] = child_spkremove(Feaspike_Norm(:,2:end),cellindex);  % ֻҪPCA��feature
        [~,LR(3),IsoD(3)] = child_spkremove(Feaspike_UnNorm,cellindex);
        [~,LR(4),IsoD(4)] = child_spkremove(Feaspike_UnNorm(:,2:end),cellindex);    % ֻҪPCA��feature
        LR = min(LR);IsoD = max(IsoD);
        
        ts_T{cc} = ts{i_cell};
        wave1elec  = [wave1elec;wave1];
        waveTelec  = [waveTelec;wave];
        chan_cell1 = [DSPchan(i_chan),i_cell];
        chan_cell = [chan_cell;chan_cell1];
        firewave{cc} = spikewaveOnecell_elec;
        LR_T = [LR_T;LR];
        IsoD_T = [IsoD_T;IsoD];
        cc = cc+1;
        
    end
end

if numel(unique([numel(ts_T),size(wave1elec,1),size(waveTelec,1),size(chan_cell,1),numel(firewave),...
        numel(LR_T),numel(IsoD_T)])) ~= 1
    error('cell number error');
end

% DE = LR_T > .2 | IsoD_T < 12;
DE=[];
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