% load data
addpath('./figure')
addpath('./genGroundTruth')

prepro_dataPath = '.\data\';
data_path = dir([prepro_dataPath, 'e*']);
n_data = length(data_path);
colors = [ [150, 54, 39]/255;  [80, 138, 66]/255; [52, 72, 152]/255];
colorsBox = [[150, 54, 39]/255; [52, 72, 152]/255];
colorsBoxFill = [ [52, 72, 152]/255; [150, 54, 39]/255];

box_data_cell = {};
%%
figure; set(gcf, 'Position', [300, 100, 1000, 500])

%
ax{1} = subplot('Position', [.05 .10 .16 .45]);
label_resultRandom = [prepro_dataPath, 'label_result_random_1025.mat'];
[err_seg, err_dlc, err_fuse, noise_segnorm, nois_dlcnorm]  = calerr(prepro_dataPath, label_resultRandom);
n_sample = length(err_fuse);
group_id = [ones(n_sample, 1); 2*ones(n_sample, 1); 3*ones(n_sample, 1)];
colorsScatter = [repmat(colors(1, :), n_sample, 1); repmat(colors(2, :), n_sample, 1); repmat(colors(3, :), n_sample, 1)];

all_err_random = [abs(err_seg), abs(err_fuse), abs(err_dlc)]';
box_data_cell{1} = [abs(err_seg); abs(err_fuse); abs(err_dlc)]'; 
scatter(group_id + (rand(size(all_err_random))-0.5)/2, all_err_random, 10*ones(length(group_id), 1), colorsScatter, 'filled')
hold on
h = boxplot(all_err_random, group_id, 'Colors', colors, 'BoxStyle', 'outline', 'Widths', 0.6, 'OutlierSize', 0.0001);
set(h,{'linew'}, {1})
ylim([-0.5, 6.2])
ylabel('Error/mm'); xlim([0.5 3+0.5]); 
set(gca, 'Color', 'none', 'TickDir', 'out', 'XTickLabel', {'Seg', 'Fused', 'DLC'}, 'TickLength',[0.01, 0.01], 'Box', 'off', 'FontSize', 7)

noise_sample = length(noise_segnorm);
ax{6} = subplot('Position', [.05 .65 .16 .30]);
group_id = [ones(noise_sample, 1); 2*ones(noise_sample, 1)];
colorsScatter = [repmat(colors(1, :), noise_sample, 1); repmat(colors(2, :), noise_sample, 1)];

all_noise_random = [noise_segnorm, nois_dlcnorm]';
% scatter(group_id + (rand(size(all_noise_random))-0.5)/5, all_noise_random, 20*ones(length(group_id), 1), colorsScatter, 'filled')
% hold on
h = boxplot(all_noise_random, group_id, 'Colors', colorsBox, 'BoxStyle', 'outline', 'Widths', 0.5, 'OutlierSize', 0.0001);
hi = findobj(gca,'Tag','Box');
for j=1:length(hi)
    patch(get(hi(j), 'XData'), get(hi(j),'YData'), colorsBoxFill(j,:), 'FaceAlpha',.8);
end
set(h,{'linew'}, {1})
ylim([-60, 400])
ylabel('Noise/dB'); xlim([0.5 2+0.5]); 
set(gca, 'Color', 'none', 'TickDir', 'out', 'XTickLabel', {'Seg', 'DLC'}, 'TickLength',[0.01, 0.01], 'Box', 'off', 'FontSize', 7)


%
ax{2} = subplot('Position', [.24 .10 .16 .45]);
label_resultRandom = [prepro_dataPath, 'label_result_allGood_1025.mat'];
[err_seg, err_dlc, err_fuse, noise_segnorm, nois_dlcnorm]  = calerr(prepro_dataPath, label_resultRandom);
n_sample = length(err_fuse);
group_id = [ones(n_sample, 1); 2*ones(n_sample, 1); 3*ones(n_sample, 1)];
colorsScatter = [repmat(colors(1, :), n_sample, 1); repmat(colors(2, :), n_sample, 1); repmat(colors(3, :), n_sample, 1)];

all_err_random = [abs(err_seg), abs(err_fuse), abs(err_dlc)]';
box_data_cell{2} = [abs(err_seg); abs(err_fuse); abs(err_dlc)]'; 
scatter(group_id + (rand(size(all_err_random))-0.5)/2, all_err_random, 10*ones(length(group_id), 1), colorsScatter, 'filled')
hold on
h = boxplot(all_err_random, group_id, 'Colors', colors, 'BoxStyle', 'outline', 'Widths', 0.6, 'OutlierSize', 0.0001);
set(h,{'linew'}, {1})
ylim([-0.5, 6.2]); xlim([0.5 3+0.5]); 
set(gca, 'Color', 'none', 'TickDir', 'out', 'XTickLabel', {'Seg', 'Fused', 'DLC'}, 'YTickLabel', {}, 'TickLength',[0.01, 0.01], 'Box', 'off', 'FontSize', 7)

