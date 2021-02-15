
clear
close all

work_path = 'D:\huangkang\Projects\pupilLab\code\PupilLab\data\yulinDataShort\';
data_path = dir([work_path, 'e*']);
n_data = length(data_path);

pixel2mm_ratio = zeros(1, n_data);
for i = 1:n_data
    close
    fs =30;
    data_main = data_path(i).name(2:end);
    dlcFileName = [work_path, data_main, 'DLC.csv'];
    isegName = [work_path, 'e', data_main]; % efile is the saved data during online recording
    show = true;
    pixel2mm_ratio(i) = calp2mRatio(dlcFileName, isegName);
    disp(['The ratio of data ', isegName, ' is: ', num2str(pixel2mm_ratio(i))])
end
