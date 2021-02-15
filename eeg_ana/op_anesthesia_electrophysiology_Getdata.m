function op_anesthesia_electrophysiology_Getdata(path)
file = importdata([path,'\path.txt']);
Num = numel(file);
for i = 1 : Num
        file1 = file{i};        
        stifreq = file1(end-3:end-2);
        filename= [file1,'-sorting.plx'];
        filetxt = [file1,'-sorting.txt'];
        chan = importdata(filetxt);
        chan(1,:) = [];
        [~,~,~,~,Trodalness] = plx_information(filename);
        
        if Trodalness == 1
            % 如果是单根电极记录
            [ts,wave1elec,waveTelec,chan_cell,~,LR_T,IsoD_T,Trodalness,info] = op_readcell_single(filename,chan);
        elseif Trodalness == 2
            % 如果是stereo电极记录
            [ts,wave1elec,waveTelec,chan_cell,~,LR_T,IsoD_T,Trodalness,info] = op_readcell_stereo(filename,chan);
        elseif Trodalness == 4
            % 如果是tetrode电极记录
            [ts,wave1elec,waveTelec,chan_cell,~,LR_T,IsoD_T,Trodalness,info] = op_readcell_tetrode(filename,chan);
        end
        event = ReadEvent(filename,32);
        data.ts = ts;
        data.wave1elec = wave1elec;
        data.waveTelec = waveTelec;
        data.chan_cell = chan_cell;
        data.LR_T = LR_T;
        data.IsoD_T = IsoD_T;
        data.Trodalness = Trodalness;
        data.info = info;
        data.event = event;
        eval(['dataall.f',num2str(stifreq),'Hz = data;'])
end
save([path,'\data'],'dataall')
