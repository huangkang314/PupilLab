function NAc = Home_Getadata_LFP(txtpath)
plxfilename = [xlspath(1:end - 3),'plx'];
% plxfilename_lfp_aligned = [plxfilename(1:end - 4),'-lfp-aligned.plx'];
% timepath = [txtpath(1:end-4),'_time.txt'];
% closeToopen = [xlspath(1:end-5),'-close-open.txt'];
% openToclose = [xlspath(1:end-5),'-open-close.txt'];
% closeToclose = [xlspath(1:end-5),'-close-close.txt'];
% information = importdata(timepath);
% EventNum = information(1,1);   % event������
LFPchan = 2;    % LFPͨ��
% timedelay = information(1,1); 
% time_OM = information(2,1);% �ڶ��е�һ���� video ��timedelay
% OCarm = information(2,2);      % �ڶ��еڶ����� OpenArm �� CloseArm ��ָʾ
% chan = information(3:end,:);   % spikeͨ��
% Transition.closeToopen = importdata(closeToopen);
% Transition.openToclose = importdata(openToclose);
% Transition.closeToclose = importdata(closeToclose);

%----------------read cell----------------%
% [~,~,~,~,Trodalness] = plx_information(plxfilename);
% if Trodalness == 1
%     % ����ǵ����缫��¼
%     [ts,wave1elec,waveTelec,chan_cell,firewave,LR_T,IsoD_T,Trodalness,info] = op_readcell_single(plxfilename,chan);
% elseif Trodalness == 2
%     % �����stereo�缫��¼
%     [ts,wave1elec,waveTelec,chan_cell,firewave,LR_T,IsoD_T,Trodalness,info] = op_readcell_stereo(plxfilename,chan);
% elseif Trodalness == 4
%     % �����tetrode�缫��¼
%     [ts,wave1elec,waveTelec,chan_cell,firewave,LR_T,IsoD_T,Trodalness,info] = op_readcell_tetrode(plxfilename,chan);
% end

%----------------read LFP-----------------%
[Fs,~,tsLFP,~,LFP] = plx_ad_v(plxfilename,LFPchan);  % algin ֮����ļ�
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





%------------- �߼��Թ�����Ϊѧ����------------%
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
%-----�߼��Թ���openarm �� closearm �ϵ�ʱ��------%
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
% ---------------- LFP �߼��Թ� -----------------%
% [thetapower,gammapower,recordingtime,LFP,Time1] = child_LFP(LFPalgin,tsLFP,event,Fs,time_EPM,timedelay);
% %----------------- LFP ���� ---------------------%
% [LFPT,Tran] = child_LFP_EPM_Tran(LFPalgin,tsLFP,event,Fs,timedelay,Transition);

% Spike
% NAc = cell(1,Numcell);
for i_cell = 1
%     ts1 = ts{i_cell};tsout = ts1-event;tsout(tsout<0) = [];
%     recordingtime=max(tsout);
%     [FiringRate,delete_number] = child_FringRate(ts1,time_EPM,timedelay,event,recordingtime);   % �����Ӧ�ķŵ�Ƶ��
%     %------------------ �߼��Թ���λ����Ϣ--------------------%
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
%         tf = ismember(Position1,Pos1,'rows');                % ���о��������ķ���ŵ���
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
% timeinterval = 3;  % 3s ��timeinterval
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
% time = time - timedelay;       % ��Ƶû�н�ȡ��Ҫ�ȼ�ȥtimedelay
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
% bin = 2.6; % ȡ2.5���bin�������С������λ��ǰ1.25�룬��1.25��
% theta = [4,12];
% gamma = [30,100];
% Fs = 1000;
% window = 1; % ���ô�����Ϊ 2 s
% band = 2.5;
% TW = window*band; % ������Ϊ 2 s����Ƶ�����Ϊ 4��TW = 2*4 = 8��
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
%         % ��ȡÿ��λ��ǰ��Σ�ǰ1.25s, ���ǰ����1.25������ݾͽ�ȡ������ӵ�һ���㿪ʼ
%         if LFPbegin > piecelong/2
%             LFPpiecepre = LFP(LFPbegin - piecelong/2 : LFPbegin);
%         else
%             LFPpiecepre = LFP(1 : LFPbegin);
%         end
%         % ��ȡÿ��λ�ú��Σ���1.25s, ���������1.25������ݾͽ�ȡ���������һ����
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
% % ��ȡС��� closeArm �� closeArm �� LFP
% piecelong = 12; % 10s �е�piece����,��close��open�����ߴ�open��close
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
% [LFPcontrol, timeRandom] = child_Transition2(timeTran,recordingtime,LFP,piecelong,Fs); %����һЩ�����ʱ���������
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
% % �������һЩlfp piece����Щlfp�ʹ���Ĳ��غ�
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
