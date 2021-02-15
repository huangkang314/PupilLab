function sP = eeg_power2(eeg_filtered, i_ch)


sP.detla = abs(sqrt(eeg_filtered.detla(i_ch, :)));
sP.theta = abs(sqrt(eeg_filtered.theta(i_ch, :)));
sP.alpha = abs(sqrt(eeg_filtered.alpha(i_ch, :)));
sP.beta = abs(sqrt(eeg_filtered.beta(i_ch, :)));
sP.gamma = abs(sqrt(eeg_filtered.gamma(i_ch, :)));