function op_anesthesia_electrophysiology_GetdatawithLFP(path)
filename = path;
filetxt = [path(1 : end - 3),'txt'];
chan = importdata(filetxt);

LFPchan = chan(1,1);
chan(1,:) = [];
[~,~,~,~,Trodalness] = plx_information(filename);


if Trodalness == 1
    % 如果是单根电极记录
    [ts,wave1elec,waveTelec,chan_cell,wavetotal,LR_T,IsoD_T,Trodalness,info] = op_readcell_single(filename,chan);
elseif Trodalness == 2
    % 如果是stereo电极记录
    [ts,wave1elec,waveTelec,chan_cell,wavetotal,LR_T,IsoD_T,Trodalness,info] = op_readcell_stereo(filename,chan);
elseif Trodalness == 4
    % 如果是tetrode电极记录
    [ts,wave1elec,waveTelec,chan_cell,wavetotal,LR_T,IsoD_T,Trodalness,info] = op_readcell_tetrode(filename,chan);
end

if LFPchan ~= 0
    plxfilename_lfp_aligned = [filename(1 : end - 4),'-lfp-aligned.plx'];
    %----------------read LFP-----------------%
    [Fs,~,tsLFP,~,LFP] = plx_ad_v(plxfilename_lfp_aligned,LFPchan);  % algin 之后的文件
    addpoint = zeros(round(tsLFP * Fs),1);
    if ~isempty(addpoint)
        LFP = cat(1,addpoint,LFP);
    end
    data.LFP = LFP;
end

event = ReadEvent(filename,32);
data.ts = ts;
data.wave1elec = wave1elec;
data.waveTelec = waveTelec;
data.wavetotal = wavetotal;
data.chan_cell = chan_cell;
data.LR_T = LR_T;
data.IsoD_T = IsoD_T;
data.Trodalness = Trodalness;
data.info = info;
data.event = event;


save([path(1:end-4),'.mat'],'data')
