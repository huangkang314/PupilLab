
close all
clear all

%
indexPath = '.\pick_indexs_radom_1025.mat';
index = load(indexPath);
pick_indexs = index.pick_indexs;
n_data = size(pick_indexs, 2);

global result
% init myData
label_results = cell(1, n_data);
tem_labelResults = struct();

result.tem_labelResults = tem_labelResults;
result.label_results = label_results;
result.labelSaveFlag = false;

myData.indexPath = indexPath;
myData.dataID = 1;
myData.indexID = 1;
myData.pick_indexs = pick_indexs;
myData.n_data = n_data;

gtGUIf = figure('Units', 'normalized', 'Position',[.1 .1 .8 .8], 'Name', 'GenPupilGUI',...
    'MenuBar', 'none', 'NumberTitle', 'off', 'Color', [0.8 .8 .8], 'CloseRequestFcn', 'exit_save');

myData.labelAx = axes('Units', 'normalized', 'Position', [.1 .1 .8 .8]);

set(gtGUIf, 'UserData', myData);
set(gtGUIf, 'KeyPressFcn', @(gtGUIf, k)ftGUICallback(gtGUIf, k));

gtGUImain(gtGUIf)

function gtGUImain(gtGUIf)

global result
myData = get(gtGUIf, 'UserData');
pick_indexs = myData.pick_indexs;
n_data = myData.n_data;

video_name = pick_indexs(myData.dataID).videoPath;
obj = VideoReader(video_name);
tem_nPick = length(pick_indexs(myData.dataID).index);
tem_pickIndex = pick_indexs(myData.dataID).index(myData.indexID);
myData.tem_nPick = tem_nPick;

picked_img = read(obj, tem_pickIndex);

% show image
axes(myData.labelAx);
imshow(picked_img)

try
    tem_h = result.label_results{1, myData.dataID}(myData.indexID);
    h = drawellipse('Center', tem_h.Center, 'SemiAxes', tem_h.SemiAxes, 'RotationAngle', tem_h.RotationAngle, 'Color', 'g');
    %     h = customWait(h, gtGUIf);
catch
end

warning('off')
title({['Current Video: ', video_name, ' (', num2str(myData.dataID), '/', num2str(n_data), ')'], ...
    ['Current Frame: ', num2str(tem_pickIndex), ' (', num2str(myData.indexID), '/', num2str(tem_nPick), ')']
    });

set(gtGUIf, 'UserData', myData);

end


%%

function ftGUICallback(gtGUIf, keydata)

global result
myData = get(gtGUIf, 'UserData');
tem_nPick = myData.tem_nPick;
n_data = myData.n_data;
pick_indexs = myData.pick_indexs;

switch keydata.Key
    case 'uparrow' % go to previous image
        if result.labelSaveFlag == true
            if myData.indexID > 1
                myData.indexID = myData.indexID - 1;
                try
                    result.label_results{1, myData.dataID}(myData.indexID);
                    result.labelSaveFlag = true;
                catch
                    result.labelSaveFlag = false;
                end
            else
                error('This is the first image!', 'warning of first', 'error')
            end
        end
        
    case 'downarrow' % go to next image
        if result.labelSaveFlag == true
            if myData.indexID < tem_nPick
                myData.indexID = myData.indexID + 1;
                try
                    result.label_results{1, myData.dataID}(myData.indexID);
                    result.labelSaveFlag = true;
                catch
                    result.labelSaveFlag = false;
                end
            else
                error('This is the last image!')
            end
        end
    case 'leftarrow' % go to previous data
        if result.labelSaveFlag == true
            if myData.dataID > 1
                myData.dataID = myData.dataID - 1;
                myData.indexID = 1;
                try
                    result.label_results{1, myData.dataID}(myData.indexID);
                    result.labelSaveFlag = true;
                catch
                    result.labelSaveFlag = false;
                end
            else
                error('This is the first data!')
            end
        end
        
    case 'rightarrow' % go to next data
        if result.labelSaveFlag == true
            if myData.dataID < n_data
                myData.dataID = myData.dataID + 1;
                myData.indexID = 1;
                try
                    result.label_results{1, myData.dataID}(myData.indexID);
                    result.labelSaveFlag = true;
                catch
                    result.labelSaveFlag = false;
                end
            else
                error('This is the last data!')
            end
        end
        
    case 'space'
        h  =drawellipse('Color', 'g');
        h = customWait(h, gtGUIf);
    case 'q'
        result.labelSaveFlag = true;
        result.labelSaveFlag = true;
        result.tem_labelResults(myData.indexID).index = pick_indexs(myData.dataID).index(myData.indexID);
        result.tem_labelResults(myData.indexID).Center = [];
        result.tem_labelResults(myData.indexID).SemiAxes = [];
        result.tem_labelResults(myData.indexID).RotationAngle = h.RotationAngle;
        result.tem_labelResults(myData.indexID).h = [];
        result.label_results{1, myData.dataID} = result.tem_labelResults;
        if myData.indexID < tem_nPick
            myData.indexID = myData.indexID + 1;
            try
                result.label_results{1, myData.dataID}(myData.indexID);
                result.labelSaveFlag = true;
            catch
                result.labelSaveFlag = false;
            end
        else
            error('This is the last image!')
        end
        
end

set(gtGUIf, 'UserData', myData);
gtGUImain(gtGUIf)
end

function h = customWait(hROI, gtGUIf)

global result
myData = get(gtGUIf, 'UserData');

pick_indexs = myData.pick_indexs;
tem_pickIndex = pick_indexs(myData.dataID).index(myData.indexID);
video_name = pick_indexs(myData.dataID).videoPath;

% Listen for mouse clicks on the ROI
l = addlistener(hROI,'ROIClicked',@clickCallback);

set(gtGUIf, 'KeyPressFcn', []);

% Block program execution
uiwait;

% Remove listener
delete(l);

% Return the current position
h = hROI;
result.labelSaveFlag = true;
result.tem_labelResults(myData.indexID).index = pick_indexs(myData.dataID).index(myData.indexID);
result.tem_labelResults(myData.indexID).Center = h.Center;
result.tem_labelResults(myData.indexID).SemiAxes = h.SemiAxes;
result.tem_labelResults(myData.indexID).RotationAngle = h.RotationAngle;
result.tem_labelResults(myData.indexID).h = h;
result.label_results{1, myData.dataID} = result.tem_labelResults;
disp([video_name, ' frame: ', num2str(tem_pickIndex), ' has been labled'])

set(gtGUIf, 'WindowKeyPressFcn', @(gtGUIf, k)ftGUICallback(gtGUIf, k));

end


function clickCallback(~,evt)

if strcmp(evt.SelectionType,'double')
    uiresume;
end

end



%
% %% pick frame and label
% label_results = cell(1, n_data);
% %
% fig = figure(1);
%
% for i = 1:n_data
%     data_main = data_path(i).name(2:end);
%     video_name = [work_path, data_main, '.avi'];
%     obj = VideoReader(video_name);
%
%     tem_labelResults = struct();
%     for iframe = 1:size(pick_indexs{1, i}, 1)
%         picked_img = read(obj, pick_indexs{1, i}(iframe));
%         imshow(picked_img);
%         set(fig, 'Position', [100, 100, 1280, 800])
%         title(['video:', num2str(i), ' frame:', num2str(iframe)])
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
% save([work_path, 'label_result_segGood.mat'], 'label_results')