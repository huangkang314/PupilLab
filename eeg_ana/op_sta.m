function[s,t,E] = op_sta(data_spk,data_lfp,smp,T,D,err)
% 原始为chronex工具包中函数，有改动

% Spike Triggered Average
%     Usage: [s,t,E] = sta(data_spk,data_lfp,smp,plt,w,T,D,err)
%
% Inputs
%
% Note that all times have to be consistent. If data_spk
% is in seconds, so must be sig and t. If data_spk is in
% samples, so must sig and t. The default is seconds.
%
% data_spk    - strucuture array of spike times data
%               or NaN padded matrix
% data_lfp    - array of lfp data(samples x trials)
%
% Optional...
% plt 'n'|'r' etc
% width kernel smoothing in s
% T = [-0.1 0.1] - extract this range about each spk
% D = plot spike triggered average out to [D1 D2]
% err = calcluate error bars (bootstrap)
%
% Outputs:
%
% s  spike triggered average
% t  times
% E  bootstrap standard err

if nargin < 3;error('Require spike, lfp and lfp times');end
sz = size(data_spk);
if sz(1) > sz(2); data_spk=data_spk'; end;
sz = size(data_lfp);
if sz(1) > sz(2); data_lfp = data_lfp'; end;
t = smp;

mlfp = 0;
slfp = 0;
Nspk = 0;
smp = t(2)-t(1);
t1 = [D(1):smp:(-smp+eps) 0:smp:D(2)+eps];

indx = find(t>T(1)&t<T(2));
lfp = data_lfp(indx);
spk = data_spk(data_spk > T(1) & data_spk < T(2) & data_spk ~= 0);
tt = t(indx);
if ~isempty(spk) > 0
    ND = length(spk);
    for s = 1:ND
        spktime = spk(s);
        t0 = tt-spktime + eps;
        if min(t0) < (D(1)-smp) && max(t0) > (D(2)+smp);
            indx = find(t0<D(1));
            indx = indx(length(indx));
            offset = (t0(indx)-D(1))/smp;
            indx = indx:(indx+length(t1)-1);
            lfp_t1 = lfp(indx) + (lfp(indx+1)-lfp(indx))*offset;
            Nspk = Nspk + 1;
            mlfp = mlfp + lfp_t1;
            slfp = slfp + lfp_t1.^2;
            Err(Nspk,:) = lfp_t1;
        end
    end
end

if Nspk == 0
    disp('No spikes in interval')
    t = t1;
    s = zeros(length(t),1);
    E = zeros(length(t),1);
    return
end

mlfp = mlfp/Nspk;
slfp = slfp/Nspk;
stdlfp = sqrt((slfp - mlfp.^2)/Nspk);

% bootstrap errorbars...
if err == 1;
    Nboot = 20;
    blfp = 0;
    slfp = 0;
    for n = 1:Nboot
        indx = floor(Nspk*rand(1,Nspk)) + 1;
        lfptmp = mean(Err(indx,:));
        blfp = blfp + lfptmp;
        slfp = slfp + lfptmp.^2;
    end
    stdlfp = sqrt((slfp/Nboot - blfp.^2/Nboot^2));
end

s = mlfp-mean(mlfp);
E = stdlfp;
t = t1;


