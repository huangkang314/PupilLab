
fs =30;
data_main = '#A4-1';
dlcFileName = [work_path, data_main, 'DLC.csv'];
isegName = [work_path, 'e', data_main]; % efile is the saved data during online recording
show = true;
pixel2mm_ratio = calp2mRatio(dlcFileName, isegName);
disp(['The ratio of data ', isegName, ' is: ', num2str(pixel2mm_ratio)])

