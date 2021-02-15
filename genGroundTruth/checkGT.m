% load data

work_path = 'D:\huangkang\Projects\pupilLab\code\PupilLab\data\yulinDataShort\';
data_path = dir([work_path, 'e*']);
n_data = length(data_path);
result = load([work_path, 'label_result_allBad_1025.mat']);
pick_index = load('.\pick_indexs_allBad_1025.mat');
pick_indexs = pick_index.pick_indexs;

label_result = result.label_results;

for i = 1:n_data
    tem_label = label_result{i};
    if ~isempty(tem_label)
        video_name = pick_indexs(i).videoPath;
        tem_pickIndex = pick_indexs(i).index;
        tem_labelIndex = {label_result{i}.index};
        n_index = length(tem_pickIndex);
        obj = VideoReader(video_name);
        h = label_result{i};
        
        for iFrame = 1:n_index
            if ~isempty(h(iFrame).Center)
                if tem_pickIndex(iFrame) ~= tem_labelIndex{iFrame}
                    disp('Mismatch label found!')
                end
                picked_img = read(obj, tem_pickIndex(iFrame));
                % show image
                imshow(picked_img)
                tem_h = h(iFrame);
                drawellipse('Center', tem_h.Center, 'SemiAxes', tem_h.SemiAxes, 'RotationAngle', tem_h.RotationAngle, 'Color', 'g');
                pause
            end
        end  
    end

end