noise_sample = length(noise_segnorm);
ax{7} = subplot('Position', [.24 .65 .16 .30]);
group_id = [ones(noise_sample, 1); 2*ones(noise_sample, 1)];
colorsScatter = [repmat(colors(1, :), noise_sample, 1); repmat(colors(2, :), noise_sample, 1)];

all_noise_random = [noise_segnorm, nois_dlcnorm]';
% scatter(group_id + (rand(size(all_noise_random))-0.5)/5, all_noise_random, 20*ones(length(group_id), 1), colorsScatter, 'filled')
% hold on
h = boxplot(all_noise_random, group_id, 'Colors', colorsBox, 'BoxStyle', 'outline', 'Widths', 0.5, 'OutlierSize', 0.0001);
hi = findobj(gca,'Tag','Box');
for j=1:length(hi)
    patch(get(hi(j), 'XData'), get(hi(j),'YData'), colorsBoxFill(j,:), 'FaceAlpha',.8);
end
set(h,{'linew'}, {1})
ylim([-60, 400]); xlim([0.5 2+0.5]); 
set(gca, 'Color', 'none', 'TickDir', 'out', 'XTickLabel', {'Seg', 'DLC'}, 'YTickLabel', {}, 'TickLength',[0.01, 0.01], 'Box', 'off', 'FontSize', 7)

%
ax{3} = subplot('Position', [.43 .10 .16 .45]);
label_resultRandom = [prepro_dataPath, 'label_result_segGood_1025.mat'];
[err_seg, err_dlc, err_fuse, noise_segnorm, nois_dlcnorm]  = calerr(prepro_dataPath, label_resultRandom);
n_sample = length(err_fuse);
group_id = [ones(n_sample, 1); 2*ones(n_sample, 1); 3*ones(n_sample, 1)];
colorsScatter = [repmat(colors(1, :), n_sample, 1); repmat(colors(2, :), n_sample, 1); repmat(colors(3, :), n_sample, 1)];

all_err_random = [abs(err_seg), abs(err_fuse), abs(err_dlc)]';
box_data_cell{3} = [abs(err_seg); abs(err_fuse); abs(err_dlc)]'; 
scatter(group_id + (rand(size(all_err_random))-0.5)/2, all_err_random, 10*ones(length(group_id), 1), colorsScatter, 'filled')
hold on
h = boxplot(all_err_random, group_id, 'Colors', colors, 'BoxStyle', 'outline', 'Widths', 0.6, 'OutlierSize', 0.0001);
set(h,{'linew'}, {1})
ylim([-0.5, 6.2]); xlim([0.5 3+0.5]); 
set(gca, 'Color', 'none', 'TickDir', 'out', 'XTickLabel', {'Seg', 'Fused', 'DLC'}, 'YTickLabel', {}, 'YTickLabel', {}, 'TickLength',[0.01, 0.01], 'Box', 'off', 'FontSize', 7)

noise_sample = length(noise_segnorm);
ax{8} = subplot('Position', [.43 .65 .16 .30]);
group_id = [ones(noise_sample, 1); 2*ones(noise_sample, 1)];
colorsScatter = [repmat(colors(1, :), noise_sample, 1); repmat(colors(2, :), noise_sample, 1)];

all_noise_random = [noise_segnorm, nois_dlcnorm]';
% scatter(group_id + (rand(size(all_noise_random))-0.5)/5, all_noise_random, 20*ones(length(group_id), 1), colorsScatter, 'filled')
% hold on
h = boxplot(all_noise_random, group_id, 'Colors', colorsBox, 'BoxStyle', 'outline', 'Widths', 0.5, 'OutlierSize', 0.0001);
hi = findobj(gca,'Tag','Box');
for j=1:length(hi)
    patch(get(hi(j), 'XData'), get(hi(j),'YData'), colorsBoxFill(j,:), 'FaceAlpha',.8);
end
set(h,{'linew'}, {1})
ylim([-60, 400]); xlim([0.5 2+0.5]); 
set(gca, 'Color', 'none', 'TickDir', 'out', 'XTickLabel', {'Seg', 'DLC'}, 'YTickLabel', {}, 'TickLength',[0.01, 0.01], 'Box', 'off', 'FontSize', 7)


%
ax{4} = subplot('Position', [.62 .10 .16 .45]);
label_resultRandom = [prepro_dataPath, 'label_result_dlcGood_1025.mat'];
[err_seg, err_dlc, err_fuse, noise_segnorm, nois_dlcnorm]  = calerr(prepro_dataPath, label_resultRandom);
n_sample = length(err_fuse);
group_id = [ones(n_sample, 1); 2*ones(n_sample, 1); 3*ones(n_sample, 1)];
colorsScatter = [repmat(colors(1, :), n_sample, 1); repmat(colors(2, :), n_sample, 1); repmat(colors(3, :), n_sample, 1)];

