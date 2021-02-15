% load data
addpath('./fig2')
close all

eeg_name = '.\data\EEG-EMG-EM\02.edf';
pupil_name = '.\data\EEG-EMG-EM\02fuse_data_prepro.mat';

[ali_eeg, ali_pupil, time_eeg, time_pupil, fs_eeg] = load_eeg_pupil(eeg_name, pupil_name);
time_pupilh = time_pupil/3600;
time_eegh = time_eeg/3600;

%%
i_ch = 1;
fs_pupil =400;
figure; set(gcf, 'Position', [300, 100, 700, 300])
ylabel('Pupil /mm')

subplot('Position', [.10 .83 .85 .13]);
plot(time_eegh, ali_pupil, 'Color', 'k')
set(gca, 'Color', 'none', 'TickDir', 'out', 'XColor', 'none', 'TickLength',[0.005, 0.005], 'Box', 'off', 'FontSize', 7)
xlim([0, 0.6]); 
ylim([0, 2]); ylabel('Pupil /mm')

subplot('Position', [.10 .66 .85 .13]);
plot(time_eegh, ali_eeg(i_ch, :)/1000, 'Color', 'k')
set(gca, 'Color', 'none', 'TickDir', 'out', 'XColor', 'none', 'TickLength',[0.005, 0.005], 'Box', 'off', 'FontSize', 7)
xlim([0, 0.8]); ylabel('EEG /mV')
ylim([-500, 500]/1000)

subplot('Position', [.10 .49 .85 .13]);
pspectrum(ali_eeg(i_ch, :), fs_eeg, 'spectrogram', 'TimeResolution', 0.5,  ...
    'OverlapPercent', 10, 'FrequencyLimits', [0 40], 'MinTHreshold',-30);
set(gca, 'Color', 'none', 'TickDir', 'out', 'XColor', 'none', 'TickLength',[0.005, 0.005], 'Box', 'off', 'FontSize', 7)
colorbar( 'off' ); 
title([]); ylabel('Freq /Hz');
xlim([0, 0.8]); 

subplot('Position', [.10 .32 .85 .13]);
plot(time_eegh, ali_eeg(3, :)/1000, 'Color', 'k')
set(gca, 'Color', 'none', 'TickDir', 'out', 'XColor', 'none', 'TickLength',[0.005, 0.005], 'Box', 'off', 'FontSize', 7)
xlim([0, 0.8]);
ylim([-200, 200]/1000);  ylabel('EMG /mV')

subplot('Position', [.10 .15 .85 .13]);
pspectrum(ali_eeg(3, :), fs_eeg, 'spectrogram', 'TimeResolution', 0.5,  ...
    'OverlapPercent', 10, 'FrequencyLimits', [0 40], 'MinTHreshold',-30);
set(gca, 'Color', 'none', 'TickDir', 'out', 'TickLength',[0.005, 0.005], 'Box', 'off', 'FontSize', 7)
colorbar( 'off' )
xlim([0, 0.8]);
title([]); ylabel('Freq /Hz');





