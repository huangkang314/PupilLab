function NAc = Home_Getadata_LFP(txtpath)
plxfilename = [xlspath(1:end - 3),'plx'];
% plxfilename_lfp_aligned = [plxfilename(1:end - 4),'-lfp-aligned.plx'];
% timepath = [txtpath(1:end-4),'_time.txt'];
% closeToopen = [xlspath(1:end-5),'-close-open.txt'];
% openToclose = [xlspath(1:end-5),'-open-close.txt'];
% closeToclose = [xlspath(1:end-5),'-close-close.txt'];
% information = importdata(timepath);
% EventNum = information(1,1);   % event标记序号
LFPchan = 2;    % LFP通道
% timedelay = information(1,1); 
% time_OM = information(2,1);% 第二行第一个是 video 的timedelay
% OCarm = information(2,2);      % 第二行第二个是 OpenArm 和 CloseArm 的指示
% chan = information(3:end,:);   % spike通道
% Transition.closeToopen = importdata(closeToopen);
% Transition.openToclose = importdata(openToclose);
% Transition.closeToclose = importdata(closeToclose);

%----------------read cell----------------%
% [~,~,~,~,Trodalness] = plx_information(plxfilename);
% if Trodalness == 1
%     % 如果是单根电极记录
%     [ts,wave1elec,waveTelec,chan_cell,firewave,LR_T,IsoD_T,Trodalness,info] = op_readcell_single(plxfilename,chan);
% elseif Trodalness == 2
%     % 如果是stereo电极记录
%     [ts,wave1elec,waveTelec,chan_cell,firewave,LR_T,IsoD_T,Trodalness,info] = op_readcell_stereo(plxfilename,chan);
% elseif Trodalness == 4
%     % 如果是tetrode电极记录
%     [ts,wave1elec,waveTelec,chan_cell,firewave,LR_T,IsoD_T,Trodalness,info] = op_readcell_tetrode(plxfilename,chan);
% end

%----------------read LFP-----------------%
[Fs,~,tsLFP,~,LFP] = plx_ad_v(plxfilename,LFPchan);  % algin 之后的文件
% %-----------------------------------------%
% [~,~,~,~,~,~,~,~,~,~,~,duration,~] = plx_information(plxfilename);
% event= ReadEvent(plxfilename,EventNum);
% % if Event == 0; error('!');end
% % event = Event(EventNum);
% duration = duration - event;
% LFP= importdata(txtpath);
% Fs=1600;
% ts=linspace(0,size(LFP,1)/Fs,size(LFP,1));
% win=[timedelay timedelay+300];
% lfp=LFP(find(ts>=win(1)&ts<win(2)),1:3);





%------------- 高架迷宫的行为学数据------------%
% xlspath=[txtpath(1:end-4),'.xlsx'];
% data = xlsread(xlspath);
% data(:,1)=data(:,1)-time_OM;
% data((find(data(:,1)<0)),:) = [];
% time_EPM = data(:,1);
% Position = [data(:,2),data(:,3)];
% Speed = data(:,4);
% Speed(isnan(Speed)) = 0;
% OpenArm.a = data(:,5);
% CloseArm.a = data(:,6);
% % MidCenter = data(:,7);
% OpenArm.b = data(:,7);
% CloseArm.b = data(:,8);
% Numcell = numel(ts);
%-----高架迷宫上openarm 和 closearm 上的时间------%
% xlsread_sta = xlsread([xlspath(1 : end - 5), '-statistical.xlsx']);
% behavior.openarm1.entries = xlsread_sta(1);
% behavior.openarm1.time = xlsread_sta(2);
% behavior.openarm1.distance = xlsread_sta(3);
% 
% behavior.closearm1.entries = xlsread_sta(5);
% behavior.closearm1.time = xlsread_sta(6);
% behavior.closearm1.distance = xlsread_sta(7);
% 
% behavior.center.entries = xlsread_sta(9);
% behavior.center.time = xlsread_sta(10);
% behavior.center.distance = xlsread_sta(11);
% 
% behavior.openarm2.entries = xlsread_sta(13);
% behavior.openarm2.time = xlsread_sta(14);
% behavior.openarm2.distance = xlsread_sta(15);
% 
% behavior.closearm2.entries = xlsread_sta(17);
% behavior.closearm2.time = xlsread_sta(18);
% behavior.closearm2.distance = xlsread_sta(19);
% ---------------- LFP 高架迷宫 -----------------%
% [thetapower,gammapower,recordingtime,LFP,Time1] = child_LFP(LFPalgin,tsLFP,event,Fs,time_EPM,timedelay);
% %----------------- LFP 穿梭 ---------------------%
% [LFPT,Tran] = child_LFP_EPM_Tran(LFPalgin,tsLFP,event,Fs,timedelay,Transition);