all_err_random = [abs(err_seg), abs(err_fuse), abs(err_dlc)]';
box_data_cell{4} = [abs(err_seg); abs(err_fuse); abs(err_dlc)]'; 
scatter(group_id + (rand(size(all_err_random))-0.5)/2, all_err_random, 10*ones(length(group_id), 1), colorsScatter, 'filled')
hold on
h = boxplot(all_err_random, group_id, 'Colors', colors, 'BoxStyle', 'outline', 'Widths', 0.6, 'OutlierSize', 0.0001);
set(h,{'linew'}, {1})
ylim([-0.5, 6.2]); xlim([0.5 3+0.5]); 
set(gca, 'Color', 'none', 'TickDir', 'out', 'XTickLabel', {'Seg', 'Fused', 'DLC'}, 'YTickLabel', {}, 'TickLength',[0.01, 0.01], 'Box', 'off', 'FontSize', 7)

noise_sample = length(noise_segnorm);
ax{9} = subplot('Position', [.62 .65 .16 .30]);
group_id = [ones(noise_sample, 1); 2*ones(noise_sample, 1)];
colorsScatter = [repmat(colors(1, :), noise_sample, 1); repmat(colors(2, :), noise_sample, 1)];

all_noise_random = [noise_segnorm, nois_dlcnorm]';
% scatter(group_id + (rand(size(all_noise_random))-0.5)/5, all_noise_random, 20*ones(length(group_id), 1), colorsScatter, 'filled')
% hold on
h = boxplot(all_noise_random, group_id, 'Colors', colorsBox, 'BoxStyle', 'outline', 'Widths', 0.5, 'OutlierSize', 0.0001);
hi = findobj(gca,'Tag','Box');
for j=1:length(hi)
    patch(get(hi(j), 'XData'), get(hi(j),'YData'), colorsBoxFill(j,:), 'FaceAlpha',.8);
end
set(h,{'linew'}, {1})
ylim([-60, 400]); xlim([0.5 2+0.5]); 
set(gca, 'Color', 'none', 'TickDir', 'out', 'XTickLabel', {'Seg', 'DLC'}, 'YTickLabel', {}, 'TickLength',[0.01, 0.01], 'Box', 'off', 'FontSize', 7)


%
ax{5} = subplot('Position', [.81 .10 .16 .45]);
label_resultRandom = [prepro_dataPath, 'label_result_allBad_1025.mat'];
[err_seg, err_dlc, err_fuse, noise_segnorm, nois_dlcnorm]  = calerr(prepro_dataPath, label_resultRandom);
n_sample = length(err_fuse);
group_id = [ones(n_sample, 1); 2*ones(n_sample, 1); 3*ones(n_sample, 1)];
colorsScatter = [repmat(colors(1, :), n_sample, 1); repmat(colors(2, :), n_sample, 1); repmat(colors(3, :), n_sample, 1)];

all_err_random = [abs(err_seg), abs(err_fuse), abs(err_dlc)]';
box_data_cell{5} = [abs(err_seg); abs(err_fuse); abs(err_dlc)]'; 
scatter(group_id + (rand(size(all_err_random))-0.5)/2, all_err_random, 10*ones(length(group_id), 1), colorsScatter, 'filled')
hold on
h = boxplot(all_err_random, group_id, 'Colors', colors, 'BoxStyle', 'outline', 'Widths', 0.6, 'OutlierSize', 0.0001);
set(h,{'linew'}, {1})
ylim([-0.5, 6.2]); xlim([0.5 3+0.5]); 
set(gca, 'Color', 'none', 'TickDir', 'out', 'XTickLabel', {'Seg', 'Fused', 'DLC'}, 'YTickLabel', {}, 'TickLength',[0.01, 0.01], 'Box', 'off', 'FontSize', 7)

noise_sample = length(noise_segnorm);
ax{10} = subplot('Position', [.81 .65 .16 .30]);
group_id = [ones(noise_sample, 1); 2*ones(noise_sample, 1)];
colorsScatter = [repmat(colors(1, :), noise_sample, 1); repmat(colors(2, :), noise_sample, 1)];

all_noise_random = [noise_segnorm, nois_dlcnorm]';
% scatter(group_id + (rand(size(all_noise_random))-0.5)/5, all_noise_random, 20*ones(length(group_id), 1), colorsScatter, 'filled')
% hold on
h = boxplot(all_noise_random, group_id, 'Colors', colorsBox, 'BoxStyle', 'outline', 'Widths', 0.5, 'OutlierSize', 0.0001);
hi = findobj(gca,'Tag','Box');
for j=1:length(hi)
    patch(get(hi(j), 'XData'), get(hi(j),'YData'), colorsBoxFill(j,:), 'FaceAlpha',.8);
end
set(h,{'linew'}, {1})
ylim([-60, 400]); xlim([0.5 2+0.5]); 
set(gca, 'Color', 'none', 'TickDir', 'out', 'XTickLabel', {'Seg', 'DLC'}, 'YTickLabel', {}, 'TickLength',[0.01, 0.01], 'Box', 'off', 'FontSize', 7)













