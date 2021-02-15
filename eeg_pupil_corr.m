% load data
addpath('./fig2')
addpath('./eeg_ana')
% close all

eeg_name = 'D:\huangkang\Projects\pupilLab\code\PupilLab\data\EEG-pupil\EEG-EMG-EM\02.edf';
pupil_name = 'D:\huangkang\Projects\pupilLab\code\PupilLab\data\EEG-pupil\EEG-EMG-EM\02fuse_data_prepro.mat';

[ali_eeg, ali_pupil, time_eeg, time_pupil, fs_eeg] = load_eeg_pupil(eeg_name, pupil_name);
fs_pupil = 400;

% time_pupilh = time_pupil/3600;
% time_eegh = time_eeg/3600;

%% eeg_filtering
i_ch = 1;

eeg_filtered = filter_eeg(fs_eeg, ali_eeg);

%%
time_res = 5;

% [sP, T] = eeg_power(eeg_filtered, time_res, fs_eeg, i_ch);
sP = eeg_power2(eeg_filtered, i_ch);


% power_time = T.alpha;
bin_size = 5; %s
power_time = time_eeg(1:bin_size*fs_eeg:end);
power_bins = power_time';

bined_pupil = bin_pupil(ali_pupil, power_bins, time_eeg);
sP = bin_eeg(sP, power_bins, time_eeg);

%%
plot_pupil_eegPower(bined_pupil, power_time(2:end), sP)

%%
figure; set(gcf, 'Position', [300, 100, 140, 700])


power_timeh = power_time/3600;
range = [0, 0.8]; %h
range_idx  = power_timeh>=range(1) & power_timeh<range(2);

subplot(511)
regA = norm_01(sP.detla(range_idx)); regB = norm_01(bined_pupil(range_idx)');
[r, m, b] = plot_eeg_pupil_scatter(regA', regB);
title('Delta')

subplot(512)
regA = norm_01(sP.theta(range_idx)); regB = norm_01(bined_pupil(range_idx)');
[r, m, b] = plot_eeg_pupil_scatter(regA', regB);
title('Theta')

subplot(513)
regA = norm_01(sP.alpha(range_idx)); regB = norm_01(bined_pupil(range_idx)');
[r, m, b] = plot_eeg_pupil_scatter(regA', regB);
title('Alpha')
ylabel('Norm. pupil')

subplot(514)
regA = norm_01(sP.beta(range_idx)); regB = norm_01(bined_pupil(range_idx)');
[r, m, b] = plot_eeg_pupil_scatter(regA', regB);
title('Beta')


subplot(515)
regA = norm_01(sP.gamma(range_idx)); regB = norm_01(bined_pupil(range_idx)');
[r, m, b] = plot_eeg_pupil_scatter(regA', regB);
xlabel('Norm. eeg power')
title('Gamma')


%%
figure
plot(norm_01(ali_pupil'))

hold on
plot(norm_01(eeg_filtered.alpha(:, 1)))










