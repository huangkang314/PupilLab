addpath('./preprocess')
clear
% close all

%% define the data path
% The csv files with the suffix 'DLC' are the pupil landmarks coordinate extracted by DLC
% The files with the prefix 'e' is the pupil features extracted by image segmentation
work_path = '.\data\';
pixel2mm_data = load('.\data\pixel2mmratio.mat');
pixel2mm_ratio = pixel2mm_data.pixel2mm_ratio;
data_path = dir([work_path, 'e*']);
n_data = length(data_path);
show = false;
%% Run this section will fuse the pupil features extracted from DLC and image sefmentation
% The fused data will be save as '_preprocessed.mat' suffixed matlab
% dataset
for i = 1:n_data
    fs =30;
    data_main = data_path(i).name(2:end);
    dlcFileName = [work_path, data_main, 'DLC.csv'];
    isegName = [work_path, 'e', data_main]; % efile is the saved data during online recording
    pupil = fuse_dlc_iseg(fs, dlcFileName, isegName, 1/pixel2mm_ratio(i), show);
    save([work_path, data_main, '_preprocessed'], 'pupil')
end



