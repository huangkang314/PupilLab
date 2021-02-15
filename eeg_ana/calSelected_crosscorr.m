function [lags, crosscorr_lag, max_crosscorr_lag, p_value]  = ...
    calSelected_crosscorr(LFP, sel_chls, event_pos, fs)

chlA_idx = contains({LFP.name}, num2str(sel_chls(1)));
chlB_idx = contains({LFP.name}, num2str(sel_chls(2)));
pos = (event_pos(1)-3)*fs : (event_pos(2)+3)*fs-1;

LFP_A = LFP(chlA_idx).data;
LFP_B = LFP(chlB_idx).data;

LFP_A = LFP_A(pos);
LFP_B = LFP_B(pos);

% filtering
LFPA_filtered = filterLFP(fs, LFP_A);
LFPB_filtered = filterLFP(fs, LFP_B);


bin = event_pos(2) - event_pos(1); % every 10 sencods
flag = 1;

[lags, crosscorr_lag, max_crosscorr_lag, p_value]  = cal_crosscorr(LFPA_filtered, LFPB_filtered, fs, bin, flag);
