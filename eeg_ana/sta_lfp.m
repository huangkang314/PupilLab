Fs=1000;i_trial=5;   Hd=theta_filter; Hd1=notch;Hd2=notch60hz;

    ts = PV{i_trial}.ts;
    time = PV{i_trial}.duration;
    LFP = PV{i_trial}.lfp;
    LFP1 = filtfilt(Hd1.sosMatrix,Hd.ScaleValues, LFP);
    LFP1 = filtfilt(Hd2.sosMatrix,Hd1.ScaleValues, LFP1);
    LFP1 =DenosieLFP(LFP1);
    
    LFP2 = filtfilt(Hd.sosMatrix,Hd1.ScaleValues, LFP1);
    
    times=linspace(0,time,length(LFP));
    
%     high=event_time(i_trial).high;
%     low=event_time(i_trial).low;
%     
    timepoint_low=[];
     for j_piece = 1 : numel(high)
                timetrain=low{j_piece};           
                timepoint_low=[ timepoint_low  timetrain];
     end
     
     event=[timepoint_low];
     
     tic;
     [s5,t5,E5] = sta(ts,LFP2,times,[],[],[],[-0.5 0.5],[]);
     toc;
     
     