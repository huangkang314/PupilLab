
work_path = 'D:\huangkang\Projects\pupilLab\code\PupilLab\data\yulinDataShort\';
data_path = dir([work_path, 'e*']);
n_data = length(data_path);

% get the informatin of all videos
video_frames = zeros(1, n_data);
for i = 1:n_data
    data_main = data_path(i).name(2:end);                   
    video_name = [work_path, data_main, '.avi'];
    obj = VideoReader(video_name);
    video_frames(1, i) = obj.NumFrames;
end

total_frames = sum(video_frames);
%% radom pick frames

try
    load('./genGroundTruth/pick_indexs_radom_1025.mat')
catch
    nPick_total = 140;
    nPicks = round(nPick_total * (video_frames/total_frames));
    
    pick_indexs = struct();
    for i = 1:n_data
        data_main = data_path(i).name(2:end);           
        pick_index = randperm(video_frames(1, i), nPicks(i));
        pick_indexs(i).videoPath = [work_path, data_main, '.avi'];
        pick_indexs(i).index = pick_index;
    end
    
    save('./pick_indexs_radom_1025.mat', 'pick_indexs')
end


% % pick frame and label
% label_results = cell(1, n_data);
% %%
% fig = figure(1);
% 
% for i = 1:n_data
%     data_main = data_path(i).name(2:end);
%     video_name = [work_path, data_main, '.avi'];
%     obj = VideoReader(video_name);
%     
%     tem_labelResults = struct();
%     for iframe = 1:size(pick_indexs{1, i}, 2)
%         picked_img = read(obj, pick_indexs{1, i}(iframe));
%         imshow(picked_img);
%         set(fig, 'Position', [100, 100, 1280, 800])
%         h  =drawellipse;
%         pause
%         tem_labelResults(iframe).index = pick_indexs{1, i}(iframe);
%         tem_labelResults(iframe).Center = h.Center;
%         tem_labelResults(iframe).SemiAxes = h.SemiAxes;
%         label_results{1, i} = tem_labelResults;
%     end
%     
% end
% 
% 
% save([work_path, 'label_result_radom.mat'], 'label_results')