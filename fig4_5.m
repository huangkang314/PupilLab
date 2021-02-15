addpath('./preprocess')
clear
% close all

%% load data
work_path = '.\data\';
data_path = dir([work_path, 'e*']);

used_demoData = 7;
fs =30;
data_main = data_path(used_demoData).name(2:end);
data = load([work_path, data_main, '_preprocessed.mat']);

pick_index = load('.\genGroundTruth\pick_indexs_allBad_1025.mat');
pick_indexs = pick_index.pick_indexs;
video_name = pick_indexs(used_demoData).videoPath;
obj = VideoReader(video_name);

pupil_seg = data.pupil.seg;
pupil_dlc = data.pupil.dlc;
err_seg = data.pupil.err_seg;
err_dlc = data.pupil.err_dlc;
pupil_fuse = data.pupil.fuse;
data_len = length(pupil_seg);
time = data.pupil.time;

err_segnorm = mag2db(err_seg/data_len);
err_dlcnorm =mag2db(err_dlc/data_len);

segZero_index = find(pupil_seg == 0);
%%
figure; set(gcf, 'Position', [300, 100, 1100, 700])

% plot seg noise
ax{1} = subplot('Position', [.08 .89 .9 .07]);
plot(time, err_segnorm, '.r');  h = get(gca, 'Children'); set(h(1), 'Color', [150, 54, 39]/255);
grid on; ylim([-120, 20]); xlim([time(1), time(end)])
set(gca, 'Color', 'none', 'FontSize', 6, 'TickDir', 'out', 'TickLength',[0.002, 0.002], ...
    'xtick',[], 'Box', 'off', 'LineWidth', 0.5, 'XColor', 'none')
ylabel('Noise/dB', 'FontSize', 8);
ax{1}.GridColor = [.9 .9 .9];

% plot seg raw
ax{2} = subplot('Position', [.08 .78 .9 .11]);
plot(time, pupil_seg, 'Color', [150, 54, 39]/255, 'LineWidth', 0.5)
hold on
plot(segZero_index/fs, 3*ones(length(segZero_index), 1), 'vk',...
    'MarkerFaceColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 5)
grid on; xlim([time(1), time(end)]); ylim([0, 5]);
set(gca, 'Color', 'none', 'FontSize', 6, 'TickDir', 'out', 'TickLength',[0.002, 0.002], ...
    'xtick',[], 'Box', 'off', 'LineWidth', 0.5)
ylabel('Pupil rad./mm', 'FontSize', 8);
ax{2}.GridColor = [.9 .9 .9];


ax{3} = subplot('Position', [.08 .67 .9 .07]);
plot(time, err_segnorm, '.b');  h = get(gca, 'Children'); set(h(1), 'Color', [52, 72, 152]/255);
grid on; ylim([-120, 20]); xlim([time(1), time(end)])
set(gca, 'Color', 'none', 'FontSize', 6, 'TickDir', 'out', 'TickLength',[0.002, 0.002], ...
    'xtick',[], 'Box', 'off', 'LineWidth', 0.5, 'XColor', 'none')
ylabel('Noise/dB', 'FontSize', 8);
ax{3}.GridColor = [.9 .9 .9];


ax{4} = subplot('Position', [.08 .56 .9 .11]);
plot(time, pupil_dlc, 'Color', [52, 72, 152]/255, 'LineWidth', 0.5)
grid on; xlim([time(1), time(end)]); ylim([0, 5]);
set(gca, 'Color', 'none', 'FontSize', 6, 'TickDir', 'out', 'TickLength',[0.002, 0.002], ...
    'xtick',[], 'Box', 'off', 'LineWidth', 0.5)
ylabel('Pupil rad./mm', 'FontSize', 8);
ax{4}.GridColor = [.9 .9 .9];


ax{5} = subplot('Position', [.08 .32 .9 .20]);
hold on
plot(time, pupil_seg, 'Color', [150, 54, 39]/255, 'LineWidth', 0.5)
plot(time, pupil_dlc, 'Color', [52, 72, 152]/255, 'LineWidth', 0.5)
plot(time, pupil_fuse, 'Color', [80, 138, 66]/255, 'LineWidth', 1)
grid on; xlim([time(1), time(end)]); ylim([0, 5]);
set(gca, 'Color', 'none', 'FontSize', 6, 'TickDir', 'out', 'TickLength',[0.002, 0.002], ...
    'Box', 'off', 'LineWidth', 0.5)
ylabel('Pupil rad./mm', 'FontSize', 8);
ax{5}.GridColor = [.9 .9 .9];


ax{6} = subplot('Position', [.08 .06 .27 .2]);
hold on
plot(time, pupil_seg, 'Color', [150, 54, 39]/255, 'LineWidth', 0.5)
plot(time, pupil_dlc,  'Color', [52, 72, 152]/255, 'LineWidth', 0.5)
plot(time, pupil_fuse, 'Color', [80, 138, 66]/255, 'LineWidth', 1)
grid on; xlim([10, 40]); ylim([0, 5]);
set(gca, 'Color', 'none', 'FontSize', 6, 'TickDir', 'out', 'TickLength',[0 0], ...
    'Box', 'on', 'LineWidth', 0.5)
ylabel('Pupil rad./mm', 'FontSize', 8);
ax{6}.GridColor = [.9 .9 .9];


ax{7} = subplot('Position', [.395 .06 .27 .2]);
hold on
plot(time, pupil_seg, 'Color', [150, 54, 39]/255, 'LineWidth', 0.5)
plot(time, pupil_dlc,  'Color', [52, 72, 152]/255, 'LineWidth', 0.5)
plot(time, pupil_fuse, 'Color', [80, 138, 66]/255, 'LineWidth', 1)
grid on; xlim([130, 160]); ylim([0, 5]);
set(gca, 'Color', 'none', 'FontSize', 6, 'TickDir', 'out', 'TickLength',[0 0], ...
    'Box', 'on', 'LineWidth', 0.5, 'YTickLabel', [])
xlabel('Time/s', 'FontSize', 8);
ax{7}.GridColor = [.9 .9 .9];

ax{8} = subplot('Position', [.71 .06 .27 .2]);
hold on
plot(time, pupil_seg, 'Color', [150, 54, 39]/255, 'LineWidth', 0.5)
plot(time, pupil_dlc,  'Color', [52, 72, 152]/255, 'LineWidth', 0.5)
plot(time, pupil_fuse, 'Color', [80, 138, 66]/255, 'LineWidth', 1)
grid on; xlim([340, 370]); ylim([0, 5]);
set(gca, 'Color', 'none', 'FontSize', 6, 'TickDir', 'out', 'TickLength',[0 0], ...
    'Box', 'on', 'LineWidth', 0.5, 'YTickLabel', [])
ax{8}.GridColor = [.9 .9 .9];