% Spike
% NAc = cell(1,Numcell);
for i_cell = 1
%     ts1 = ts{i_cell};tsout = ts1-event;tsout(tsout<0) = [];
%     recordingtime=max(tsout);
%     [FiringRate,delete_number] = child_FringRate(ts1,time_EPM,timedelay,event,recordingtime);   % 计算对应的放电频率
%     %------------------ 高架迷宫的位置信息--------------------%
%     Position1 = Position(delete_number+1:end,:);
%     CloseArm1.a = CloseArm.a(delete_number+1:end);
%     CloseArm1.b = CloseArm.b(delete_number+1:end);
%     OpenArm1.a = OpenArm.a(delete_number+1:end);
%     OpenArm1.b = OpenArm.b(delete_number+1:end);
%     MidCenter1 = MidCenter(delete_number+1:end);
%     Speed1 = Speed(delete_number+1:end);
%     
%     FiringRate = FiringRate(1 : numel(time_EPM));
    
%     Totalpos = size(Position1,1);
%     Firingmean = zeros(1,Totalpos);
%     for i = 1:Totalpos
%         Pos1 = Position1(i,:);
%         tf = ismember(Position1,Pos1,'rows');                % 所有经过这个点的非零放电率
%         FiringRate1position = FiringRate(tf);
%         FiringRate1position = FiringRate1position(~isnan(FiringRate1position));
%         if ~isempty(FiringRate1position)
%             Firingmean (i) = mean(FiringRate1position);
%         else
%             Firingmean(i) = NaN;
%         end
%     end
%     NAc{i_cell}.time_EPM= time_EPM;
%     NAc{i_cell}.Pos = Position;
%     NAc{i_cell}.Speed = Speed;
% %     NAc{i_cell}.FR = Firingmean;
% %     NAc{i_cell}.OC = OCarm;
%     NAc{i_cell}.CloseArm.a = CloseArm.a;
%     NAc{i_cell}.CloseArm.b = CloseArm.b;
%     NAc{i_cell}.OpenArm.a = OpenArm.a;
%     NAc{i_cell}.OpenArm.b = OpenArm.b;
%     NAc{i_cell}.MArm = MidCenter1;
%     NAc{i_cell}.ts = tsout;
%     NAc{i_cell}.duration = duration;
%     NAc{i_cell}.waveform = wave1elec(i_cell, :);
%     NAc{i_cell}.waveformT = waveTelec(i_cell, :);
%     NAc{i_cell}.thetapower = thetapower;
%     NAc{i_cell}.gammapower = gammapower;
%     NAc{i_cell}.chancell = chan_cell(i_cell, :);
%     NAc{i_cell}.firingwave = firewave{i_cell};
%     NAc{i_cell}.LR = LR_T(i_cell);
%     NAc{i_cell}.IsoD = IsoD_T(i_cell);
%     NAc{i_cell}.Trodalness = Trodalness;
%     NAc{i_cell}.info = info;
    NAc{i_cell}.lfp =LFP;
%     NAc{i_cell}.lfpT = LFPT;
%     NAc{i_cell}.Tran = Tran;
%     NAc{i_cell}.time =  tsLFP;
%     NAc{i_cell}.event =  event;
%     NAc{i_cell}.behav = behavior;
end
save([txtpath(1:end - 3),'mat'],'NAc')
end


