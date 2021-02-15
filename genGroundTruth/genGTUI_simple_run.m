
close all
clear all

%
indexPath = '.\pick_indexs_allBad_1025.mat';
index = load(indexPath);
pick_indexs = index.pick_indexs;
n_data = size(pick_indexs, 2);

global result
global myData
% init myData
label_results = cell(1, n_data);
tem_labelResults = struct();

result.tem_labelResults = tem_labelResults;
result.label_results = label_results;

myData.indexPath = indexPath;
myData.lastdataID = 0;
myData.dataID = 1;
myData.indexID = 1;
myData.pick_indexs = pick_indexs;
myData.n_data = n_data;
myData.nLabeled = 0;

gtGUIf = figure('Units', 'normalized', 'Position',[.1 .1 .8 .8], 'Name', 'GenPupilGUI',...
    'MenuBar', 'none', 'NumberTitle', 'off', 'Color', [0.8 .8 .8], 'CloseRequestFcn', 'exit_save');

myData.labelAx = axes('Units', 'normalized', 'Position', [.1 .1 .8 .8]);

% set(gtGUIf, 'UserData', myData);
set(gtGUIf, 'KeyPressFcn', @(gtGUIf, k)ftGUICallback(gtGUIf, k));

gtGUImain(gtGUIf)

function gtGUImain(gtGUIf)
global myData
global result

% myData = get(gtGUIf, 'UserData');

pick_indexs = myData.pick_indexs;
n_data = myData.n_data;

if myData.lastdataID ~= myData.dataID
    video_name = pick_indexs(myData.dataID).videoPath;
    obj = VideoReader(video_name);
    myData.temObj = obj;
    myData.temVideo_name = video_name;
    tem_nPick = length(pick_indexs(myData.dataID).index);
    myData.tem_nPick = tem_nPick;
    myData.lastdataID = myData.lastdataID + 1 ;
    result.tem_labelResults = [];
end

tem_pickIndex = pick_indexs(myData.dataID).index(myData.indexID);
picked_img = read(myData.temObj, tem_pickIndex);

% show image
axes(myData.labelAx);
imshow(picked_img)

warning('off')
title({['Current Video: ', myData.temVideo_name, ' (', num2str(myData.dataID), '/', num2str(n_data), ')'], ...
    ['Current Frame: ', num2str(tem_pickIndex), ' (', num2str(myData.indexID), '/', num2str(myData.tem_nPick), ')'], ...
    ['You have labeled ', num2str(myData.nLabeled), ' frames']});

% set(gtGUIf, 'UserData', myData);

end


%%

function ftGUICallback(gtGUIf, keydata)

global result
global myData
% myData = get(gtGUIf, 'UserData');

tem_nPick = myData.tem_nPick;
pick_indexs = myData.pick_indexs;
tem_pickIndex = pick_indexs(myData.dataID).index(myData.indexID);

switch keydata.Key
    
    case 'space'
        h  =drawellipse('Color', 'g');
        h = customWait(h, gtGUIf);
    case 'q'
        result.tem_labelResults(myData.indexID).index = pick_indexs(myData.dataID).index(myData.indexID);
        result.tem_labelResults(myData.indexID).Center = [];
        result.tem_labelResults(myData.indexID).SemiAxes = [];
        result.tem_labelResults(myData.indexID).RotationAngle = [];
        result.tem_labelResults(myData.indexID).h = [];
        result.label_results{1, myData.dataID} = result.tem_labelResults;
        disp([myData.temVideo_name, ' frame: ', num2str(tem_pickIndex), ' has been abandoned!'])
        
        % go to next frame
        if myData.indexID < tem_nPick
            myData.indexID = myData.indexID + 1;
        elseif myData.indexID == tem_nPick && myData.dataID < myData.n_data
            myData.dataID = myData.dataID + 1;
            myData.indexID = 1;
        else
            error('This is the last image!')
        end
        
end

% set(gtGUIf, 'UserData', myData);
gtGUImain(gtGUIf)
end

function h = customWait(hROI, gtGUIf)

global result
global myData
% myData = get(gtGUIf, 'UserData');

tem_nPick = myData.tem_nPick;
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
result.tem_labelResults(myData.indexID).index = pick_indexs(myData.dataID).index(myData.indexID);
result.tem_labelResults(myData.indexID).Center = h.Center;
result.tem_labelResults(myData.indexID).SemiAxes = h.SemiAxes;
result.tem_labelResults(myData.indexID).RotationAngle = h.RotationAngle;
result.tem_labelResults(myData.indexID).h = h;
result.label_results{1, myData.dataID} = result.tem_labelResults;

disp([video_name, ' frame: ', num2str(tem_pickIndex), ' has been labled'])
myData.nLabeled = myData.nLabeled +1;

% go to next frame
if myData.indexID < tem_nPick
    myData.indexID = myData.indexID + 1;
elseif myData.indexID == tem_nPick && myData.dataID < myData.n_data
    myData.dataID = myData.dataID + 1;
    myData.indexID = 1;
else
    error('This is the last image!')
end

set(gtGUIf, 'WindowKeyPressFcn', @(gtGUIf, k)ftGUICallback(gtGUIf, k));

% set(gtGUIf, 'UserData', myData);
gtGUImain(gtGUIf)

end


function clickCallback(~,evt)

if strcmp(evt.SelectionType,'double')
    uiresume;
end

end


