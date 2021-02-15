function [sP, T] = eeg_power(eeg_filtered, time_res, fs_eeg, i_ch)


% subplot(612)
[P.detla, F.detla, T.detla] = pspectrum(eeg_filtered.detla(i_ch, :), fs_eeg, 'spectrogram', 'TimeResolution', time_res,  ...
    'OverlapPercent', 10, 'FrequencyLimits', [0 40], 'MinTHreshold',-30);

% subplot(613)
[P.theta, F.theta, T.theta] = pspectrum(eeg_filtered.theta(i_ch, :), fs_eeg, 'spectrogram', 'TimeResolution', time_res,  ...
    'OverlapPercent', 10, 'FrequencyLimits', [0 40], 'MinTHreshold',-30);

% subplot(614)
[P.alpha, F.alpha, T.alpha] = pspectrum(eeg_filtered.alpha(i_ch, :), fs_eeg, 'spectrogram', 'TimeResolution', time_res,  ...
    'OverlapPercent', 10, 'FrequencyLimits', [0 40], 'MinTHreshold',-30);

% subplot(615)
[P.beta, F.beta, T.beta] =  pspectrum(eeg_filtered.beta(i_ch, :), fs_eeg, 'spectrogram', 'TimeResolution', time_res,  ...
    'OverlapPercent', 10, 'FrequencyLimits', [0 40], 'MinTHreshold',-30);

% subplot(616)
[P.gamma, F.gamma, T.gamma] = pspectrum(eeg_filtered.gamma(i_ch, :), fs_eeg, 'spectrogram', 'TimeResolution', time_res,  ...
    'OverlapPercent', 10, 'FrequencyLimits', [0 40], 'MinTHreshold',-30);

sP.detla = sum(P.detla);
sP.theta = sum(P.theta);
sP.alpha = sum(P.alpha);
sP.beta = sum(P.beta);
sP.gamma = sum(P.gamma);