% function [Posvalue,delete_number] = child_FringRate(ts,time,timedelay,event,recordingtime)
% ts = ts-event;ts(ts < 0) = [];
% time = time - timedelay;
% delete_number = sum(time < 0); time(time < 0) = [];
% 
% timeinterval = 3;  % 3s 的timeinterval
% Num = numel(time);
% Posvalue = zeros(1,Num)';
% for i = 1:Num
%     timeOne = time(i);
%     if timeOne <= recordingtime
%         Numspk = sum(ts <= (timeOne + timeinterval/2) & ts >= (timeOne - timeinterval/2));
%         Rate = Numspk/timeinterval;
%         Posvalue(i) = Rate;
%     else
%         Posvalue(i) = NaN;
%     end
% end
% end
% 
% function [thetapower,gammapower,recordingtime,LFP,time] = child_LFP(LFPalgin,tsLFP,event,Fs,time,timedelay)
% time(time < timedelay) = [];
% time = time - timedelay;       % 视频没有截取，要先减去timedelay
% 
% addpoint = zeros(round(tsLFP * Fs),1);
% if ~isempty(addpoint)
%     LFPalgin = cat(1,addpoint,LFPalgin);
% end
% LFPalgin = LFPalgin(fix(Fs * event) + 1 : end);
% LFP = LFPalgin;
% 
% % timeend = find(time < 600,1,'last');
% % time = time(1 : timeend);
% 
% Num = numel(time);
% recordingtime = numel(LFP)/Fs;
% 
% bin = 2.6; % 取2.5秒的bin，计算大小，在这位置前1.25秒，后1.25秒
% theta = [4,12];
% gamma = [30,100];
% Fs = 1000;
% window = 1; % 设置窗长度为 2 s
% band = 2.5;
% TW = window*band; % 窗长度为 2 s，半频带宽度为 4；TW = 2*4 = 8；
% K = 2*TW - 1; % K = 2*TW -1 = 15
% tapers = [TW,K];
% params.tapers = tapers;
% params.err = 0;
% params.Fs = Fs;
% params.fpass = [1 100] ; % show results between 0 and 100 Hz
% 
% thetapower = zeros(Num,1);
% gammapower = zeros(Num,1);
% for i = 1:Num
%     %     disp(i)
%     timeOne = time(i);
%     if timeOne < recordingtime
%         LFPbegin = round(timeOne*Fs+1);
%         piecelong = bin * Fs;
%         % 截取每个位置前半段，前1.25s, 如果前面有1.25ｓ的数据就截取，否则从第一个点开始
%         if LFPbegin > piecelong/2
%             LFPpiecepre = LFP(LFPbegin - piecelong/2 : LFPbegin);
%         else
%             LFPpiecepre = LFP(1 : LFPbegin);
%         end
%         % 截取每个位置后半段，后1.25s, 如果后面有1.25ｓ的数据就截取，否则到最后一个点
%         if length(LFP) > LFPbegin+piecelong/2
%             LFPpiecepost = LFP(LFPbegin:LFPbegin+piecelong/2);
%         else
%             LFPpiecepost = LFP(LFPbegin:end);
%         end
%         LFPpiece = cat(1,LFPpiecepre,LFPpiecepost);
%         LFPpiece = LFPpiece - mean(LFPpiece);
%         LFPpiece = LFPpiece/std(LFPpiece);
%         [pp,f] = mtspectrumc_he(LFPpiece,params);
%         
%         fthetabegin = find(f < theta(1),1,'last');
%         fthetaend = find(f <= theta(2),1,'last');
%         
%         fgammabegin = find(f < gamma(1),1,'last');
%         fgammaend = find(f <= gamma(2),1,'last');
%         
%         thetapower(i) = mean(pp(fthetabegin : fthetaend));
%         gammapower(i) = mean(pp(fgammabegin : fgammaend));
%     else
%         thetapower(i) = NaN;
%         gammapower(i) = NaN;
%     end
% end
% end
% 
% function  [LFPT,Tran] = child_LFP_EPM_Tran(LFPalgin,tsLFP,event,Fs,timedelay,Transition)
% 
% addpoint = zeros(round(tsLFP * Fs),1);
% if ~isempty(addpoint)
%     LFPalgin = cat(1,addpoint,LFPalgin);
% end
% LFPalgin = LFPalgin(fix(Fs * event) + 1 : end);
% LFP = LFPalgin;
% recordingtime = numel(LFP)/Fs;
% 
% % 截取小鼠从 closeArm 到 closeArm 的 LFP
% piecelong = 12; % 10s 中的piece长度,从close到open，或者从open到close
% if ~isempty(Transition.closeToopen)
%     [LFPcloseToopen,closeToopen] = child_Transition(Transition.closeToopen,timedelay,recordingtime,LFP,piecelong,Fs);
% else
%     LFPcloseToopen = NaN(1,piecelong*Fs);closeToopen = [];
% end
% 
% if ~isempty(Transition.openToclose)
%     [LFPopenToclose,openToclose] = child_Transition(Transition.openToclose,timedelay,recordingtime,LFP,piecelong,Fs);
% else
%     LFPopenToclose = NaN(1,piecelong*Fs);openToclose = [];
% end
% 
% if ~isempty(Transition.closeToclose)
%     [LFPcloseToclose,closeToclose] = child_Transition(Transition.closeToclose,timedelay,recordingtime,LFP,piecelong,Fs);
% else
%     LFPcloseToclose = NaN(1,piecelong*Fs);closeToclose = [];
% end
% 
% timeTran = sort([closeToopen;openToclose]);
% [LFPcontrol, timeRandom] = child_Transition2(timeTran,recordingtime,LFP,piecelong,Fs); %产生一些随机的时间点做对照
% 
% 
% LFPT.closeToopen = LFPcloseToopen;
% LFPT.openToclose = LFPopenToclose;
% LFPT.closeToclose = LFPcloseToclose;
% LFPT.random = LFPcontrol;
% 
% Tran.closeToopen = closeToopen;
% Tran.openToclose = openToclose;
% Tran.closeToclose = closeToclose;
% Tran.random = timeRandom;
% end
% 
% 
% % function [LFPout,timeS] = child_Transition(time,timedelay,recordingtime,LFP,piecelong,Fs)
% % timeS = time(:,1) * 60 + time(:,2);
% % timeS = timeS - timedelay;
% % timeS(timeS < 0) = [];
% % timeS(timeS > recordingtime) = [];
% % % timeS(timeS > 600) = [];
% % 
% % if ~isempty(timeS)
% %     LFPout = zeros(numel(timeS),piecelong * Fs);
% %     for i = 1:numel(timeS)
% %         beginpoint = fix(timeS(i) * Fs);
% %         LFPout(i,:) = LFP(beginpoint + 1 : beginpoint + piecelong * Fs);
% %     end
% % else
% %     LFPout = zeros(1,piecelong * Fs);
% % end
% % end
% 
% function [LFPout,timeS] = child_Transition(time,timedelay,recordingtime,LFP,piecelong,Fs)
% timeS = time(:,1) * 60 + time(:,2);
% timeS = timeS - timedelay;
% timeS(timeS - piecelong/2 < 0) = [];
% timeS(timeS + piecelong/2 > recordingtime) = [];
% LFPout = zeros(numel(timeS),piecelong * Fs);
% 
% for i = 1:numel(timeS)
%     beginpoint = fix((timeS(i) - piecelong/2) * Fs);
%     LFPout(i,:) = LFP(beginpoint + 1 : beginpoint + piecelong * Fs);
% end
% end
% 
% function [LFPout,timeOut] = child_Transition2(time,recordingtime,LFP,piecelong,Fs)
% cc = 0;
% Numpiece = size(time,1);
% timepiece = zeros(Numpiece,piecelong);
% timeS = timepiece;
% for i_piece = 1:Numpiece
%     timepiece(i_piece,:) = time(i_piece)+1 : time(i_piece) +  piecelong;
% end
% 
% % 随机产生一些lfp piece，这些lfp和穿梭的不重合
% while cc < Numpiece
%     timerandom = randi([1,floor(recordingtime)  - piecelong - 1],1);
%     if sum(ismember(timerandom + 1 : timerandom + piecelong,timepiece(:))) == 0 && ...
%             (timerandom + piecelong) < recordingtime ...
%            % && sum(ismember(timerandom +1  : timerandom + piecelong,timeS(:))) == 0
%         cc = cc + 1;
%         timeS(cc,:) = timerandom + 1 : timerandom + piecelong;
%     end  
%     disp(cc)
% end
% 
% LFPout = zeros(Numpiece,piecelong * Fs);
% for i = 1 : Numpiece
%     beginpoint = timeS(i,1) * Fs;
%     LFPout(i,:) = LFP(beginpoint + 1 : beginpoint + piecelong * Fs);
% end
% timeOut = timeS(:,1);
% 
% end
