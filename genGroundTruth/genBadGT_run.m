
work_path = 'D:\huangkang\Projects\pupilLab\code\PupilLab\data\yulinDataShort\';
data_path = dir([work_path, 'e*']);
n_data = length(data_path);


% get total bad frames
try
    load('../genGroundTruth/pick_indexs_bad.mat')
catch
    bad_fold = 3;
    nPick_each = 14;
    nPick_total = n_data*nPick_each;
    pick_indexs = struct();
    for i = 1:n_data
        data_main = data_path(i).name(2:end);
        tem_prepro = load([work_path, data_main, '_preprocessed.mat']);
        pupil_dlc = tem_prepro.pupil.dlc;
        thrUp = mean(pupil_dlc) + std(pupil_dlc)*bad_fold;
        thrLow = mean(pupil_dlc) - std(pupil_dlc)*bad_fold;
        pick_index = find(pupil_dlc > thrUp | thrUp < thrLow);
        
        n_pick = length(pick_index);
        pick_select = sort(randperm(n_pick, nPick_each));
        pick_indexs(i).videoPath = [work_path, data_main, '.avi'];
        pick_indexs(i).index = pick_index(pick_select);

        save('../genGroundTruth/pick_indexs_bad.mat', 'pick_indexs')
    end
end


%% pick frame and label
label_results = cell(1, n_data);
%
fig = figure(1);

for i = 1:n_data
    data_main = data_path(i).name(2:end);
    video_name = [work_path, data_main, '.avi'];
    obj = VideoReader(video_name);
    
    tem_labelResults = struct();
    for iframe = 1:size(pick_indexs{1, i}, 2)
        picked_img = read(obj, pick_indexs{1, i}(iframe));
        imshow(picked_img);
        set(fig, 'Position', [100, 100, 1280, 800])
        h  =drawellipse;
        pause
        tem_labelResults(iframe).index = pick_indexs{1, i}(iframe);
        tem_labelResults(iframe).Center = h.Center;
        tem_labelResults(iframe).SemiAxes = h.SemiAxes;
        label_results{1, i} = tem_labelResults;
    end
    
end



save([work_path, 'label_result_bad.mat'], 'label_results')





