function   [lags, crosscorr_lag, max_crosscorr_lag, p_value]  = ...
    cal_crosscorr(LFP_A, LFP_B, Fs, bin, flag)

time = [0 numel(LFP_A.detla)/Fs];
% detla
[lags, crosscorr_lag_detla, max_crosscorr_lag_detla, p_value_detla] = ...
    op_amp_crosscorr(LFP_A.detla,LFP_B.detla,Fs,time,bin,flag);

% theta
[~, crosscorr_lag_theta, max_crosscorr_lag_theta, p_value_theta] = ...
    op_amp_crosscorr(LFP_A.theta,LFP_B.theta,Fs,time,bin,flag);

% alpha
[~, crosscorr_lag_alpha, max_crosscorr_lag_alpha, p_value_alpha] = ....
    op_amp_crosscorr(LFP_A.alpha,LFP_B.alpha,Fs,time,bin,flag);

% beta
[~, crosscorr_lag_beta, max_crosscorr_lag_beta, p_value_beta] = ...
    op_amp_crosscorr(LFP_A.beta,LFP_B.beta,Fs,time,bin,flag);

% gamma
[~, crosscorr_lag_gamma, max_crosscorr_lag_gamma, p_value_gamma] = ...
    op_amp_crosscorr(LFP_A.gamma,LFP_B.gamma,Fs,time,bin,flag);

crosscorr_lag.detla = crosscorr_lag_detla;
crosscorr_lag.theta = crosscorr_lag_theta;
crosscorr_lag.alpha = crosscorr_lag_alpha;
crosscorr_lag.beta = crosscorr_lag_beta;
crosscorr_lag.gamma = crosscorr_lag_gamma;

max_crosscorr_lag.detla = max_crosscorr_lag_detla;
max_crosscorr_lag.theta = max_crosscorr_lag_theta;
max_crosscorr_lag.alpha = max_crosscorr_lag_alpha;
max_crosscorr_lag.beta = max_crosscorr_lag_beta;
max_crosscorr_lag.gamma = max_crosscorr_lag_gamma;

p_value.detla =  p_value_detla;
p_value.theta = p_value_theta;
p_value.alpha = p_value_alpha;
p_value.beta = p_value_beta;
p_value.gamma = p_value_gamma;

end